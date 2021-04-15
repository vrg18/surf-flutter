import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:places/data/provider/current_theme.dart';
import 'package:places/data/provider/is_web.dart';
import 'package:places/data/provider/sight_provider.dart';
import 'package:places/data/service/nearby_sights.dart';
import 'package:places/domain/sight.dart';
import 'package:places/ui/res/colors.dart';
import 'package:places/ui/res/sizes.dart';
import 'package:places/ui/res/strings.dart';
import 'package:places/ui/res/text_styles.dart';
import 'package:places/ui/screen/new_sight/new_sight.dart';
import 'package:places/ui/screen/sight_list_and_search/search_bar.dart';
import 'package:places/ui/screen/sight_list_and_search/sight_search.dart';
import 'package:places/ui/screen/web_wrapper.dart';
import 'package:places/ui/screen/widgets/sight_card.dart';
import 'package:provider/provider.dart';

/// Экран с основным списком мест
class SightList extends StatefulWidget {
  @override
  _SightListState createState() => _SightListState();
}

class _SightListState extends State<SightList> with SingleTickerProviderStateMixin {
  late NearbySights _nearbySights;
  late List<Sight> _listOfNearbySights;

  @override
  void initState() {
    super.initState();
    _nearbySights = context.read<SightProvider>().nearbySights;
    _listOfNearbySights = List.from(_nearbySights.listOfNearbySights);
    _nearbySights.saveFilterSettings();
  }

  @override
  Widget build(BuildContext context) {
    bool isDark = context.watch<CurrentTheme>().isDark;
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: isDark ? Brightness.light : Brightness.dark,
    ));

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.only(
            top: context.read<Web>().isWeb ? additionalPaddingAboveTopBar : 0,
            left: basicBorderSize,
            right: basicBorderSize,
          ),
          child: CustomScrollView(
            slivers: [
              SliverAppBar(
//                    snap: true,
//                    floating: true,
                pinned: true,
                elevation: 0,
                title: Text(
                  firstLandscapeScreenTitle,
                  style: screenTitleStyle.apply(color: isDark ? lightMainBackgroundColor : darkMainBackgroundColor),
                ),
                centerTitle: true,
                expandedHeight: appBarTitleHeight + heightBigSwitchAndSearchLine + basicBorderSize,
                toolbarHeight: appBarTitleHeight,
                collapsedHeight: appBarTitleHeight,
                backgroundColor: isDark ? darkMainBackgroundColor : lightMainBackgroundColor,
                flexibleSpace: Padding(
                  padding: const EdgeInsets.only(top: appBarTitleHeight),
                  child: Align(
                    alignment: Alignment.topCenter,
                    child: SizedBox(
                      height: heightBigSwitchAndSearchLine,
                      child: _searchBar(),
                    ),
                  ),
                ),
              ),
              SliverGrid.extent(
                maxCrossAxisExtent: wideScreenSizeOver,
                crossAxisSpacing: basicBorderSize,
                mainAxisSpacing: basicBorderSize * 1.25,
                childAspectRatio: 1.75,
                children: _listOfNearbySights
                    .map((e) => SightCard(
                          sight: e,
                          cornerIcon: Icons.favorite_border,
                        ))
                    .toList(),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: _getButtonNewLocation(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }

  /// Строка поиска
  Widget _searchBar() {
    return SearchBar(
      callbackPressing: () => _clickingOnSearchWidget(),
      callbackChangedFilters: () => _filtersHaveBeenChanged(),
      callbackCanceledFilters: () => _nearbySights.filtersHaveBeenCanceled(),
    );
  }

  /// Кнопка "Новое место" с градиентной заливкой
  Widget _getButtonNewLocation() {
    return ClipRRect(
      borderRadius: BorderRadius.circular(heightOfBigGreenButton / 2),
      child: Container(
        height: heightOfBigGreenButton,
        width: widthOfNewSightButton,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [newSightButtonLeftColor, newSightButtonRightColor],
          ),
        ),
        child: MaterialButton(
          onPressed: () => _clickingOnNewSight(),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Icon(
                Icons.add,
                color: bigGreenButtonLabelColor,
                size: 28,
              ),
              Text(
                letteringNewSight,
                style: activeBigGreenButtonTextStyle,
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// Обработка нажатия на виджет поиска
  void _clickingOnSearchWidget() {
    Navigator.push(context,
        MaterialPageRoute(builder: (_) => context.read<Web>().isWeb ? WebWrapper(SightSearch()) : SightSearch()));
    context.read<SightProvider>().cancelSearch();
  }

  /// Обработка нажатия на виджет поиска
  void _clickingOnNewSight() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => context.read<Web>().isWeb ? WebWrapper(NewSight()) : NewSight(),
      ),
    ).then((needRefresh) {
      if (needRefresh != null && needRefresh)
        setState(() {
          _listOfNearbySights = List.from(_nearbySights.listOfNearbySights);
        });
    });
  }

  /// Метод обновляет список мест и выполняется при возврате из экрана фильтров по кнопке "Показать"
  void _filtersHaveBeenChanged() {
    setState(() {
      _listOfNearbySights = List.from(_nearbySights.listOfNearbySights);
      _nearbySights.saveFilterSettings();
    });
  }
}

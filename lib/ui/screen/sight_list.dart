import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:places/domain/category.dart';
import 'package:places/domain/current_theme.dart';
import 'package:places/domain/nearby_sights.dart';
import 'package:places/domain/sight.dart';
import 'package:places/ui/res/colors.dart';
import 'package:places/ui/res/icons.dart';
import 'package:places/ui/res/sizes.dart';
import 'package:places/ui/res/strings.dart';
import 'package:places/ui/res/text_styles.dart';
import 'package:places/ui/screen/buttons/universal_white_button.dart';
import 'package:places/ui/screen/new_sight/new_sight.dart';
import 'package:places/ui/screen/widgets/search_bar.dart';
import 'package:places/ui/screen/widgets/sight_card.dart';
import 'package:places/ui/screen/widgets/sight_card_mini.dart';
import 'package:places/ui/screen/widgets/top_bar.dart';
import 'package:provider/provider.dart';

/// Экран с основным списком мест
class SightList extends StatefulWidget {
  @override
  _SightListState createState() => _SightListState();
}

class _SightListState extends State<SightList> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  late List<Sight> _listOfNearbySights;
  late List<Category> _tempSelectedCategories;
  late int _tempStartOfSearchRadius;
  late int _tempEndOfSearchRadius;
  late bool _isDark;

  @override
  void initState() {
    super.initState();
    _isDark = context.read<CurrentTheme>().isDark;
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: _isDark ? Brightness.light : Brightness.dark,
    ));
    _tabController = TabController(length: 2, vsync: this);
    _tabController.index;
    _tabController.addListener(() {
      setState(() {});
    });
    _listOfNearbySights = List.from(context.read<NearbySights>().listOfNearbySights);
    _saveFilterSettings();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TopBar(
        titleHeight: appBarTitleHeight,
        title: Text(
          firstLandscapeScreenTitle,
          style: screenTitleStyle,
          overflow: TextOverflow.ellipsis,
        ),
        bottomHeight: heightBigSwitchAndSearchLine,
        bottom: SearchBar(
          onlyPressing: _tabController.index == 0,
          callbackPressing: () => _clickingOnSearchWidget(),
          callbackCancelSearch: () => _clickingOnCancelSearch(),
          callbackChangedFilters: () => _filtersHaveBeenChanged(),
          callbackCanceledFilters: () => _filtersHaveBeenCanceled(),
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        physics: NeverScrollableScrollPhysics(),
        children: [
          Padding(
            padding: const EdgeInsets.only(left: basicBorderSize, right: basicBorderSize, top: basicBorderSize),
            child: GridView.extent(
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
          ),
          context.watch<NearbySights>().isSearchStringEmpty ? _searchHistory() : _sightsSearchStreamBuilder(),
        ],
      ),
      floatingActionButton: _tabController.index == 0 ? _getButtonNewLocation() : null,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }

  /// Возвращает историю поиска
  Widget _searchHistory() {
    bool _isSearchHistoryEmpty = context.watch<NearbySights>().listOfSearchHistory.length == 0;

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 32),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: basicBorderSize),
            child: Text(letteringYouWereLookingFor, style: addSightSectionLabelAndHintTextStyle),
          ),
          const SizedBox(height: 8),
          if (!_isSearchHistoryEmpty)
            Column(children: context.watch<NearbySights>().listOfSearchHistory.map((e) => _historyLine(e)).toList()),
          const SizedBox(height: 20),
          if (!_isSearchHistoryEmpty)
            Row(
              children: [
                UniversalWhiteButton(
                  label: letteringClearHistory,
                  textStyle: clearFiltersButtonTextStyle,
                  callback: () => setState(() => context.read<NearbySights>().listOfSearchHistory.clear()),
                ),
              ],
            )
        ],
      ),
    );
  }

  /// Возвращает одну строку истории
  Widget _historyLine(Sight sight) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: basicBorderSize),
      child: Container(
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(
              width: 0.8,
              color: _isDark ? darkElementTertiaryColor : lightDarkerBackgroundColor,
            ),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              sight.name,
              style: lightFiltersDistanceValueStyle,
            ),
            IconButton(
              onPressed: () => setState(() => context.read<NearbySights>().listOfSearchHistory.remove(sight)),
              icon: Icon(
                Icons.clear,
                color: lightElementTertiaryColor,
                size: 20,
              ),
            )
          ],
        ),
      ),
    );
  }

  /// Возвращает результат поиска мест
  Widget _sightsSearchStreamBuilder() {
    return Padding(
      padding: const EdgeInsets.only(left: basicBorderSize, right: basicBorderSize, top: basicBorderSize),
      child: StreamBuilder<List<Sight>>(
        stream: context.watch<NearbySights>().streamSights,
        builder: (context, snapshot) {
          print('Has error: ${snapshot.hasError}');
          print('Has data: ${snapshot.hasData}');
          print('Snapshot Data: ${snapshot.data}');
          print('ConnectionState: ${snapshot.connectionState}');
          if (snapshot.hasError) {
            return Icon(
              Icons.error_outline,
              color: Colors.red,
              size: 40,
            );
          } else {
            switch (snapshot.connectionState) {
              case ConnectionState.none:
                return Icon(
                  Icons.info,
                  color: Colors.blue,
                  size: 40,
                );
              case ConnectionState.waiting:
                return Center(
                  child: SizedBox(
                    child: const CircularProgressIndicator(),
                    width: 40,
                    height: 40,
                  ),
                );
              case ConnectionState.active:
              // return Icon(
              //   Icons.check_circle_outline,
              //   color: Colors.green,
              //   size: 60,
              // );
              case ConnectionState.done:
                List<Sight> sights = snapshot.data!;
                return sights.length > 0
                    ? GridView.extent(
                        maxCrossAxisExtent: wideScreenSizeOver,
                        crossAxisSpacing: basicBorderSize,
                        mainAxisSpacing: basicBorderSize,
                        childAspectRatio: 6,
                        children: sights.map((e) => SightCardMini(e)).toList(),
                      )
                    : _stubNothingFound();
              default:
                return const SizedBox.shrink();
            }
          }
        },
      ),
    );
  }

  /// Заглушка "Ничего не найдено"
  Widget _stubNothingFound() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(
          searchIcon,
          color: translucent56TertiaryColor,
          size: 64,
        ),
        SizedBox(height: 32),
        Text(
          letteringNothingFound,
          style: nothingFoundTextStyle,
        ),
        SizedBox(height: 8),
        Text(
          letteringTryChangingSearch,
          style: tryChangingSearchTextStyle,
        )
      ],
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
          onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => NewSight())).then((needRefresh) {
            if (needRefresh != null && needRefresh)
              setState(() {
                _listOfNearbySights = List.from(context.read<NearbySights>().listOfNearbySights);
              });
          }),
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

  /// Обработка нажаития на виджет поиска
  _clickingOnSearchWidget() {
    _tabController.index = 1;
  }

  /// Обработка нажаития на иконку отмены поиска
  _clickingOnCancelSearch() {
    _tabController.index = 0;
    context.read<NearbySights>().cancelSearch();
  }

  /// Метод обновляет список мест и выполняется при возврате из экрана фильтров по кнопке "Показать"
  _filtersHaveBeenChanged() {
    setState(() {
      _listOfNearbySights = List.from(context.read<NearbySights>().listOfNearbySights);
      _saveFilterSettings();
    });
  }

  /// Метод "откатывает" настройки фильтров, выполняется при возврате из экрана фильтров по кнопке "Назад/Отмена"
  _filtersHaveBeenCanceled() {
    NearbySights nearbySights = context.read<NearbySights>();
    nearbySights.selectedCategories = List<Category>.from(_tempSelectedCategories);
    nearbySights.startOfSearchRadius = _tempStartOfSearchRadius;
    nearbySights.endOfSearchRadius = _tempEndOfSearchRadius;
    nearbySights.fillListOfNearbySights();
  }

  /// Метод сохраняет настройки фильтров для возможности "откатить" изменения фильтров
  _saveFilterSettings() {
    NearbySights nearbySights = context.read<NearbySights>();
    _tempSelectedCategories = List<Category>.from(nearbySights.selectedCategories);
    _tempStartOfSearchRadius = nearbySights.startOfSearchRadius;
    _tempEndOfSearchRadius = nearbySights.endOfSearchRadius;
  }
}

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:places/data/provider/current_theme.dart';
import 'package:places/data/provider/is_web.dart';
import 'package:places/data/provider/sight_provider.dart';
import 'package:places/data/service/nearby_sights.dart';
import 'package:places/domain/sight.dart';
import 'package:places/ui/res/colors.dart';
import 'package:places/ui/res/icons.dart';
import 'package:places/ui/res/sizes.dart';
import 'package:places/ui/res/strings.dart';
import 'package:places/ui/res/text_styles.dart';
import 'package:places/ui/screen/buttons/universal_white_button.dart';
import 'package:places/ui/screen/new_sight/new_sight.dart';
import 'package:places/ui/screen/web_wrapper.dart';
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
  late NearbySights _nearbySights;
  late List<Sight> _listOfNearbySights;

//  late bool _isDark;
  late Stream<List<Sight>> _streamSights;

  @override
  void initState() {
    super.initState();
//    _isDark = context.read<CurrentTheme>().isDark;
//     SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
//       statusBarColor: Colors.transparent,
//       statusBarIconBrightness: _isDark ? Brightness.light : Brightness.dark,
//     ));
    _tabController = TabController(length: 2, vsync: this);
    _tabController.index;
    _tabController.addListener(() {
      setState(() {});
    });
    _nearbySights = context.read<SightProvider>().nearbySights;
    _listOfNearbySights = List.from(_nearbySights.listOfNearbySights);
    _streamSights = context.read<SightProvider>().searchSights.streamSights;
    _nearbySights.saveFilterSettings();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    bool isDark = context.watch<CurrentTheme>().isDark;
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: isDark ? Brightness.light : Brightness.dark,
    ));

    return TabBarView(
      controller: _tabController,
      physics: NeverScrollableScrollPhysics(),
      children: [
        Scaffold(
          body: Padding(
            padding: const EdgeInsets.only(top: 0, left: basicBorderSize, right: basicBorderSize),
            child: SafeArea(
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
                          child: _searchBar(true),
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
          floatingActionButton: _tabController.index == 0 ? _getButtonNewLocation() : null,
          floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        ),
        Scaffold(
          appBar: _searchBarWithTitle(false),
          body: context.watch<SightProvider>().searchSights.isSearchStringEmpty
              ? _searchHistory(isDark)
              : _sightsSearchStreamBuilder(),
        ),
      ],
    );
  }

  /// Строка поиска с заголовком
  PreferredSizeWidget _searchBarWithTitle(bool onlyPressing) {
    return TopBar(
      titleHeight: appBarTitleHeight,
      title: Text(
        firstLandscapeScreenTitle,
        style: screenTitleStyle,
        overflow: TextOverflow.ellipsis,
      ),
      bottomHeight: heightBigSwitchAndSearchLine,
      bottom: Padding(
        padding: const EdgeInsets.symmetric(horizontal: basicBorderSize),
        child: _searchBar(onlyPressing),
      ),
      isWeb: context.read<Web>().isWeb,
    );
  }

  /// Строка поиска
  Widget _searchBar(bool onlyPressing) {
    return SearchBar(
      onlyPressing: onlyPressing,
      callbackPressing: () => _clickingOnSearchWidget(),
      callbackCancelSearch: () => _clickingOnCancelSearch(),
      callbackChangedFilters: () => _filtersHaveBeenChanged(),
      callbackCanceledFilters: () => _nearbySights.filtersHaveBeenCanceled(),
    );
  }

  /// История поиска
  Widget _searchHistory(bool isDark) {
    bool _isSearchHistoryEmpty = context.watch<SightProvider>().searchSights.listOfSearchHistory.length == 0;

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
            Column(
                children: context
                    .watch<SightProvider>()
                    .searchSights
                    .listOfSearchHistory
                    .map((e) => _historyLine(e, isDark))
                    .toList()),
          const SizedBox(height: 20),
          if (!_isSearchHistoryEmpty)
            Row(
              children: [
                const SizedBox(width: 12),
                UniversalWhiteButton(
                  label: letteringClearHistory,
                  textStyle: clearFiltersButtonTextStyle,
                  callback: () =>
                      setState(() => context.read<SightProvider>().searchSights.listOfSearchHistory.clear()),
                ),
              ],
            )
        ],
      ),
    );
  }

  /// Возвращает одну строку истории
  Widget _historyLine(Sight sight, bool isDark) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: basicBorderSize),
      child: Container(
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(
              width: 0.8,
              color: isDark ? darkElementTertiaryColor : lightDarkerBackgroundColor,
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
              onPressed: () =>
                  setState(() => context.read<SightProvider>().searchSights.listOfSearchHistory.remove(sight)),
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
    return StreamBuilder<List<Sight>>(
      stream: _streamSights,
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
              return sights.isEmpty
                  ? _stubNothingFound()
                  : Padding(
                      padding:
                          const EdgeInsets.only(left: basicBorderSize, right: basicBorderSize, top: basicBorderSize),
                      child: GridView.extent(
                        maxCrossAxisExtent: wideScreenSizeOver,
                        crossAxisSpacing: basicBorderSize,
                        mainAxisSpacing: basicBorderSize,
                        childAspectRatio: 6,
                        children: sights.map((e) => SightCardMini(e)).toList(),
                      ),
                    );
            default:
              return const SizedBox.shrink();
          }
        }
      },
    );
  }

  /// Заглушка "Ничего не найдено"
  Widget _stubNothingFound() {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
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
      ),
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
          onPressed: () => Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => context.read<Web>().isWeb ? WebWrapper(NewSight()) : NewSight(),
            ),
          ).then((needRefresh) {
            if (needRefresh != null && needRefresh)
              setState(() {
                _listOfNearbySights = List.from(_nearbySights.listOfNearbySights);
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

  /// Обработка нажатия на виджет поиска
  _clickingOnSearchWidget() {
    _tabController.index = 1;
    context.read<SightProvider>().cancelSearch();
  }

  /// Обработка нажатия на иконку отмены поиска
  _clickingOnCancelSearch() {
    _tabController.index = 0;
  }

  /// Метод обновляет список мест и выполняется при возврате из экрана фильтров по кнопке "Показать"
  _filtersHaveBeenChanged() {
    setState(() {
      _listOfNearbySights = List.from(_nearbySights.listOfNearbySights);
      _nearbySights.saveFilterSettings();
    });
  }
}

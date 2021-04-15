import 'package:flutter/material.dart';
import 'package:places/data/provider/current_theme.dart';
import 'package:places/data/provider/is_web.dart';
import 'package:places/data/provider/sight_provider.dart';
import 'package:places/domain/sight.dart';
import 'package:places/ui/res/colors.dart';
import 'package:places/ui/res/icons.dart';
import 'package:places/ui/res/sizes.dart';
import 'package:places/ui/res/strings.dart';
import 'package:places/ui/res/text_styles.dart';
import 'package:places/ui/screen/buttons/universal_white_button.dart';
import 'package:places/ui/screen/sight_list_and_search/search_bar.dart';
import 'package:places/ui/screen/widgets/sight_card_mini.dart';
import 'package:places/ui/screen/widgets/top_bar.dart';
import 'package:provider/provider.dart';

class SightSearch extends StatefulWidget {
  @override
  _SightSearchState createState() => _SightSearchState();
}

class _SightSearchState extends State<SightSearch> {
  late Stream<List<Sight>> _streamSights;

  void initState() {
    super.initState();
    _streamSights = context.read<SightProvider>().searchSights.streamSights;
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
        bottom: Padding(
          padding: const EdgeInsets.symmetric(horizontal: basicBorderSize),
          child: SearchBar(callbackCancelSearch: () => Navigator.pop(context)),
        ),
        isWeb: context.read<Web>().isWeb,
      ),
      body: context.watch<SightProvider>().searchSights.isSearchStringEmpty
          ? _searchHistory()
          : _sightsSearchStreamBuilder(),
    );
  }

  /// История поиска
  Widget _searchHistory() {
    bool isDark = context.read<CurrentTheme>().isDark;
    bool isSearchHistoryEmpty = context.watch<SightProvider>().searchSights.listOfSearchHistory.length == 0;

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
          if (!isSearchHistoryEmpty)
            Column(
                children: context
                    .watch<SightProvider>()
                    .searchSights
                    .listOfSearchHistory
                    .map((e) => _historyLine(e, isDark))
                    .toList()),
          const SizedBox(height: 20),
          if (!isSearchHistoryEmpty)
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
}

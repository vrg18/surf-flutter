import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:places/domain/current_theme.dart';
import 'package:places/mocks.dart';
import 'package:places/ui/res/colors.dart';
import 'package:places/ui/res/sizes.dart';
import 'package:places/ui/res/strings.dart';
import 'package:places/ui/res/text_styles.dart';
import 'package:places/ui/screen/sight_card.dart';
import 'package:places/ui/screen/top_bar.dart';
import 'package:provider/provider.dart';

/// Экран Избранное
class Favorites extends StatefulWidget {
  @override
  _FavoritesState createState() => _FavoritesState();
}

class _FavoritesState extends State<Favorites> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: context.read<CurrentTheme>().isDark ? Brightness.light : Brightness.dark,
    ));
    _tabController = TabController(length: 2, vsync: this);
    _tabController.index;
    _tabController.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    super.dispose();
    _tabController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TopBar(
        titleHeight: appBarTitleHeight,
        bottomHeight: heightSwitchOnScreenFavorites + basicBorderSize,
        title: Text(
          headerFavorites,
          style: screenTitleStyle,
          overflow: TextOverflow.ellipsis,
        ),
        bottom: _customSwitch(),
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: basicBorderSize),
        child: TabBarView(
          controller: _tabController,
          children: [
            _subScreen([mocks[1], mocks[2]]),
            _subScreen([mocks[0]]),
          ],
        ),
      ),
    );
  }

  /// Большой-пребольшой Tab-Switch
  Container _customSwitch() {
    return Container(
      margin: const EdgeInsets.only(left: basicBorderSize, right: basicBorderSize, bottom: basicBorderSize),
      height: heightSwitchOnScreenFavorites,
      child: Stack(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(heightSwitchOnScreenFavorites / 2),
            child: Material(
              color: context.watch<CurrentTheme>().isDark ? darkDarkerBackgroundColor : lightDarkerBackgroundColor,
              child: InkWell(
                onTap: () => _tabController.index = 1 - _tabController.index,
                child: Row(
                  children: [
                    _halfSwitchBase(switchLabelWantToVisit),
                    _halfSwitchBase(switchLabelVisited),
                  ],
                ),
              ),
            ),
          ),
          Row(
            children: _tabController.index == 0
                ? [
                    _activatedPartOfSwitch(),
                    Spacer(),
                  ]
                : [
                    Spacer(),
                    _activatedPartOfSwitch(),
                  ],
          ),
        ],
      ),
    );
  }

  /// Половинка подложки таб-свитча с надписью
  Widget _halfSwitchBase(String text) {
    return Expanded(
      child: Center(
        child: Text(
          text,
          style: lowSelection700Style,
        ),
      ),
    );
  }

  /// "Движок" таб-свитча
  Widget _activatedPartOfSwitch() {
    return Expanded(
      child: Container(
        decoration: BoxDecoration(
          color: context.watch<CurrentTheme>().isDark ? darkElementPrimaryColor : lightElementSecondaryColor,
          borderRadius: BorderRadius.circular(heightSwitchOnScreenFavorites / 2),
        ),
        child: GestureDetector(
          onHorizontalDragUpdate: (details) => setState(() {
            if (details.delta.dx > 0 && _tabController.index == 0) _tabController.index = 1; // свайп вправо
            else if (details.delta.dx < 0 && _tabController.index == 1) _tabController.index = 0; // свайп влево
          }),
          child: Center(
            child: Text(
              _tabController.index == 0 ? switchLabelWantToVisit : switchLabelVisited,
              style: context.watch<CurrentTheme>().isDark
                  ? darkSelectTabFavoritesScreenStyle
                  : lightSelectTabFavoritesScreenStyle,
            ),
          ),
        ),
      ),
    );
  }

  /// Содержимое одной вкладки таб-свитча
  GridView _subScreen(List mocks) {
    return GridView.extent(
      maxCrossAxisExtent: wideScreenSizeOver,
      crossAxisSpacing: basicBorderSize,
      mainAxisSpacing: basicBorderSize,
      childAspectRatio: 1.5,
      children: mocks.map((e) => SightCard(e)).toList(),
    );
  }
}

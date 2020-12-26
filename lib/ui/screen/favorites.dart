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
        bottomHeight: sliderHeightOnScreenFavorites + basicBorderSize,
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

  Container _customSwitch() {
    return Container(
      margin: const EdgeInsets.only(left: basicBorderSize, right: basicBorderSize, bottom: basicBorderSize),
      height: sliderHeightOnScreenFavorites,
      child: Stack(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(sliderHeightOnScreenFavorites / 2),
            child: Material(
              color: context.watch<CurrentTheme>().isDark ? darkDarkerBackgroundColor : lightDarkerBackgroundColor,
              child: InkWell(
                onTap: () => _tabController.index = 1 - _tabController.index,
                child: Row(
                  children: [
                    Expanded(
                      child: Center(
                        child: Text(
                          switchLabelWantToVisit,
                          style: lowSelection700Style,
                        ),
                      ),
                    ),
                    Expanded(
                      child: Center(
                        child: Text(
                          switchLabelVisited,
                          style: lowSelection700Style,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Row(
            children: _tabController.index == 0
                ? [
                    Expanded(child: _activatedPartOfSwitch()),
                    Expanded(child: const SizedBox.shrink()),
                  ]
                : [
                    Expanded(child: const SizedBox.shrink()),
                    Expanded(child: _activatedPartOfSwitch()),
                  ],
          ),
        ],
      ),
    );
  }

  Widget _activatedPartOfSwitch() {
    return Container(
//      width: 150,
//      height: sliderHeightOnScreenFavorites,
      decoration: BoxDecoration(
        color: context.watch<CurrentTheme>().isDark ? darkElementPrimaryColor : lightElementSecondaryColor,
        borderRadius: BorderRadius.circular(sliderHeightOnScreenFavorites / 2),
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
    );
  }

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

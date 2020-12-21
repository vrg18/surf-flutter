import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:places/mocks.dart';
import 'package:places/ui/res/colors.dart';
import 'package:places/ui/res/sizes.dart';
import 'package:places/ui/res/strings.dart';
import 'package:places/ui/res/text_styles.dart';
import 'package:places/ui/screen/favorites/selected_part_of_slider.dart';
import 'package:places/ui/screen/favorites/unselected_part_of_slider.dart';
import 'package:places/ui/res/themes.dart';
import 'package:places/ui/screen/sight_card.dart';
import 'package:places/ui/screen/top_bar.dart';

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
      statusBarIconBrightness: currentThemeIsDark ? Brightness.light : Brightness.dark,
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
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(appBarTitleHeight + sliderHeightOnScreenFavorites + basicBorderSize),
        child: TopBar(
          titleHeight: appBarTitleHeight,
          bottomHeight: sliderHeightOnScreenFavorites + basicBorderSize,
          title: Text(
            favoritesTitle,
            style: screenTitleStyle,
            overflow: TextOverflow.ellipsis,
          ),
          bottom: _slider(),
        ),
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: basicBorderSize),
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

  Container _slider() {
    return Container(
      margin: EdgeInsets.only(left: basicBorderSize, right: basicBorderSize, bottom: basicBorderSize),
      height: sliderHeightOnScreenFavorites,
      decoration: BoxDecoration(
        color: currentThemeIsDark ? dmDarkerBackgroundColor : lmDarkerBackgroundColor,
        borderRadius: BorderRadius.all(Radius.circular(sliderHeightOnScreenFavorites / 2)),
      ),
      child: ConstrainedBox(
        constraints: BoxConstraints(maxWidth: wideScreenSizeOver),
        child: _partsOfSlider(_tabController.index),
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

  Row _partsOfSlider(int index) {
    var selectedPartOfSlider = Expanded(
      child: GestureDetector(
        onPanUpdate: (details) {
          if (details.delta.dx > 0 && index == 0)
            _tabController.index = 1; // свайп вправо
          else if (details.delta.dx < 0 && index == 1) _tabController.index = 0; // свайп влево
        },
        child: SelectedPartOfSlider(index == 0 ? wantToVisitTab : visitedTab),
      ),
    );
    var unselectedPartOfSlider = Expanded(
      child: GestureDetector(
        onTap: () => _tabController.index = 1 - index,
        child: UnselectedPartOfSlider(index == 0 ? visitedTab : wantToVisitTab),
      ),
    );
    return Row(
        children: index == 0
            ? [selectedPartOfSlider, unselectedPartOfSlider]
            : [unselectedPartOfSlider, selectedPartOfSlider]);
  }
}

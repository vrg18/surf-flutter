import 'package:flutter/material.dart';
import 'package:places/mocks.dart';
import 'package:places/ui/res/colors.dart';
import 'package:places/ui/res/sizes.dart';
import 'package:places/ui/res/strings.dart';
import 'package:places/ui/res/text_styles.dart';
import 'package:places/ui/screen/selected_part_of_slider.dart';
import 'package:places/ui/screen/sight_card.dart';
import 'package:places/ui/screen/unselected_part_of_slider.dart';

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
      appBar: AppBar(
        toolbarHeight: 90,
        backgroundColor: Colors.white,
        elevation: 0,
        title: Center(
          child: Text(
            favoritesTitle,
            style: favoritesScreenTitleStyle,
          ),
        ),
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(sliderHeightOnScreenFavorites),
          child: Container(
            margin: EdgeInsets.symmetric(horizontal: basicBorderSize, vertical: basicBorderSize),
            height: sliderHeightOnScreenFavorites,
            decoration: BoxDecoration(
              color: backgroundColorCardLabel,
              borderRadius: BorderRadius.all(Radius.circular(sliderHeightOnScreenFavorites / 2)),
            ),
            child: ConstrainedBox(
              constraints: BoxConstraints(maxWidth: wideScreenSizeOver),
              child: _sliderTab(_tabController.index),
            ),
          ),
        ),
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: basicBorderSize),
        child: TabBarView(controller: _tabController, children: [
          GridView.extent(
            maxCrossAxisExtent: wideScreenSizeOver,
            crossAxisSpacing: basicBorderSize,
            mainAxisSpacing: basicBorderSize,
            childAspectRatio: 1.5,
            children: [SightCard(mocks[1]), SightCard(mocks[2])],
          ),
          GridView.extent(
            maxCrossAxisExtent: wideScreenSizeOver,
            crossAxisSpacing: basicBorderSize,
            mainAxisSpacing: basicBorderSize,
            childAspectRatio: 1.5,
            children: [SightCard(mocks[0])],
          ),
        ]),
      ),
    );
  }

  Row _sliderTab(int index) {
    var selectedPartOfSlider = Expanded(
      child: GestureDetector(
        onPanUpdate: (details) {
          if (details.delta.dx > 0 && index == 0) _tabController.index = 1;       // свайп вправо
          else if (details.delta.dx < 0 && index == 1) _tabController.index = 0;  // свайп влево
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
    return Row(children: index == 0
            ? [selectedPartOfSlider, unselectedPartOfSlider]
            : [unselectedPartOfSlider, selectedPartOfSlider]);
  }
}

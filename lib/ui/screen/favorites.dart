import 'package:flutter/material.dart';
import 'package:places/mocks.dart';
import 'package:places/ui/res/colors.dart';
import 'package:places/ui/res/strings.dart';
import 'package:places/ui/res/text_styles.dart';
import 'package:places/ui/screen/select_slider_tab.dart';
import 'package:places/ui/screen/sight_card.dart';
import 'package:places/ui/screen/unselect_slider_tab.dart';

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
        toolbarHeight: 100,
        backgroundColor: Colors.white,
        elevation: 0,
        title: Center(
          child: Text(
            favoritesTitle,
            style: favoritesScreenTitleStyle,
          ),
        ),
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(40),
          child: Container(
            margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            height: 40,
            decoration: BoxDecoration(
              color: backgroundColorCardLabel,
              borderRadius: BorderRadius.all(Radius.circular(20.0)),
            ),
            child: Row(
                children: _tabController.index == 0
                    ? [
                        Expanded(
                          child: GestureDetector(
                            onPanUpdate: (details) {
                              // свайп вправо
                              if (details.delta.dx > 0) {
                                _tabController.index = 1;
                              }
                            },
                            child: SelectSliderTabs(wantToVisitTab),
                          ),
                        ),
                        Expanded(
                          child: GestureDetector(
                            onTap: () {
                              _tabController.index = 1;
                            },
                            child: UnselectSliderTabs(visitedTab),
                          ),
                        ),
                      ]
                    : [
                        Expanded(
                          child: GestureDetector(
                            onTap: () {
                              _tabController.index = 0;
                            },
                            child: UnselectSliderTabs(wantToVisitTab),
                          ),
                        ),
                        Expanded(
                          child: GestureDetector(
                            onPanUpdate: (details) {
                              // свайп влево
                              if (details.delta.dx < 0) {
                                _tabController.index = 0;
                              }
                            },
                            child: SelectSliderTabs(visitedTab),
                          ),
                        ),
                      ]),
          ),
        ),
      ),
      body: ConstrainedBox(
        // todo ограничение для горизонтальной ориентации экрана, потом сделать сетку шириной 1 или 2 в зависимости от ориентации
        constraints: BoxConstraints(maxWidth: 450),
        child: TabBarView(controller: _tabController, children: [
          SingleChildScrollView(
            child: Column(children: [SightCard(mocks[1]), SightCard(mocks[2])]),
          ),
          SingleChildScrollView(
            child: Column(children: [SightCard(mocks[0])]),
          ),
        ]),
      ),
    );
  }
}

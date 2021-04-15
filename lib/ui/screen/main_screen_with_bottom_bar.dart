import 'package:flutter/material.dart';
import 'package:places/ui/res/strings.dart';
import 'package:places/ui/screen/favorites.dart';
import 'package:places/ui/screen/settings.dart';
import 'package:places/ui/screen/sight_list_and_search/sight_list.dart';

/// Основной экран приложения с BottomNavigationBar
class MainScreenWithBottomBar extends StatefulWidget {
  @override
  _MainScreenWithBottomBarState createState() => _MainScreenWithBottomBarState();
}

class _MainScreenWithBottomBarState extends State<MainScreenWithBottomBar> {
  int _selectedPage = 0;
  final List<Widget> _pages = [
    SightList(),
    Favorites(),
    Settings(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _selectedPage,
        children: _pages,
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedPage,
        onTap: _onItemTapped,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        type: BottomNavigationBarType.fixed,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.ballot_outlined),
            activeIcon: Icon(Icons.ballot),
            label: tooltipList,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite_border),
            activeIcon: Icon(Icons.favorite),
            label: tooltipFavorites,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings_outlined),
            activeIcon: Icon(Icons.settings),
            label: tooltipSettings,
          ),
        ],
      ),
    );
  }

  /// Метод переключает страницы BottomNavigationBar
  void _onItemTapped(int index) {
    setState(() {
      _selectedPage = index;
    });
  }
}

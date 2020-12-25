import 'package:flutter/material.dart';
import 'package:places/mocks.dart';
import 'package:places/ui/screen/favorites/favorites.dart';
import 'package:places/ui/screen/filters/filters.dart';
import 'package:places/ui/screen/settings.dart';
import 'package:places/ui/screen/sight_detail/sight_detail.dart';
import 'package:places/ui/screen/sight_list.dart';

/// Основной экран приложения с BottomNavigationBar
class MainScreenWithBottomBar extends StatefulWidget {
  @override
  _MainScreenWithBottomBarState createState() => _MainScreenWithBottomBarState();
}

class _MainScreenWithBottomBarState extends State<MainScreenWithBottomBar> {
  int _selectedIndex = 0;
  final List<Widget> _widgetOptions = <Widget>[
    SightList(),
    Filters(),
    Favorites(),
    SightDetail(mocks[1]),
    Settings(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _widgetOptions.elementAt(_selectedIndex),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        type: BottomNavigationBarType.fixed,
        items: [
          BottomNavigationBarItem(
            icon: Icon(
              Icons.ballot_outlined,
            ),
            activeIcon: Icon(
              Icons.ballot,
            ),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.filter_alt_outlined,
            ),
            activeIcon: Icon(
              Icons.filter_alt,
            ),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.favorite_border,
            ),
            activeIcon: Icon(
              Icons.favorite,
            ),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.perm_media_outlined,
            ),
            activeIcon: Icon(
              Icons.perm_media_rounded,
            ),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.settings_outlined,
            ),
            activeIcon: Icon(
              Icons.settings,
            ),
            label: '',
          ),
        ],
      ),
    );
  }
}

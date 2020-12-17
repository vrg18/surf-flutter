import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:places/ui/res/colors.dart';
import 'package:places/ui/screen/favorites/favorites.dart';
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
    Favorites(),
  ];

  @override
  void initState() {
    super.initState();
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(statusBarColor: Colors.transparent));
  }

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
          items: [
            BottomNavigationBarItem(
              icon: Icon(
                Icons.ballot_outlined,
                color: primaryTextColor,
              ),
              activeIcon: Icon(
                Icons.ballot,
                color: primaryTextColor,
              ),
              label: '',
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.favorite_border,
                color: primaryTextColor,
              ),
              activeIcon: Icon(
                Icons.favorite,
                color: primaryTextColor,
              ),
              label: '',
            ),
          ]),
    );
  }
}

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:places/domain/current_theme.dart';
import 'package:places/ui/res/colors.dart';
import 'package:places/ui/res/sizes.dart';
import 'package:places/ui/res/strings.dart';
import 'package:places/ui/res/text_styles.dart';
import 'package:places/ui/screen/top_bar.dart';
import 'package:provider/provider.dart';

/// Экран настроек приложения
class Settings extends StatefulWidget {
  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  late bool _isDarkTheme;

  @override
  void initState() {
    super.initState();
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: context.read<CurrentTheme>().isDark ? Brightness.light : Brightness.dark,
    ));
    _isDarkTheme = context.read<CurrentTheme>().isDark;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TopBar(
        titleHeight: appBarTitleHeight,
        bottomHeight: 20,
        title: Text(
          headerSettings,
          style: screenTitleStyle,
          overflow: TextOverflow.ellipsis,
        ),
        bottom: SizedBox.shrink(),
      ),
      body: Container(
        margin: EdgeInsets.symmetric(horizontal: basicBorderSize),
        child: Column(
          children: [
            Container(
              height: 50,
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                    width: 1,
                    color: _isDarkTheme ? darkElementTertiaryColor : lightDarkerBackgroundColor,
                  ),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    letteringDarkTheme,
                    style: letteringSimplePrimaryColorStyle,
                  ),
                  CupertinoSwitch(
                    value: _isDarkTheme,
                    onChanged: (value) {
                      setState(() {
                        _isDarkTheme = value;
                        context.read<CurrentTheme>().isDark = value;
                        SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
                          statusBarIconBrightness: value ? Brightness.light : Brightness.dark,
                        ));
                      });
                    },
                  ),
                ],
              ),
            ),
            Container(
              height: 50,
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                    width: 1,
                    color: _isDarkTheme ? darkElementTertiaryColor : lightDarkerBackgroundColor,
                  ),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    letteringViewTutorial,
                    style: letteringSimplePrimaryColorStyle,
                  ),
                  FlatButton(
                    onPressed: () => print(viewTutorialPress),
                    minWidth: 20,
                    child: Icon(
                      Icons.info_outline,
                      size: 28,
                      color: bigGreenButtonColor,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

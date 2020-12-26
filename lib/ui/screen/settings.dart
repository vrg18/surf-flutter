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
        bottom: const SizedBox.shrink(),
      ),
      body: Container(
        margin: const EdgeInsets.symmetric(horizontal: basicBorderSize),
        child: Column(
          children: [
            _oneSetting(letteringDarkTheme, _switcherDarkTheme(context)),
            _oneSetting(letteringViewTutorial, _buttonViewTutorial()),
          ],
        ),
      ),
    );
  }

  Widget _oneSetting(String text, Widget controlElement) {
    return Container(
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
            text,
            style: letteringSimplePrimaryColorStyle,
          ),
          controlElement,
        ],
      ),
    );
  }

  Widget _switcherDarkTheme(BuildContext context) {
    return CupertinoSwitch(
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
    );
  }

  Widget _buttonViewTutorial() {
    return FlatButton(
      onPressed: () => print(viewTutorialPress),
      minWidth: 20,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      child: Icon(
        Icons.info_outline,
        size: 28,
        color: bigGreenButtonColor,
      ),
    );
  }
}

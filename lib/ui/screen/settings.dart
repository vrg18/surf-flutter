import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:places/domain/current_theme.dart';
import 'package:places/ui/res/colors.dart';
import 'package:places/ui/res/sizes.dart';
import 'package:places/ui/res/strings.dart';
import 'package:places/ui/res/text_styles.dart';
import 'package:places/ui/screen/buttons/universal_white_button.dart';
import 'package:places/ui/screen/widgets/top_bar.dart';
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
    _isDarkTheme = context.read<CurrentTheme>().isDark;
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: _isDarkTheme ? Brightness.light : Brightness.dark,
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TopBar(
        titleHeight: appBarTitleHeight,
        title: Text(
          headerSettings,
          style: screenTitleStyle,
          overflow: TextOverflow.ellipsis,
        ),
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

  /// Одна строка настроек
  Widget _oneSetting(String text, Widget controlElement) {
    return Container(
      height: 50,
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            width: 0.8,
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

  /// Настройка включения темной темы
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

  /// Ссылка на туториал
  Widget _buttonViewTutorial() {
    return UniversalWhiteButton(
      iconData: Icons.info_outline,
      textStyle: clearFiltersButtonTextStyle,
      toConsole: viewTutorialPress,
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:places/data/provider/current_theme.dart';
import 'package:places/data/provider/is_web.dart';
import 'package:places/ui/res/colors.dart';
import 'package:places/ui/res/sizes.dart';
import 'package:places/ui/res/strings.dart';
import 'package:places/ui/res/text_styles.dart';
import 'package:places/ui/screen/buttons/big_green_button.dart';
import 'package:places/ui/screen/buttons/universal_white_button.dart';
import 'package:places/ui/screen/main_screen_with_bottom_bar.dart';
import 'package:places/ui/screen/web_wrapper.dart';
import 'package:places/ui/screen/widgets/top_bar.dart';
import 'package:provider/provider.dart';

class OnBoarding extends StatefulWidget {
  @override
  _OnBoardingState createState() => _OnBoardingState();
}

class _OnBoardingState extends State<OnBoarding> {
  late PageController _controller;
  late int _currentPage;
  late bool _isDark;

  @override
  void initState() {
    super.initState();
    _controller = PageController();
    _currentPage = 0;
    _isDark = context.read<CurrentTheme>().isDark;
  }

  @override
  Widget build(BuildContext context) {
    return OrientationBuilder(builder: (context, orientation) {
      bool isPortrait = orientation == Orientation.portrait;

      return Scaffold(
        appBar: _filtersTopBar(_currentPage),
        body: Padding(
          padding: const EdgeInsets.all(basicBorderSize * 2),
          child: PageView.builder(
            controller: _controller,
            itemCount: 3,
            itemBuilder: (_, index) => _contentOnBoard(index, isPortrait),
            onPageChanged: _bodyChanged,
          ),
        ),
        floatingActionButton: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            _indicator(),
            SizedBox(height: distanceFromIndicatorToStartButton),
            _currentPage == 2 ? _bigGreenButton() : SizedBox(height: heightOfBigGreenButton),
          ],
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      );
    });
  }

  /// AppBar экрана OnBoarding
  PreferredSizeWidget _filtersTopBar(int currentPage) {
    return TopBar(
      titleHeight: appBarTitleHeight,
      rightButton: _currentPage < 2
          ? Padding(
              padding: const EdgeInsets.only(right: basicBorderSize),
              child: UniversalWhiteButton(
                label: letteringSkip,
                textStyle: clearFiltersButtonTextStyle,
                callback: _pressOnStart,
              ),
            )
          : null,
    );
  }

  /// Тело экрана
  Widget _contentOnBoard(int index, bool isPortrait) {
    return Column(
      mainAxisAlignment: isPortrait ? MainAxisAlignment.center : MainAxisAlignment.start,
      children: [
        context.read<Web>().isWeb
            ? Image.network(
                'res/pictures/${picturesOnBoarding[index]}.svg',
                color: _isDark ? darkElementPrimaryColor : lightElementPrimaryColor,
              )
            : SvgPicture.asset(
                'res/pictures/${picturesOnBoarding[index]}.svg',
                color: _isDark ? darkElementPrimaryColor : lightElementPrimaryColor,
              ),
        isPortrait ? const SizedBox(height: 48) : const SizedBox(height: 8),
        Text(
          _inOneOrTwoLines(titlesOnBoarding[index], isPortrait),
          style: sightDetailTitleStyle.apply(color: _isDark ? darkElementPrimaryColor : lightElementPrimaryColor),
          textAlign: TextAlign.center,
        ),
        isPortrait ? const SizedBox(height: 16) : const SizedBox(height: 8),
        Text(
          _inOneOrTwoLines(textsOnBoarding[index], isPortrait),
          style: lightFaintInscriptionStyle,
          textAlign: TextAlign.center,
        ),
      ],
    );
  }

  /// Индикатор
  Widget _indicator() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _pointOrStrip(0),
        const SizedBox(width: heightOfIndicator),
        _pointOrStrip(1),
        const SizedBox(width: heightOfIndicator),
        _pointOrStrip(2),
      ],
    );
  }

  /// Точка или полоска индикатора
  Widget _pointOrStrip(int index) {
    bool selected = _currentPage == index;

    return Container(
      height: heightOfIndicator,
      width: selected ? widthOfSelectedPointIndicator : heightOfIndicator,
      decoration: BoxDecoration(
        color: selected ? bigGreenButtonColor : translucent56TertiaryColor,
        borderRadius: BorderRadius.circular(heightOfIndicator / 2),
      ),
    );
  }

  /// Большая зеленая кнопка
  Widget _bigGreenButton() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: basicBorderSize),
      child: BigGreenButton(
        label: buttonLabelOnStart,
        callback: _pressOnStart,
      ),
    );
  }

  /// Убираем перенос на новую строку для широких экранов
  String _inOneOrTwoLines(String text, bool isPortrait) {
    return isPortrait ? text : text.replaceAll('\n', ' ');
  }

  /// Oбработка нажатия на кнопки "Пропустить" и "НА СТАРТ"
  void _pressOnStart() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
          builder: (context) =>
              context.read<Web>().isWeb ? WebWrapper(MainScreenWithBottomBar()) : MainScreenWithBottomBar()),
    );
  }

  /// При смене тела экрана
  void _bodyChanged(int index) {
    setState(() => _currentPage = index);
  }
}

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:places/domain/current_theme.dart';
import 'package:places/domain/nearby_sights.dart';
import 'package:places/ui/res/colors.dart';
import 'package:places/ui/res/sizes.dart';
import 'package:places/ui/res/strings.dart';
import 'package:places/ui/res/text_styles.dart';
import 'package:places/ui/screen/top_bar.dart';
import 'package:provider/provider.dart';

/// Экран с основным списком мест
class SightList extends StatefulWidget {
  @override
  _SightListState createState() => _SightListState();
}

class _SightListState extends State<SightList> {
  @override
  void initState() {
    super.initState();
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: context.read<CurrentTheme>().isDark ? Brightness.light : Brightness.dark,
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TopBar(
        titleHeight: appBarTitleHeight,
        title: Text(
          firstLandscapeScreenTitle,
          style: screenTitleStyle,
          overflow: TextOverflow.ellipsis,
        ),
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: basicBorderSize),
        child: GridView.extent(
          maxCrossAxisExtent: wideScreenSizeOver,
          crossAxisSpacing: basicBorderSize,
          mainAxisSpacing: basicBorderSize * 1.25,
          childAspectRatio: 1.75,
          children: context.watch<NearbySights>().listOfNearbySights,
        ),
      ),
      floatingActionButton: _getButtonNewLocation(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }

  /// Кнопка "Новое место" с градиентной заливкой
  Widget _getButtonNewLocation() {
    return ClipRRect(
      borderRadius: BorderRadius.circular(heightOfBigGreenButton / 2),
      child: Container(
        height: heightOfBigGreenButton,
        width: widthOfNewSightButton,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [newSightButtonLeftColor, newSightButtonRightColor],
          ),
        ),
        child: MaterialButton(
          onPressed: () => print(newSightPress),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Icon(
                Icons.add,
                color: bigGreenButtonLabelColor,
                size: 28,
              ),
              Text(
                letteringNewSight,
                style: activeBigGreenButtonTextStyle,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

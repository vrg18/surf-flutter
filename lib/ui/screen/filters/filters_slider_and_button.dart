import 'package:flutter/material.dart';
import 'package:places/domain/search_radius.dart';
import 'package:places/main.dart';
import 'package:places/ui/res/colors.dart';
import 'package:places/ui/res/sizes.dart';
import 'package:places/ui/res/strings.dart';
import 'package:places/ui/res/text_styles.dart';
import 'package:places/ui/res/themes.dart';
import 'package:sprintf/sprintf.dart';

/// Нижняя (правая) часть экрана фильтров с слайдером расстояни и кнопкой "Применить"
class FiltersSliderAndButton extends StatefulWidget {
  @override
  _FiltersSliderAndButtonState createState() => _FiltersSliderAndButtonState();
}

class _FiltersSliderAndButtonState extends State<FiltersSliderAndButton> {
  RangeValues _rangeValues = RangeValues(
    1 / distanceValueUp * searchRadius.start,
    1 / distanceValueUp * searchRadius.end,
  );

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          children: [
            SizedBox(height: 32),
            Container(
              margin: EdgeInsets.symmetric(horizontal: basicBorderSize),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    filtersSliderTitle,
                    style: filtersDistanceTitleStyle,
                  ),
                  Text(
                    sprintf(
                      filtersSliderValue,
                      [(_rangeValues.start * distanceValueUp).round(), (_rangeValues.end * distanceValueUp).round()],
                    ),
                    textAlign: TextAlign.right,
                    style: filtersDistanceValueStyle,
                  ),
                ],
              ),
            ),
            SizedBox(height: 16),
            SliderTheme(
              data: SliderThemeData(
                thumbColor: Colors.white,
                activeTrackColor: bigGreenButtonColor,
                inactiveTrackColor: currentThemeIsDark ? darkElementSecondaryColor : lightDarkerBackgroundColor,
                trackHeight: 2,
              ),
              child: RangeSlider(
                min: 1 / distanceValueUp * distanceValueFrom,
                max: 1,
                values: _rangeValues,
                onChanged: (RangeValues values) {
                  setState(() {
                    _rangeValues = values;
                    searchRadius = SearchRadius(
                      (_rangeValues.start * distanceValueUp).round(),
                      (_rangeValues.end * distanceValueUp).round(),
                    );
                  });
                },
              ),
            )
          ],
        ),
        Column(
          children: [
            Container(
              margin: EdgeInsets.symmetric(horizontal: basicBorderSize),
              height: heightOfBigGreenButton,
              width: double.infinity,
              child: RaisedButton(
                onPressed: () => print(applyFiltersPress),
                color: bigGreenButtonColor,
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Text(
                  sprintf(applyFilters, [190]),
                  style: bigGreenButtonTextStyle,
                ),
              ),
            ),
            SizedBox(height: 10),
          ],
        ),
      ],
    );
  }
}

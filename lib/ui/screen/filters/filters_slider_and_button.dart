import 'package:flutter/material.dart';
import 'package:places/domain/current_theme.dart';
import 'package:places/domain/search_radius.dart';
import 'package:places/main.dart';
import 'package:places/ui/res/colors.dart';
import 'package:places/ui/res/sizes.dart';
import 'package:places/ui/res/strings.dart';
import 'package:places/ui/res/text_styles.dart';
import 'package:places/ui/screen/buttons/big_green_button.dart';
import 'package:provider/provider.dart';
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
            const SizedBox(height: 32),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: basicBorderSize),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    filtersSliderTitle,
                    style: letteringSimplePrimaryColorStyle,
                  ),
                  Text(
                    sprintf(
                      filtersSliderValue,
                      [(_rangeValues.start * distanceValueUp).round(), (_rangeValues.end * distanceValueUp).round()],
                    ),
                    textAlign: TextAlign.right,
                    style: context.watch<CurrentTheme>().isDark
                        ? darkFiltersDistanceValueStyle
                        : lightFiltersDistanceValueStyle,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            SliderTheme(
              data: SliderThemeData(
                thumbColor: bigGreenButtonLabelColor,
                activeTrackColor: bigGreenButtonColor,
                inactiveTrackColor:
                    context.watch<CurrentTheme>().isDark ? darkElementSecondaryColor : lightDarkerBackgroundColor,
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
              margin: const EdgeInsets.symmetric(horizontal: basicBorderSize),
              child: BigGreenButton(
                label: sprintf(buttonLabelShow, [190]),
                textToConsole: applyFiltersPress,
              ),
            ),
            const SizedBox(height: 10),
          ],
        ),
      ],
    );
  }
}

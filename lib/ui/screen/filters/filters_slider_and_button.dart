import 'package:flutter/material.dart';
import 'package:places/domain/current_theme.dart';
import 'package:places/domain/nearby_sights.dart';
import 'package:places/domain/res/magnitudes.dart';
import 'package:places/ui/res/colors.dart';
import 'package:places/ui/res/sizes.dart';
import 'package:places/ui/res/strings.dart';
import 'package:places/ui/res/text_styles.dart';
import 'package:provider/provider.dart';
import 'package:sprintf/sprintf.dart';

/// Нижняя (правая) часть экрана фильтров с слайдером расстояни и кнопкой "Применить"
class FiltersSliderAndButton extends StatefulWidget {
  @override
  _FiltersSliderAndButtonState createState() => _FiltersSliderAndButtonState();
}

class _FiltersSliderAndButtonState extends State<FiltersSliderAndButton> {
  late RangeValues _rangeValues;

  @override
  Widget build(BuildContext context) {
    _rangeValues = RangeValues(
      1 / distanceValueUp * context.watch<NearbySights>().startOfSearchRadius,
      1 / distanceValueUp * context.watch<NearbySights>().endOfSearchRadius,
    );

    return Column(
      children: [
        const SizedBox(height: 32),
        _sliderTitle(context),
        const SizedBox(height: 16),
        _sliderItself(context),
      ],
    );
  }

  /// Заголовок слайдера
  Container _sliderTitle(BuildContext context) {
    return Container(
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
            style: lightFiltersDistanceValueStyle,
          ),
        ],
      ),
    );
  }

  /// Сам слайдер
  SliderTheme _sliderItself(BuildContext context) {
    return SliderTheme(
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
            context.read<NearbySights>().startOfSearchRadius = (_rangeValues.start * distanceValueUp).round();
            context.read<NearbySights>().endOfSearchRadius = (_rangeValues.end * distanceValueUp).round();
            context.read<NearbySights>().fillListOfNearbySights();
          });
        },
      ),
    );
  }
}

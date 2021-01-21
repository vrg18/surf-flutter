import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:places/domain/category.dart';
import 'package:places/domain/current_theme.dart';
import 'package:places/domain/nearby_sights.dart';
import 'package:places/domain/point.dart';
import 'package:places/domain/sight.dart';
import 'package:places/mocks.dart';
import 'package:places/ui/res/colors.dart';
import 'package:places/ui/res/sizes.dart';
import 'package:places/ui/res/strings.dart';
import 'package:places/ui/res/text_styles.dart';
import 'package:places/ui/screen/buttons/big_green_button.dart';
import 'package:places/ui/screen/buttons/universal_white_button.dart';
import 'package:places/ui/screen/new_sight/new_sight_field.dart';
import 'package:places/ui/screen/widgets/top_bar.dart';
import 'package:provider/provider.dart';

/// Экран добавления нового места
class NewSight extends StatefulWidget {
  @override
  _NewSightState createState() => _NewSightState();
}

class _NewSightState extends State<NewSight> {
  Map _values = {};
  Map _verified = {};
  Category? _category;
  bool _readiness = false;
  late bool _isDark;
  late Orientation orientation;

  @override
  void initState() {
    super.initState();
    _isDark = context.read<CurrentTheme>().isDark;
  }

  @override
  Widget build(BuildContext context) {
    return OrientationBuilder(builder: (context, orientation) {
      this.orientation = orientation;
      return KeyboardVisibilityBuilder(builder: (context, isKeyboardVisible) {
        return Scaffold(
          appBar: TopBar(
            titleHeight: appBarTitleHeight,
            title: Text(
              headerAddSight,
              style: screenTitleStyle,
              overflow: TextOverflow.ellipsis,
            ),
            leftButton: UniversalWhiteButton(
              iconData: Icons.chevron_left,
              isDark: _isDark,
              callback: () => Navigator.pop(context, false),
            ),
          ),
          body: SingleChildScrollView(
            child: orientation == Orientation.portrait
                ? Column(
                    children: [
                      _topLeftPartOfScreen(),
                      _bottomRightPartOfScreen(),
                    ],
                  )
                : Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(child: _topLeftPartOfScreen()),
                      Expanded(child: _bottomRightPartOfScreen()),
                    ],
                  ),
          ),
          floatingActionButton: isKeyboardVisible
              ? null
              : orientation == Orientation.portrait
                  ? _getBigGreenButton()
                  : Row(
                      children: [
                        Spacer(),
                        Expanded(child: _getBigGreenButton()),
                      ],
                    ),
          floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        );
      });
    });
  }

  /// Метод возвращает верхнюю (левую) часть экрана добавления нового места
  Widget _topLeftPartOfScreen() {
    return Column(
      children: [
        _addSightScreenSection(letteringCategory, _sectionCategory()),
        _addSightScreenSection(
          letteringName,
          NewSightField(
            nameField: 'name',
            callback: _saveStringAndCheckReadiness,
          ),
        ),
        Row(
          children: [
            Expanded(
              child: _addSightScreenSection(
                letteringLatitude,
                NewSightField(
                  nameField: 'lat',
                  callback: _saveStringAndCheckReadiness,
                  numericRange: 90,
                ),
              ),
            ),
            Expanded(
              child: _addSightScreenSection(
                letteringLongitude,
                NewSightField(
                  nameField: 'lon',
                  callback: _saveStringAndCheckReadiness,
                  numericRange: 180,
                ),
              ),
            ),
          ],
        ),
        Row(
          children: [
            UniversalWhiteButton(
              label: letteringPointOnMap,
              textStyle: clearFiltersButtonTextStyle,
              skipFocus: true,
              toConsole: pointOnMapPress,
            ),
          ],
        ),
      ],
    );
  }

  /// Метод возвращает нижнюю (правую) часть экрана добавления нового места
  Widget _bottomRightPartOfScreen() {
    return _addSightScreenSection(
      letteringDescription,
      NewSightField(
        nameField: 'description',
        callback: _saveStringAndCheckReadiness,
        hint: textFieldHintEnterText,
        mandatoryFilling: false,
        multiLine: true,
        lastField: true,
      ),
    );
  }

  /// Метод возвращает одну секцию экрана добавления нового места
  Widget _addSightScreenSection(String label, Widget section) {
    return ConstrainedBox(
      constraints: BoxConstraints(maxWidth: wideScreenSizeOver),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: basicBorderSize),
        child: Column(
          children: [
            Container(
              height: verticalScreenPitchAddSight,
              alignment: Alignment.bottomLeft,
              child: Text(
                label,
                style: addSightSectionLabelAndHintTextStyle,
              ),
            ),
            const SizedBox(height: 10),
            section,
          ],
        ),
      ),
    );
  }

  /// Метод возвращает содержимое (выпадающий список) секции "Категория"
  Widget _sectionCategory() {
    return SizedBox(
      width: double.infinity,
      child: DropdownButton<Category>(
        value: _category,
        style: _isDark ? darkMainTextFieldStyle : lightMainTextFieldStyle,
        dropdownColor: _isDark ? darkDarkerBackgroundColor : lightDarkerBackgroundColor,
        hint: Text(
          letteringNonSelect,
          style: lightFiltersDistanceValueStyle,
        ),
        onChanged: (value) {
          _category = value;
          _saveStringAndCheckReadiness('category', value, true);
        },
        items: categories
            .map((e) => DropdownMenuItem(
                  value: e,
                  child: Text(e.name),
                ))
            .toList(),
      ),
    );
  }

  /// Метод возвращает большую зеленую кнопку
  Padding _getBigGreenButton() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: basicBorderSize),
      child: BigGreenButton(
        label: '$buttonLabelCreate (${mocks.length})',
        isActive: _readiness,
        callback: () => _pressingBigGreenButton(),
        toConsole: createSightPress,
      ),
    );
  }

  /// Метод сохраняет введенную строку и проверят комплектность обязательных полей,
  /// и если Ок, активирует большую зеленую кнопку
  void _saveStringAndCheckReadiness<T>(String nameField, T value, bool verified) {
    _values[nameField] = value;
    _verified[nameField] = verified ? 1 : 0;
    bool _readinessNew = _verified.values.reduce((sum, element) => sum + element) >= 4; // 4 - кол-во обязательных полей
    if (_readiness != _readinessNew) {
      _readiness = _readinessNew;
      setState(() {});
    }
  }

  /// Метод вызывается при нажатии на большую зеленую кнопку, создает новое место
  /// (с пометкой "не подчиняется фильтрам", что бы сразу видеть его в списке) и возвращает нас на экран списка
  void _pressingBigGreenButton() {
    mocks.add(Sight(
      name: _values['name'].trim(),
      point: Point(_values['lat'], _values['lon']),
      category: _category!,
      description:
          _values.containsKey('description') && _values['description'] != null ? _values['description'].trim() : '',
      notObeyFilters: true,
    ));
    context.read<NearbySights>().fillListOfNearbySights(); // обновляем список мест в соответствии с фильтрами поиска
    Navigator.pop(context, true);
  }
}

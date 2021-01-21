import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
import 'package:places/ui/screen/buttons/simple_white_button.dart';
import 'package:places/ui/screen/top_bar.dart';
import 'package:provider/provider.dart';

/// Экран добавления нового места
class AddSight extends StatefulWidget {
  @override
  _AddSightState createState() => _AddSightState();
}

class _AddSightState extends State<AddSight> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _latController = TextEditingController();
  final TextEditingController _lonController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  final FocusNode _latNode = FocusNode();
  final FocusNode _lonNode = FocusNode();
  final FocusNode _descriptionNode = FocusNode();

  final _numericInputOnly = FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d{0,6}'));
  Map _values = {};
  Category? _category;
  late double? _lat;
  late double? _lon;
  bool _readiness = false;
  late FocusScopeNode node;
  late bool _isDark;
  late Orientation orientation;

  @override
  Widget build(BuildContext context) {
    _isDark = context.watch<CurrentTheme>().isDark;
    node = FocusScope.of(context);

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
            leftButton: SimpleWhiteButton(label: letteringCanceling, isDark: _isDark, toConsole: cancelingPress),
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
          floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        );
      });
    });
  }

  /// Метод возвращает верхнюю (левую) часть экрана добавления нового места
  Widget _topLeftPartOfScreen() {
    return Column(
      children: [
        _addSightScreenSection(letteringCategory, _sectionCategory()),
        _addSightScreenSection(letteringName, _valueInputField('name', _nameController, null, _latNode)),
        Row(children: [
          Expanded(
              child: _addSightScreenSection(
                  letteringLatitude,
                  _valueInputField('lat', _latController, _latNode, _lonNode,
                      hint: textFieldHintLat, onlyNumbers: true))),
          Expanded(
              child: _addSightScreenSection(
                  letteringLongitude,
                  _valueInputField('lon', _lonController, _lonNode, _descriptionNode,
                      hint: textFieldHintLon, onlyNumbers: true))),
        ]),
        Align(
          alignment: Alignment.centerLeft,
          child: FlatButton(
            onPressed: () => print(pointOnMapPress),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            focusNode: null,
            child: Text(
              letteringPointOnMap,
              style: clearFiltersButtonTextStyle,
            ),
          ),
        ),
      ],
    );
  }

  /// Метод возвращает нижнюю (правую) часть экрана добавления нового места
  Widget _bottomRightPartOfScreen() {
    return _addSightScreenSection(
        letteringDescription,
        _valueInputField('description', _descriptionController, _descriptionNode, null,
            hint: textFieldHintEnterText, multiLine: true, lastField: true));
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
          _checkReadiness();
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

  /// Метод возвращает содержимое (поле ввода) остальных секции (кроме "Категория")
  Widget _valueInputField(
      String nameField, TextEditingController currentController, FocusNode? currentFocus, FocusNode? nextFocus,
      {String hint = '', bool onlyNumbers = false, bool multiLine = false, bool lastField = false}) {
    return SizedBox(
      height: multiLine ? verticalScreenPitchAddSight * 2 : verticalScreenPitchAddSight,
      child: TextField(
        controller: currentController,
        focusNode: currentFocus,
        onChanged: (value) {
          _values[nameField] = value;
          _checkReadiness();
        },
        onEditingComplete: () => lastField ? node.unfocus() : node.requestFocus(nextFocus),
        textInputAction: lastField ? TextInputAction.done : TextInputAction.next,
        inputFormatters: [if (onlyNumbers) _numericInputOnly],
        expands: multiLine,
        textAlignVertical: TextAlignVertical.top,
        style: _isDark ? darkMainTextFieldStyle : lightMainTextFieldStyle,
        cursorColor: _isDark ? darkElementPrimaryColor : lightElementPrimaryColor,
        keyboardType: onlyNumbers ? TextInputType.number : TextInputType.text,
        maxLines: multiLine ? null : 1,
        minLines: multiLine ? null : 1,
        autofocus: true,
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.all(12),
          hintText: hint,
          hintStyle: addSightSectionLabelAndHintTextStyle,
          suffixIcon: currentController.text.isEmpty
              ? null
              : IconButton(
                  onPressed: () {
                    currentController.clear();
                    _values[nameField] = '';
                    _checkReadiness();
                  },
                  icon: Icon(Icons.cancel),
                ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(color: translucent40GreenColor),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(color: translucent40GreenColor, width: 2),
          ),
        ),
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

  /// Метод проверят введенные данные, и если Ок, активирует большую зеленую кнопку
  void _checkReadiness() {
    _readiness = false;
    if (_category != null &&
        _values.containsKey('name') &&
        _values['name'] != null &&
        _values['name'].trim() != '' &&
        _values.containsKey('lat') &&
        _values['lat'] != null &&
        _values.containsKey('lon') &&
        _values['lon'] != null) {
      _lat = double.tryParse(_values['lat']);
      _lon = double.tryParse(_values['lon']);
      if (_lat != null && _lat! > -90 && _lat! < 90 && _lon != null && _lon! > -180 && _lon! < 180) _readiness = true;
    }
    setState(() {});
  }

  /// Метод вызывается при нажатии на большую зеленую кнопку и создает новое место
  void _pressingBigGreenButton() {
    var newSight = Sight(
      name: _values['name'].trim(),
      point: Point(_lat!, _lon!),
      category: _category!,
      description:
          _values.containsKey('description') && _values['description'] != null ? _values['description'].trim() : '',
    );
    mocks.add(newSight);
    context.read<NearbySights>().fillListOfNearbySights(); // обновляем список мест в соответствии с фильтрами поиска

    _category = null;
    _nameController.clear();
    _latController.clear();
    _lonController.clear();
    _descriptionController.clear();
    _readiness = false;

    setState(() {});
  }
}

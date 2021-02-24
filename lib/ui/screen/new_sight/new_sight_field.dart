import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:places/data/provider/current_theme.dart';
import 'package:places/data/res/magnitudes.dart';
import 'package:places/ui/res/colors.dart';
import 'package:places/ui/res/sizes.dart';
import 'package:places/ui/res/text_styles.dart';
import 'package:provider/provider.dart';

class NewSightField extends StatefulWidget {
  final String nameField;
  final Function<T>(String, T, bool) callback;
  final String hint;
  final bool mandatoryFilling;
  final bool lastField;
  final int numericRange;
  final bool multiLine;

  NewSightField({
    required this.nameField,
    required this.callback,
    this.hint = '',
    this.mandatoryFilling = true,
    this.lastField = false,
    this.numericRange = 0,
    this.multiLine = false,
  });

  @override
  _NewSightFieldState createState() => _NewSightFieldState();
}

class _NewSightFieldState extends State<NewSightField> {
  final _currentController = TextEditingController();
  final _currentFocus = FocusNode();
  bool _currentFieldIsEmpty = true;

  @override
  void dispose() {
    _currentFocus.dispose();
    _currentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final _isDark = context.watch<CurrentTheme>().isDark;
    final numericalValue = widget.numericRange != 0;

    return SizedBox(
      height: widget.multiLine ? verticalScreenPitchAddSight * 2 : verticalScreenPitchAddSight,
      child: TextField(
        controller: _currentController,
        focusNode: _currentFocus,
        autofocus: true,
        onChanged: (value) => _whenEnteringCharacter(value),
        onEditingComplete: () => _currentFocus.nextFocus(),
        textInputAction: widget.lastField ? TextInputAction.done : TextInputAction.next,
        inputFormatters: [if (numericalValue) numericInputOnly],
        expands: widget.multiLine,
        textAlignVertical: TextAlignVertical.top,
        style: _isDark ? darkMainTextFieldStyle : lightMainTextFieldStyle,
        cursorColor: _isDark ? darkElementPrimaryColor : lightElementPrimaryColor,
        keyboardType: numericalValue ? TextInputType.number : TextInputType.text,
        maxLines: widget.multiLine ? null : 1,
        minLines: widget.multiLine ? null : 1,
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.all(12),
          hintText: numericalValue ? '-${widget.numericRange}...${widget.numericRange}' : widget.hint,
          hintStyle: addSightSectionLabelAndHintTextStyle,
          suffixIcon: _currentController.text.isEmpty
              ? null
              : IconButton(
                  onPressed: () {
                    _currentController.clear();
                    widget.callback(widget.nameField, null, false);
                  },
                  icon: Icon(Icons.cancel),
                  focusNode: FocusNode(skipTraversal: true),
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

  /// Метод вызывается при изменении вводимой строки, проверяет корректность строкм
  /// и ч/з callback вызывает метод родителя _saveStringAndCheckReadiness()
  void _whenEnteringCharacter(String value) {
    if (_currentFieldIsEmpty != value.isEmpty) {
      _currentFieldIsEmpty = value.isEmpty;
      setState(() {});
    }
    if (widget.numericRange != 0) {
      double? doubleValue = double.tryParse(value);
      bool validValue = doubleValue != null && doubleValue > -widget.numericRange && doubleValue < widget.numericRange;
      widget.callback(widget.nameField, doubleValue, widget.mandatoryFilling && validValue);
    } else {
      widget.callback(widget.nameField, value, widget.mandatoryFilling && value.isNotEmpty);
    }
  }
}

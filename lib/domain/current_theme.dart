import 'package:flutter/widgets.dart';

/// Класс, хранящий текущую тему (темная/светлая)
/// Используется Provider
class CurrentTheme with ChangeNotifier {
  bool _isDark = false;

  bool get isDark => _isDark;

  set isDark(bool value) {
    _isDark = value;
    notifyListeners();
  }
}

import 'package:flutter/material.dart';
import 'package:places/ui/res/themes.dart';

/// Определения нестандартных цветов, применяемых в приложении. Коды цветов взяты из Figma

// Цвета светлой темы
const Color lmElementPrimaryColor = currentThemeIsDark ? Colors.white : Color(0xFF252849),
    lmElementSecondaryColor = Color(0xFF3B3E5B),
    lmElementTertiaryColor = Color(0xFF7C7E92),
    lmMainBackgroundColor = Colors.white,
//    lmDarkerBackgroundColor = Color(0xFFF5F5F5);
    lmDarkerBackgroundColor = Color(0xFFE8E8E8); // Сделал чуть потемнее, а-то почти сливался с фоном

// Цвета темной темы
const Color dmElementPrimaryColor = Colors.white,
    dmElementSecondaryColor = Color(0xFF7C7E92),
    dmElementTertiaryColor = Color(0xFF3B3E5B),
    dmMainBackgroundColor = Color(0xFF21222C),
    dmDarkerBackgroundColor = Color(0xFF1A1A20);

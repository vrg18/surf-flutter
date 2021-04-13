import 'package:flutter/material.dart';

/// Определения нестандартных цветов, применяемых в приложении. Коды цветов взяты из Figma

// Цвета светлой темы
const Color lightElementPrimaryColor = Color(0xFF252849),
    lightElementSecondaryColor = Color(0xFF3B3E5B),
    lightElementTertiaryColor = Color(0xFF7C7E92),
    lightMainBackgroundColor = Colors.white,
//    lightDarkerBackgroundColor = Color(0xFFF5F5F5);
    lightDarkerBackgroundColor = Color(0xFFE8E8E8), // Сделал чуть потемнее, а-то почти сливался с фоном
    lightCategoryIconsBackgroundColor = Color(0xFFD8EFD0);

// Цвета темной темы
const Color darkElementPrimaryColor = Colors.white,
    darkElementSecondaryColor = Color(0xFF7C7E92),
    darkElementTertiaryColor = Color(0xFF3B3E5B),
    darkMainBackgroundColor = Color(0xFF21222C),
    darkDarkerBackgroundColor = Color(0xFF1A1A20),
    darkCategoryIconsBackgroundColor = Color(0xFF183828);

// Общие цвета
const Color bigGreenButtonColor = Color(0xFF4CAF50),
    bigGreenButtonLabelColor = Colors.white,
    newSightButtonLeftColor = Color(0xFFFCDD3D),
    newSightButtonRightColor = Color(0xFF4CAF50);

final Color translucent56TertiaryColor = lightElementTertiaryColor.withOpacity(0.56);
final Color translucent40GreenColor = bigGreenButtonColor.withOpacity(0.4);

final wrapperBackgroundColor = Colors.blueGrey[100];

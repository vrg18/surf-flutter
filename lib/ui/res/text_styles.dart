import 'package:flutter/material.dart';
import 'package:places/ui/res/colors.dart';
import 'package:places/ui/res/themes.dart';

/// Определения стилей текстов, применяемых в приложении

// Основной цвет текста
const TextStyle lmMainColorTextStyle = TextStyle(color: lmElementPrimaryColor);
const TextStyle dmMainColorTextStyle = TextStyle(color: dmElementPrimaryColor);

// Стиль текста заголовков экранов
final TextStyle screenTitleStyle = TextStyle(
  fontSize: 18,
  fontWeight: FontWeight.w600,
);

// Стиль текста подписи карточки на главном экране
final TextStyle sightCardTitleStyle = TextStyle(
  fontSize: 16,
  fontWeight: FontWeight.w700,
);

// Стиль текста категории на фото карточки на главном экране
final TextStyle sightCardCategoryStyle = TextStyle(
  color: lmMainBackgroundColor,
  fontSize: 16,
);

// Стиль текста подписи карточки на экране детализации
final TextStyle sightDetailTitleStyle = TextStyle(
  fontSize: 24,
  fontWeight: FontWeight.w700,
);

// Стиль текста категории карточки на экране детализации
final TextStyle sightDetailCategoryStyle = TextStyle(
  color: currentThemeIsDark ? dmElementSecondaryColor : lmElementSecondaryColor,
  fontSize: 14,
  fontWeight: FontWeight.w700,
);

// Стиль текста часов работы
final TextStyle lowSelectionStyle = TextStyle(
  color: currentThemeIsDark ? dmElementTertiaryColor : lmElementTertiaryColor,
  fontSize: 14,
);

// Стиль текста невыбранной кнопки слайдера
final TextStyle lowSelection700Style = TextStyle(
  color: lmElementTertiaryColor,
  fontSize: 14,
  fontWeight: FontWeight.w700,
);

// Стиль текста описания на экране детализации
final TextStyle sightDetailStyle = TextStyle(
  color: currentThemeIsDark ? dmElementPrimaryColor : lmElementSecondaryColor,
  fontSize: 14,
);

// Стиль текста на кнопке "Построить маршрут"
final TextStyle sightDetailBuildRouteStyle = TextStyle(
  color: buildRouteButtonTextColor,
  fontSize: 18,
  fontWeight: FontWeight.w700,
);

// Стиль текста выбранной вкладки на экране избранное
final TextStyle selectTabFavoritesScreenStyle = TextStyle(
  color: currentThemeIsDark ? dmDarkerBackgroundColor : lmMainBackgroundColor,
  fontSize: 14,
  fontWeight: FontWeight.w700,
);

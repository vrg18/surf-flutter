import 'package:flutter/material.dart';
import 'package:places/ui/res/colors.dart';
import 'package:places/ui/res/themes.dart';

/// Определения стилей текстов, применяемых в приложении

// Основной цвет текста
const TextStyle lightMainColorTextStyle = TextStyle(color: lightElementPrimaryColor);
const TextStyle darkMainColorTextStyle = TextStyle(color: darkElementPrimaryColor);

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
  color: lightMainBackgroundColor,
  fontSize: 16,
);

// Стиль текста подписи карточки на экране детализации
final TextStyle sightDetailTitleStyle = TextStyle(
  fontSize: 24,
  fontWeight: FontWeight.w700,
);

// Стиль текста категории карточки на экране детализации
final TextStyle sightDetailCategoryStyle = TextStyle(
  color: currentThemeIsDark ? darkElementSecondaryColor : lightElementSecondaryColor,
  fontSize: 14,
  fontWeight: FontWeight.w700,
);

// Стиль текста часов работы
final TextStyle lowSelectionStyle = TextStyle(
  color: currentThemeIsDark ? darkElementTertiaryColor : lightElementTertiaryColor,
  fontSize: 14,
);

// Стиль текста невыбранной кнопки слайдера
final TextStyle lowSelection700Style = TextStyle(
  color: lightElementTertiaryColor,
  fontSize: 14,
  fontWeight: FontWeight.w700,
);

// Стиль текста описания на экране детализации
final TextStyle sightDetailStyle = TextStyle(
  color: currentThemeIsDark ? darkElementPrimaryColor : lightElementSecondaryColor,
  fontSize: 14,
);

// Стиль текста большой зеленой кнопки
final TextStyle bigGreenButtonTextStyle = TextStyle(
  color: bigGreenButtonLabelColor,
  fontSize: 18,
  fontWeight: FontWeight.w700,
);

// Стиль текста выбранной вкладки на экране избранное
final TextStyle selectTabFavoritesScreenStyle = TextStyle(
  color: currentThemeIsDark ? darkDarkerBackgroundColor : lightMainBackgroundColor,
  fontSize: 14,
  fontWeight: FontWeight.w700,
);

// Стиль надписи слайдера "Расстояние"
final TextStyle filtersDistanceTitleStyle = TextStyle(
  fontSize: 16,
);

// Стиль текущих значений слайдера "Расстояние"
final TextStyle filtersDistanceValueStyle = TextStyle(
  color: currentThemeIsDark ? darkElementSecondaryColor : lightElementTertiaryColor,
  fontSize: 16,
);

// Стиль текста кнопки "Очистить фильтры"
final TextStyle clearFiltersButtonTextStyle = TextStyle(
  color: bigGreenButtonColor,
  fontSize: 16,
  fontWeight: FontWeight.w600,
);

// Стиль текста подписи иконки категории
final TextStyle categoryIconLabelTextStyle = TextStyle(
  color: currentThemeIsDark ? darkElementPrimaryColor : lightElementSecondaryColor,
  fontSize: 12,
);

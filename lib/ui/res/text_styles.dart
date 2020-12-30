import 'package:flutter/material.dart';
import 'package:places/ui/res/colors.dart';

/// Определения стилей текстов, применяемых в приложении

// Основной цвет текста
const TextStyle lightMainColorTextStyle = TextStyle(color: lightElementPrimaryColor);
const TextStyle darkMainColorTextStyle = TextStyle(color: darkElementPrimaryColor);

// Стиль текста заголовков экранов
const TextStyle screenTitleStyle = TextStyle(
  fontSize: 18,
  fontWeight: FontWeight.w600,
);

// Стиль текста подписи карточки на главном экране
const TextStyle sightCardTitleStyle = TextStyle(
  fontSize: 16,
  fontWeight: FontWeight.w700,
);

// Стиль текста категории на фото карточки на главном экране
const TextStyle sightCardCategoryStyle = TextStyle(
  color: lightMainBackgroundColor,
  fontSize: 16,
);

// Стиль текста подписи карточки на экране детализации
const TextStyle sightDetailTitleStyle = TextStyle(
  fontSize: 24,
  fontWeight: FontWeight.w700,
);

// Стили текста категории карточки на экране детализации
const TextStyle lightSightDetailCategoryStyle = TextStyle(
  color: lightElementSecondaryColor,
  fontSize: 14,
  fontWeight: FontWeight.w700,
);
const TextStyle darkSightDetailCategoryStyle = TextStyle(
  color: darkElementSecondaryColor,
  fontSize: 14,
  fontWeight: FontWeight.w700,
);

// Стили текста часов работы и прочих неярких надписей
const TextStyle lightFaintInscriptionStyle = TextStyle(
  color: lightElementTertiaryColor,
  fontSize: 14,
);
const TextStyle darkFaintInscriptionStyle = TextStyle(
  color: darkElementSecondaryColor,
  fontSize: 14,
);

// Стиль текста невыбранной кнопки слайдера
const TextStyle lowSelection700Style = TextStyle(
  color: lightElementTertiaryColor,
  fontSize: 14,
  fontWeight: FontWeight.w700,
);

// Стили текста описания на экране детализации
const TextStyle lightSightDetailStyle = TextStyle(
  color: lightElementSecondaryColor,
  fontSize: 14,
);
const TextStyle darkSightDetailStyle = TextStyle(
  color: darkElementPrimaryColor,
  fontSize: 14,
);

// Стили текста большой зеленой кнопки в активном и пассивном состоянии
const TextStyle activeBigGreenButtonTextStyle = TextStyle(
  color: bigGreenButtonLabelColor,
  fontSize: 14,
  fontWeight: FontWeight.w700,
);
const TextStyle passiveBigGreenButtonTextStyle = TextStyle(
  color: lightElementTertiaryColor,
  fontSize: 14,
  fontWeight: FontWeight.w700,
);

// Стили текста выбранной вкладки на экране избранное
const TextStyle lightSelectTabFavoritesScreenStyle = TextStyle(
  color: lightMainBackgroundColor,
  fontSize: 14,
  fontWeight: FontWeight.w700,
);
const TextStyle darkSelectTabFavoritesScreenStyle = TextStyle(
  color: darkDarkerBackgroundColor,
  fontSize: 14,
  fontWeight: FontWeight.w700,
);

// Стиль надписи слайдера "Расстояние" и надписей экрана настроек
const TextStyle letteringSimplePrimaryColorStyle = TextStyle(
  fontSize: 16,
);

// Стили текущих значений слайдера "Расстояние" и "Не выбрано" нового места
const TextStyle lightFiltersDistanceValueStyle = TextStyle(
  color: lightElementTertiaryColor,
  fontSize: 16,
);

// Стиль текста кнопки "Очистить фильтры" и "Указать на карте"
const TextStyle clearFiltersButtonTextStyle = TextStyle(
  color: bigGreenButtonColor,
  fontSize: 16,
  fontWeight: FontWeight.w600,
);

// Стили текста подписи иконки категории
const TextStyle lightCategoryIconLabelTextStyle = TextStyle(
  color: lightElementSecondaryColor,
  fontSize: 12,
);
const TextStyle darkCategoryIconLabelTextStyle = TextStyle(
  color: darkElementPrimaryColor,
  fontSize: 12,
);

// Стиль текста названий секций и хинтов на экране "Новое место"
final TextStyle addSightSectionLabelAndHintTextStyle = TextStyle(
  color: translucent56TertiaryColor,
  fontSize: 12,
);

// Стиль для текстовых полей ввода
const TextStyle lightMainTextFieldStyle = TextStyle(
  color: lightElementPrimaryColor,
  fontSize: 16,
);
const TextStyle darkMainTextFieldStyle = TextStyle(
  color: darkElementPrimaryColor,
  fontSize: 16,
);

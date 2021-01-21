import 'package:flutter/services.dart';

/// Определения числовых данных, применяемых в приложении

const int distanceValueFrom = 100; // минимальная дистанция радиуса поиска, м
const int distanceValueUp = 10000; // максимальная дистанция радиуса поиска, м

const pauseBetweenSearches = const Duration(seconds: 3); // три секунды пауза между поисками
const pauseForSearches = const Duration(
    milliseconds: 1000); // пауза при заполнении строки поиска, после которой собственно и запускается поиск
const minimumSearchWordLength = 3; // минимальная длина слова для поиска
const searchHistoryDepth = 10; // глубина истории поиска

final numericInputOnly = FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d{0,6}'));

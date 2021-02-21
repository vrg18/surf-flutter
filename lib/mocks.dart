import 'package:flutter/material.dart';
import 'package:places/domain/category.dart';
import 'package:places/domain/point.dart';
import 'package:places/domain/sight.dart';

/// Моковые данные, примеры мест для тестирования приложения

/// Список категорий
final List<Category> categories = [
  Category('Архитектура', Icons.account_balance),
  Category('Отель', Icons.hotel),
  Category('Ресторан', Icons.restaurant),
  Category('Особое место', Icons.stars),
  Category('Кафе', Icons.local_cafe),
  Category('Супермаркет', Icons.shopping_cart),
  Category('Университет', Icons.school),
  Category('Пляж', Icons.pool),
  Category('Библиотека', Icons.local_library),
];

/// Список интересных мест
final List<Sight> mocks = [
  Sight(
      name: 'Дольмен Сердце матери',
      point: Point(44.480153, 38.406548),
      url: 'https://avatars.mds.yandex.net/get-altay/2397657/2a0000017463329b491823a390991821a2fd/XXXL',
      description:
          'Первый и наиболее известный Пшадский дольмен – это «Сердце матери», или как его еще называют, «Благословение». '
          'Он стоит на краю поселка Пшада, имеет трапециевидную форму и относится к корытообразному типу.',
      category: categories[0]),
  Sight(
      name: 'Дольмен Тор',
      point: Point(44.456506, 38.351367),
      url: 'https://avatars.mds.yandex.net/get-altay/1063709/2a00000165ec2f29de191e54638a1f28f9d4/XXXL',
      description: 'Дольмен Тор. Дарит уверенность в себе, силу духа и удачу.',
      category: categories[0]),
  Sight(
      name: 'Дольмен Нежность',
      point: Point(44.454711, 38.351977),
      url: 'https://avatars.mds.yandex.net/get-altay/481843/2a000001622f0585a80c5134485e9bd444de/XXXL',
      description: 'Дольмен Нежность. Отвечает за материнство, здоровье и счастье детей.',
      category: categories[0]),
];

/// Где находимся сейчас
final currentPoint = Point(44.472013, 38.399564);

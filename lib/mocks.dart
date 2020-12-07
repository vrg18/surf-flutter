import 'package:places/domain/category.dart';
import 'package:places/domain/sight.dart';

final dolmenCategory = Category('Дольмен');

final List mocks = [
  Sight(
      'Дольмен Сердце матери',
      44.480153,
      38.406548,
      'https://avatars.mds.yandex.net/get-altay/2397657/2a0000017463329b491823a390991821a2fd/XXXL',
      '''Первый и наиболее известный Пшадский дольмен – это «Сердце матери», или как его еще называют, «Благословение».
       Он стоит на краю поселка Пшада, имеет трапециевидную форму и относится к корытообразному типу.''',
      dolmenCategory),
  Sight(
      'Дольмен Тор',
      44.456506,
      38.351367,
      'https://avatars.mds.yandex.net/get-altay/1063709/2a00000165ec2f29de191e54638a1f28f9d4/XXXL',
      'Дольмен Тор. Дарит уверенность в себе, силу духа и удачу.',
      dolmenCategory),
  Sight(
      'Дольмен Нежность',
      44.454711,
      38.351977,
      'https://avatars.mds.yandex.net/get-altay/481843/2a000001622f0585a80c5134485e9bd444de/XXXL',
      'Дольмен Нежность. Отвечает за материнство, здоровье и счастье детей',
      dolmenCategory),
];

import 'package:flutter/material.dart';
import 'package:places/domain/category.dart';
import 'package:places/domain/point.dart';
import 'package:places/mocks.dart';
import 'package:places/ui/res/sizes.dart';
import 'package:places/ui/screen/sight_card.dart';

/// Класс, хранящий список мест в соответствии с установленными фильтрами
/// и сами установки фильтров
class NearbySights with ChangeNotifier {
  List<SightCard> listOfNearbySights = [];
  var selectedCategories = List<Category>.from(categories);
  int startOfSearchRadius = distanceValueFrom;
  int endOfSearchRadius = distanceValueUp;

  NearbySights() {
    fillListOfNearbySights();
  }

  /// Метод заполняет список мест в соответствии с установленными фильтрами
  void fillListOfNearbySights() {
    listOfNearbySights.clear();
    mocks.forEach((sight) {
      if (!arePointsNear(sight.point, currentPoint, startOfSearchRadius) &&
          arePointsNear(sight.point, currentPoint, endOfSearchRadius) &&
          selectedCategories.contains(sight.category)) {
        listOfNearbySights.add(SightCard(sight));
      }
    });
    notifyListeners();
  }
}

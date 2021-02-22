import 'package:places/data/repository/point_on_map.dart';
import 'package:places/data/res/magnitudes.dart';
import 'package:places/data/storage/category_storage.dart';
import 'package:places/data/storage/mocks.dart';
import 'package:places/data/storage/sight_storage.dart';
import 'package:places/domain/category.dart';
import 'package:places/domain/point.dart';
import 'package:places/domain/sight.dart';

/// Бизнес-логика мест: список в соответствии с установленными фильтрами, сами установки фильтров
class NearbySights {
  SightStorage _sightStorage = SightStorage();
  CategoryStorage _categoryStorage = CategoryStorage();

  late List<Sight> _listOfNearbySights;
  late List<Category> _listOfCategories;
  int _startOfSearchRadius = distanceValueFrom;
  int _endOfSearchRadius = distanceValueUp;

  List<Sight> get listOfNearbySights => _listOfNearbySights;

  List<Category> get listOfCategories => _listOfCategories;

  int get startOfSearchRadius => _startOfSearchRadius;

  int get endOfSearchRadius => _endOfSearchRadius;

  set startOfSearchRadius(value) => _startOfSearchRadius = value;

  set endOfSearchRadius(value) => _endOfSearchRadius = value;

  NearbySights() {
    _listOfNearbySights = _sightStorage.initialFillingOfList();
    _listOfCategories = _categoryStorage.initialFillingOfListOfCategories();
  }

  /// Метод заполняет список мест в соответствии с установленными фильтрами
  void fillListOfNearbySights() {
    _listOfNearbySights.clear();
    _sightStorage.originalListOfSights.forEach((sight) {
      if (sight.notObeyFilters ||
          (!arePointsNear(sight.point, getCurrentPoint(), _startOfSearchRadius) &&
              arePointsNear(sight.point, getCurrentPoint(), _endOfSearchRadius) &&
              sight.category.selected)) {
        _listOfNearbySights.add(sight);
      }
    });
  }

  /// Метод сбрасывает все фильтры
  void clearFilters() {
    _listOfCategories.forEach((element) => element.selected = false);
    _startOfSearchRadius = distanceValueFrom;
    _endOfSearchRadius = distanceValueUp;
    fillListOfNearbySights();
  }

  /// Метод получает текущее местоположение устройства
  Point getCurrentPoint() {
    return currentPoint; // todo будет заменено получением реального местоположения
  }
}

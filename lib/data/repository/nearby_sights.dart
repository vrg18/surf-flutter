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
  List<bool> _tempListOfCategories = [];
  late int _tempStartOfSearchRadius;
  late int _tempEndOfSearchRadius;

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

  /// Метод добавляет в исходный список мест новое место
  void addNewSightToOriginalListOfSights(Sight sight) {
    _sightStorage.originalListOfSights.add(sight);
    fillListOfNearbySights();
  }

  /// Метод сбрасывает все фильтры
  void clearFilters() {
    _listOfCategories.forEach((element) => element.selected = false);
    _startOfSearchRadius = distanceValueFrom;
    _endOfSearchRadius = distanceValueUp;
    fillListOfNearbySights();
  }

  /// Метод сохраняет настройки фильтров для возможности "откатить" изменения фильтров
  void saveFilterSettings() {
    _tempListOfCategories.clear();
    _listOfCategories.forEach((e) => _tempListOfCategories.add(e.selected));
    _tempStartOfSearchRadius = _startOfSearchRadius;
    _tempEndOfSearchRadius = _endOfSearchRadius;
  }

  /// Метод "откатывает" настройки фильтров, выполняется при возврате из экрана фильтров по кнопке "Назад/Отмена"
  void filtersHaveBeenCanceled() {
    for (var i = 0; i < _listOfCategories.length; i++) {
      _listOfCategories[i].selected = _tempListOfCategories[i];
    }
    _startOfSearchRadius = _tempStartOfSearchRadius;
    _endOfSearchRadius = _tempEndOfSearchRadius;
    fillListOfNearbySights();
  }

  /// Метод получает текущее местоположение устройства
  Point getCurrentPoint() {
    return currentPoint; // todo будет заменено получением реального местоположения
  }
}

import 'package:places/data/res/magnitudes.dart';
import 'package:places/domain/category.dart';
import 'package:places/domain/point.dart';
import 'package:places/domain/sight.dart';
import 'package:places/mocks.dart';

/// Бизнес-логика мест: список в радиусе поиска
class NearbySights {
  List<Sight> _listOfNearbySights = List<Sight>.from(mocks);
  List<Category> _selectedCategories = List<Category>.from(categories);
  int _startOfSearchRadius = distanceValueFrom;
  int _endOfSearchRadius = distanceValueUp;

  List<Sight> get listOfNearbySights => _listOfNearbySights;
  List<Category> get selectedCategories => _selectedCategories;
  int get startOfSearchRadius => _startOfSearchRadius;
  int get endOfSearchRadius => _endOfSearchRadius;
  set selectedCategories(value) => _selectedCategories = value;
  set startOfSearchRadius(value) => _startOfSearchRadius = value;
  set endOfSearchRadius(value) => _endOfSearchRadius = value;


  /// Метод заполняет список мест в соответствии с установленными фильтрами
  void fillListOfNearbySights() {
    _listOfNearbySights.clear();
    mocks.forEach((sight) {
      if (sight.notObeyFilters ||
          (!arePointsNear(sight.point, currentPoint, _startOfSearchRadius) &&
              arePointsNear(sight.point, currentPoint, _endOfSearchRadius) &&
              _selectedCategories.contains(sight.category))) {
        _listOfNearbySights.add(sight);
      }
    });
  }
}
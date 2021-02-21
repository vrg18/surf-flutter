import 'package:flutter/widgets.dart';
import 'package:places/data/repository/nearby_sights.dart';
import 'package:places/data/repository/search_sights.dart';

/// Класс, хранящий список мест в соответствии с установленными фильтрами, историю поиска
/// Используется Provider
class SightProvider with ChangeNotifier {
  final NearbySights _nearbySights = NearbySights();
  final SearchSights _searchSights = SearchSights();

  NearbySights get nearbySights => _nearbySights;

  SearchSights get searchSights => _searchSights;

  /// Метод вызывает заполнение списка мест в соответствии с установленными фильтрами и уведомляет слушателей
  void fillListOfNearbySights() {
    _nearbySights.fillListOfNearbySights();
    notifyListeners();
  }

  /// Метод сбрасывает текущий поиск и уведомляет слушателей
  void cancelSearch() {
    _searchSights.cancelSearch();
    notifyListeners();
  }

  /// Метод запускает новый поиск, и, если результат поиска изменились, уведомляет слушателей
  void startingNewSearch(String searchString) {
    if (_searchSights.startingNewSearchAndAddingResultsToStream(searchString, _nearbySights)) notifyListeners();
  }
}

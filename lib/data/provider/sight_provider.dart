import 'package:flutter/widgets.dart';
import 'package:places/data/repository/favorites_sights.dart';
import 'package:places/data/repository/nearby_sights.dart';
import 'package:places/data/repository/search_sights.dart';

/// Класс, хранящий список мест в соответствии с установленными фильтрами, историю поиска и избранные места
/// Используется Provider
class SightProvider with ChangeNotifier {
  final NearbySights _nearbySights = NearbySights();
  final SearchSights _searchSights = SearchSights();
  final FavoritesSights _favoritesSights = FavoritesSights();

  NearbySights get nearbySights => _nearbySights;

  SearchSights get searchSights => _searchSights;

  FavoritesSights get favoritesSights => _favoritesSights;

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

  /// Метод запускает новый поиск, и, если результаты поиска изменились, уведомляет слушателей
  void startingNewSearch(String searchString) {
    if (_searchSights.startingNewSearchAndAddingResultsToStream(searchString, _nearbySights)) notifyListeners();
  }

  /// Освобождаем ресурсы
  @override
  void dispose() {
    _searchSights.closeStream();
    super.dispose();
  }
}

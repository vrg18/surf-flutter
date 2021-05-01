import 'package:flutter/widgets.dart';
import 'package:places/data/service/favorites_sights.dart';
import 'package:places/data/service/nearby_sights.dart';
import 'package:places/data/service/search_sights.dart';
import 'package:places/domain/sight.dart';

/// Класс, хранящий список мест в соответствии с установленными фильтрами, историю поиска и избранные места
/// Используется Provider
class SightProvider with ChangeNotifier {
  final NearbySights _nearbySights = NearbySights();
  final FavoritesSights _favoritesSights = FavoritesSights();
  final SearchSights _searchSights = SearchSights();

  NearbySights get nearbySights => _nearbySights;

  SearchSights get searchSights => _searchSights;

  FavoritesSights get favoritesSights => _favoritesSights;

  /// Начальное заполнение данных, необходимых для работы приложения
  Future<void> initializeApp() async {
    _nearbySights.initializeNearbySights();
    _favoritesSights.initializeFavoritesSights();
  }

  /// Метод получает место по его ID
  Sight getSightById(String id) {
    return _nearbySights.getSightById(id);
  }

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

import 'package:flutter/widgets.dart';
import 'package:places/domain/category.dart';
import 'package:places/domain/point.dart';
import 'package:places/domain/res/magnitudes.dart';
import 'package:places/domain/sight.dart';
import 'package:places/mocks.dart';
import 'package:rxdart/rxdart.dart';

/// Класс, хранящий список мест в соответствии с установленными фильтрами
/// и сами установки фильтров
/// Используется Provider
class NearbySights with ChangeNotifier {
  List<Sight> listOfNearbySights = [];
  var selectedCategories = List<Category>.from(categories);
  int startOfSearchRadius = distanceValueFrom;
  int endOfSearchRadius = distanceValueUp;

  List<Sight> listOfDesiredSights = [];
  List<Sight> listOfSearchHistory = [];
  bool _isSearchStringEmpty = true;

  String _previousSearchString = '';

  final _subjectSights = BehaviorSubject<List<Sight>>.seeded([]);

  Stream<List<Sight>> get streamSights => _subjectSights.stream;

  bool get isSearchStringEmpty => _isSearchStringEmpty;

  String get previousSearchString {
    _isSearchStringEmpty = _previousSearchString.length == 0;
    return _previousSearchString;
  }

  void cancelSearch() {
    _isSearchStringEmpty = true;
    _previousSearchString = '';
    listOfDesiredSights.clear();
    notifyListeners();
  }

  NearbySights() {
    fillListOfNearbySights();
  }

  /// Метод заполняет список мест в соответствии с установленными фильтрами
  void fillListOfNearbySights() {
    listOfNearbySights.clear();
    mocks.forEach((sight) {
      if (sight.notObeyFilters ||
          (!arePointsNear(sight.point, currentPoint, startOfSearchRadius) &&
              arePointsNear(sight.point, currentPoint, endOfSearchRadius) &&
              selectedCategories.contains(sight.category))) {
        listOfNearbySights.add(sight);
      }
    });
    notifyListeners();
  }

  /// Условие начала поиска - длина строки не менее minimumSearchWordLength
  /// Метод запускает для удовлетворяющей условию строки новый поиск
  /// Для неудовлетворяющей условию поиск сбрасывается (один раз)
  /// Результат поиска (в т.ч. пустой) кладется в Stream
  /// Также проверяется и, если надо, корректируется флаг isSearchStringEmpty
  void startingNewSearchAndAddingResultsToStream(String searchString) {
    if (searchString.length >= minimumSearchWordLength && searchString != _previousSearchString) {
      _searchingSightsByString(searchString);
      _subjectSights.sink.add(listOfDesiredSights);
    } else if (searchString.length < minimumSearchWordLength &&
        _previousSearchString.length >= minimumSearchWordLength) {
      listOfDesiredSights.clear();
      _subjectSights.sink.add(listOfDesiredSights);
    }
    _previousSearchString = searchString;

    if (_isSearchStringEmpty != (searchString.length == 0)) {
      _isSearchStringEmpty = !_isSearchStringEmpty;
      notifyListeners();
    }
  }

  /// Метод заполняет список мест в соответствии со строкой поиска
  Future _searchingSightsByString(String searchString) async {
    print('Непосредственно поиск...');
    listOfDesiredSights.clear();
    List<String> words = searchString.split(' ');
    listOfNearbySights.forEach((element) {
      int numberOfFound = 0;
      words.forEach((word) {
        if (element.name.toLowerCase().contains(word.trim().toLowerCase())) numberOfFound++;
      });
      if (numberOfFound == words.length) {
        listOfDesiredSights.add(element);
        listOfSearchHistory.remove(element);
        listOfSearchHistory.insert(0, element);
        if (listOfSearchHistory.length > searchHistoryDepth) listOfSearchHistory.removeAt(searchHistoryDepth);
      }
    });
    print('Поиск завершен, найдено ${listOfDesiredSights.length} элемента!');
  }

  /// Освобождаем ресурсы
  void dispose() {
    _subjectSights.close();
    super.dispose();
  }

//  /// Метод запускает трехсекундный таймер
//   void _startOfThreeSecondTimer() {
//     _threeSecondsAreNotOver = true;
//     Timer(
//       pauseBetweenSearches,
//       () => _threeSecondsAreNotOver = false,
//     );
//   }
}

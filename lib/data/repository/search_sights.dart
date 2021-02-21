import 'package:places/data/repository/nearby_sights.dart';
import 'package:places/data/res/magnitudes.dart';
import 'package:places/domain/sight.dart';
import 'package:rxdart/rxdart.dart';

/// Бизнес-логика поиска по строке
class SearchSights {
  List<Sight> _listOfDesiredSights = [];
  List<Sight> _listOfSearchHistory = [];
  bool _isSearchStringEmpty = true;
  String _previousSearchString = '';
  final _subjectSights = BehaviorSubject<List<Sight>>.seeded([]);

  List<Sight> get listOfSearchHistory => _listOfSearchHistory;

  bool get isSearchStringEmpty => _isSearchStringEmpty;

  String get previousSearchString {
    _isSearchStringEmpty = _previousSearchString.length == 0;
    return _previousSearchString;
  }

  Stream<List<Sight>> get streamSights => _subjectSights.stream;

  void cancelSearch() {
    _isSearchStringEmpty = true;
    _previousSearchString = '';
    _listOfDesiredSights.clear();
  }

  /// Условие начала поиска - длина строки не менее minimumSearchWordLength
  /// Метод запускает для удовлетворяющей условию строки новый поиск
  /// Для неудовлетворяющей условию поиск сбрасывается (один раз)
  /// Результат поиска (в т.ч. пустой) кладется в Stream
  /// Также проверяется и, если надо, корректируется флаг isSearchStringEmpty
  bool startingNewSearchAndAddingResultsToStream(String searchString, NearbySights nearbySights) {
    if (searchString.length >= minimumSearchWordLength && searchString != _previousSearchString) {
      _searchingSightsByString(searchString, nearbySights);
      _subjectSights.sink.add(_listOfDesiredSights);
    } else if (searchString.length < minimumSearchWordLength &&
        _previousSearchString.length >= minimumSearchWordLength) {
      _listOfDesiredSights.clear();
      _subjectSights.sink.add(_listOfDesiredSights);
    }
    _previousSearchString = searchString;

    if (_isSearchStringEmpty != (searchString.length == 0)) {
      _isSearchStringEmpty = !_isSearchStringEmpty;
      return true;
    }
    return false;
  }

  /// Метод заполняет список мест в соответствии со строкой поиска
  Future _searchingSightsByString(String searchString, NearbySights nearbySights) async {
    print('Непосредственно поиск...');
    _listOfDesiredSights.clear();
    List<String> words = searchString.split(' ');
    nearbySights.listOfNearbySights.forEach((element) {
      int numberOfFound = 0;
      words.forEach((word) {
        if (element.name.toLowerCase().contains(word.trim().toLowerCase())) numberOfFound++;
      });
      if (numberOfFound == words.length) {
        _listOfDesiredSights.add(element);
        listOfSearchHistory.remove(element);
        listOfSearchHistory.insert(0, element);
        if (listOfSearchHistory.length > searchHistoryDepth) listOfSearchHistory.removeAt(searchHistoryDepth);
      }
    });
    print('Поиск завершен, найдено ${_listOfDesiredSights.length} элемента!');
  }
}

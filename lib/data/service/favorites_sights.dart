import 'package:places/data/storage/sight_storage.dart';
import 'package:places/domain/sight.dart';

/// Бизнес-логика списков "Хочу посетить" и "Посетил"
class FavoritesSights {
  SightStorage _sightStorage = SightStorage();

  late List<Sight> _listOfSightsWantToVisit;
  late List<Sight> _listOfSightsVisited;

  List<Sight> get listOfSightsWantToVisit => _listOfSightsWantToVisit;

  List<Sight> get listOfSightsVisited => _listOfSightsVisited;

  FavoritesSights() {
    _listOfSightsWantToVisit = _sightStorage.getListWantToVisit();
    _listOfSightsVisited = _sightStorage.getListVisited();
  }
}

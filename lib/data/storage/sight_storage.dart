import 'package:places/data/res/mocks.dart';
import 'package:places/domain/sight.dart';
import 'package:uuid/uuid.dart';

/// Получение из БД и запись в БД мест (достопримечательностей)
class SightStorage {

  List<Sight> _originalListOfSights = List<Sight>.from(mockSights);

  List<Sight> get originalListOfSights => _originalListOfSights;

  List<Sight> initialFillingOfList() {
    Uuid uuid = Uuid();
    _originalListOfSights.forEach((sight) => sight.id = uuid.v4());
    return List<Sight>.from(_originalListOfSights); // todo будет заменено данными из базы
  }

  List<Sight> getListWantToVisit() {
    return [_originalListOfSights[1], _originalListOfSights[2]]; // todo будет заменено данными из базы
  }

  List<Sight> getListVisited() {
    return [_originalListOfSights[0]]; // todo будет заменено данными из базы
  }
}

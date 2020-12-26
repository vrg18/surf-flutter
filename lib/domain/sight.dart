import 'package:places/domain/category.dart';
import 'package:places/domain/point.dart';
import 'package:places/main.dart';
import 'package:places/mocks.dart';
import 'package:places/ui/screen/sight_card.dart';

/// Основной класс места (достопримечательности)
class Sight {
  final String name;
  final Point point;
  final String url;
  final String details;
  final Category category;

  Sight(
    this.name,
    this.point,
    this.url,
    this.details,
    this.category,
  );
}
//
// /// Метод заполняет список мест в соответствии с установленными фильтрами
// void fillListOfNearbySights() {
//   listOfNearbySights.clear();
//   mocks.forEach((sight) {
//     if (!arePointsNear(sight.point, currentPoint, searchRadius.start) &&
//         arePointsNear(sight.point, currentPoint, searchRadius.end) &&
//         selectedCategories.contains(sight.category)) {
//       listOfNearbySights.add(SightCard(sight));
//     }
//   });
// }

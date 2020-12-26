import 'package:places/domain/category.dart';
import 'package:places/domain/point.dart';

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

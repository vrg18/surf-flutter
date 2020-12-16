import 'package:places/domain/category.dart';

/// Основной класс места (достопримечательности)
class Sight {
  final String name;
  final double lat;
  final double lon;
  final String url;
  final String details;
  final Category category;

  Sight(
    this.name,
    this.lat,
    this.lon,
    this.url,
    this.details,
    this.category,
  );
}

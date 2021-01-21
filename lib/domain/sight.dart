import 'package:places/domain/category.dart';
import 'package:places/domain/point.dart';

/// Основной класс места (достопримечательности)
class Sight {
  final String name;
  final Point point;
  final String url;
  final String description;
  final Category category;
  final bool notObeyFilters;

  Sight({
    required this.name,
    required this.point,
    this.url = '',
    this.description = '',
    required this.category,
    this.notObeyFilters = false,
  });
}

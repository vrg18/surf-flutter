import 'package:places/domain/category.dart';
import 'package:places/domain/point.dart';

/// Основной класс места (достопримечательности)
class Sight {
  final String name;
  final Point point;
  final String description;
  final Category category;
  final List<String> photos;
  final bool notObeyFilters;

  Sight({
    required this.name,
    required this.point,
    this.description = '',
    required this.category,
    required this.photos,
    this.notObeyFilters = false,
  });

//  List<String> get photos => _photos;
}

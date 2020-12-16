import 'package:places/domain/category.dart';

class Sight {
  String name;
  double lat;
  double lon;
  String url;
  String details;
  Category category;

  Sight(
    this.name,
    this.lat,
    this.lon,
    this.url,
    this.details,
    this.category,
  );
}

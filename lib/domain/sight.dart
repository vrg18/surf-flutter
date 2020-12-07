import 'package:places/domain/category.dart';

class Sight {
  late String nameSight;
  late double lat;
  late double lon;
  late String url;
  late String details;
  late Category type;

  Sight(
    this.nameSight,
    this.lat,
    this.lon,
    this.url,
    this.details,
    this.type,
  );
}

import 'dart:math';

/// Класс для точки на карте
class Point {
  double lat;
  double lon;

  Point(this.lat, this.lon);
}

/// Метод вычисляет, находится ли контрольная точка от исходной точки на расстоянии, меньшим заданного
/// @distance в метрах
bool arePointsNear(Point checkPoint, Point startingPoint, int distance) {
  var ky = 40000000 / 360;
  var kx = cos(pi * startingPoint.lat / 180.0) * ky;
  var dx = (startingPoint.lon - checkPoint.lon).abs() * kx;
  var dy = (startingPoint.lat - checkPoint.lat).abs() * ky;
  return sqrt(dx * dx + dy * dy) < distance;
}

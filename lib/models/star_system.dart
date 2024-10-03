import 'package:flutter_solar_system/models/planet.dart';
import 'package:three_dart/three3d/three.dart' as three;

class StarSystem {
  final three.Mesh star;
  final List<Planet> planets;

  StarSystem({
    required this.star,
    required this.planets,
  });
}

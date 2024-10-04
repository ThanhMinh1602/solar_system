import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter_solar_system/gen/assets.gen.dart';
import 'package:flutter_solar_system/models/base_mesh.dart';
import 'package:flutter_solar_system/models/planet.dart';
import 'package:flutter_solar_system/params/create_planet_params.dart';
import 'package:flutter_solar_system/params/planet_ring_params.dart';
import 'package:three_dart/three_dart.dart' as three;

const int _sphereSegments = 30;
const int _ringSegments = 32;
const double _ringRotation = -0.5 * math.pi;

class PlanetUtil {
  factory PlanetUtil() {
    return _instance;
  }
  PlanetUtil._();

  static final PlanetUtil _instance = PlanetUtil._();
  static PlanetUtil get instance => _instance;
  Future<Planet> initializePlanet(three.Scene scene) async {
    return Planet(
      mecury: await createPlanet(
        CreatePlanetParams(
          size: 3.2,
          texture: Assets.textures.mercury.path,
          position: 28,
        ),
        scene,
      ),
      venus: await createPlanet(
        CreatePlanetParams(
          size: 5.8,
          texture: Assets.textures.venus.path,
          position: 44,
        ),
        scene,
      ),
      saturn: await createPlanet(
        CreatePlanetParams(
          size: 10,
          texture: Assets.textures.saturn.path,
          position: 138,
          planetRingParams: PlanetRingParams(
            innerRadius: 10,
            outerRadius: 20,
            texture: Assets.textures.saturnRing.path,
          ),
        ),
        scene,
      ),
      earth: await createPlanet(
        CreatePlanetParams(
          size: 6,
          texture: Assets.textures.earth.path,
          position: 62,
        ),
        scene,
      ),
      jupiter: await createPlanet(
        CreatePlanetParams(
          size: 12,
          texture: Assets.textures.jupiter.path,
          position: 100,
        ),
        scene,
      ),
      mars: await createPlanet(
        CreatePlanetParams(
          size: 4,
          texture: Assets.textures.mars.path,
          position: 78,
        ),
        scene,
      ),
      uranus: await createPlanet(
        CreatePlanetParams(
          size: 7,
          texture: Assets.textures.uranus.path,
          position: 176,
          planetRingParams: PlanetRingParams(
            innerRadius: 7,
            outerRadius: 12,
            texture: Assets.textures.uranusRing.path,
          ),
        ),
        scene,
      ),
      neptune: await createPlanet(
        CreatePlanetParams(
          size: 7,
          texture: Assets.textures.neptune.path,
          position: 200,
        ),
        scene,
      ),
      pluto: await createPlanet(
        CreatePlanetParams(
          size: 2.8,
          texture: Assets.textures.mercury.path,
          position: 216,
        ),
        scene,
      ),
    );
  }

  Future<BaseMesh> createPlanet(
    CreatePlanetParams createPlanetParams,
    three.Scene scene,
  ) async {
    final geo = three.SphereGeometry(
      createPlanetParams.size,
      _sphereSegments,
      _sphereSegments,
    );
    final mecuryTextureLoader = three.TextureLoader(null);
    final mat = three.MeshStandardMaterial({
      'map': await mecuryTextureLoader.loadAsync(
        createPlanetParams.texture,
      ),
    });
    final mesh = three.Mesh(geo, mat);
    final object3d = three.Object3D()..add(mesh);
    if (createPlanetParams.planetRingParams != null) {
      final ring = createPlanetParams.planetRingParams;
      final ringGeo = three.RingGeometry(
        ring!.innerRadius,
        ring.outerRadius,
        _ringSegments,
      );
      final ringTextureLoader = three.TextureLoader(null);
      final ringMat = three.MeshBasicMaterial({
        'map': await ringTextureLoader.loadAsync(
          ring.texture,
        ),
        'side': three.DoubleSide,
      });
      final ringMesh = three.Mesh(ringGeo, ringMat);
      object3d.add(ringMesh);
      ringMesh.position.x = createPlanetParams.position;
      ringMesh.rotation.x = _ringRotation;
    }
    scene.add(object3d);
    mesh.position.x = createPlanetParams.position;
    return BaseMesh(
      mesh: mesh,
      object3d: object3d,
    );
  }

  Future<void> animate({
    required Planet planet,
    required three.Mesh sun,
    required VoidCallback render,
  }) async {
    sun.rotateY(0.004);
    planet.mecury?.rotateMesh(0.004);
    planet.venus?.rotateMesh(0.002);
    planet.earth?.rotateMesh(0.02);
    planet.mars?.rotateMesh(0.018);
    planet.jupiter?.rotateMesh(0.04);
    planet.saturn?.rotateMesh(0.038);
    planet.uranus?.rotateMesh(0.03);
    planet.neptune?.rotateMesh(0.032);
    planet.pluto?.rotateMesh(0.008);

    planet.mecury?.rotateObject3D(0.04);
    planet.venus?.rotateObject3D(0.015);
    planet.earth?.rotateObject3D(0.01);
    planet.mars?.rotateObject3D(0.008);
    planet.jupiter?.rotateObject3D(0.002);
    planet.saturn?.rotateObject3D(0.0009);
    planet.uranus?.rotateObject3D(0.0004);
    planet.neptune?.rotateObject3D(0.0001);
    planet.pluto?.rotateObject3D(0.00007);
    render();
    Future.delayed(const Duration(milliseconds: 40), () {
      animate(
        planet: planet,
        sun: sun,
        render: render,
      );
    });
  }
}

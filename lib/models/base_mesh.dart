import 'dart:convert';

import 'package:three_dart/three3d/core/object_3d.dart';
import 'package:three_dart/three3d/objects/mesh.dart';

class BaseMesh {
  BaseMesh({
    required this.mesh,
    required this.object3d,
  });

  Mesh mesh;
  Object3D object3d;

  BaseMesh copyWith({
    Mesh? mesh,
    Object3D? object3d,
  }) {
    return BaseMesh(
      mesh: mesh ?? this.mesh,
      object3d: object3d ?? this.object3d,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'mesh': mesh,
      'object3d': object3d,
    };
  }

  String toJson() => json.encode(toMap());

  Object3D rotateMesh(double value) => mesh.rotateY(value);

  Object3D rotateObject3D(double value) => object3d.rotateY(value);

}

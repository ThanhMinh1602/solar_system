import 'package:flutter/material.dart';
import 'package:flutter_solar_system/gen/assets.gen.dart';
import 'package:model_viewer_plus/model_viewer_plus.dart';

class GlbViewWidget extends StatelessWidget {
  const GlbViewWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return ModelViewer(
      src: 'https://modelviewer.dev/shared-assets/models/Astronaut.glb',
      alt: 'A 3D model of an astronaut',
      autoRotate: true,
      iosSrc: 'https://modelviewer.dev/shared-assets/models/Astronaut.usdz',
      disableZoom: true,
    );
  }
}

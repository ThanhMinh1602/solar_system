import 'package:flutter/material.dart';
import 'package:flutter_solar_system/gen/assets.gen.dart';
import 'package:model_viewer_plus/model_viewer_plus.dart';

class GlbViewWidget extends StatelessWidget {
  const GlbViewWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return ModelViewer(
      src: Assets.model.blackhole,
      alt: 'A 3D model of an astronaut',
      ar: true,
      autoRotate: true,
      iosSrc: 'https://modelviewer.dev/shared-assets/models/Astronaut.usdz',
      disableZoom: true,
    );
  }
}

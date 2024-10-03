/// GENERATED CODE - DO NOT MODIFY BY HAND
/// *****************************************************
///  FlutterGen
/// *****************************************************

// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: directives_ordering,unnecessary_import,implicit_dynamic_list_literal,deprecated_member_use

import 'package:flutter/widgets.dart';

class $AssetsTexturesGen {
  const $AssetsTexturesGen();

  /// File path: assets/textures/earth.jpg
  AssetGenImage get earth => const AssetGenImage('assets/textures/earth.jpg');

  /// File path: assets/textures/jupiter.jpg
  AssetGenImage get jupiter =>
      const AssetGenImage('assets/textures/jupiter.jpg');

  /// File path: assets/textures/mars.jpg
  AssetGenImage get mars => const AssetGenImage('assets/textures/mars.jpg');

  /// File path: assets/textures/mercury.jpg
  AssetGenImage get mercury =>
      const AssetGenImage('assets/textures/mercury.jpg');

  /// File path: assets/textures/neptune.jpg
  AssetGenImage get neptune =>
      const AssetGenImage('assets/textures/neptune.jpg');

  /// File path: assets/textures/pluto.jpg
  AssetGenImage get pluto => const AssetGenImage('assets/textures/pluto.jpg');

  /// File path: assets/textures/saturn.jpg
  AssetGenImage get saturn => const AssetGenImage('assets/textures/saturn.jpg');

  /// File path: assets/textures/saturn_ring.png
  AssetGenImage get saturnRing =>
      const AssetGenImage('assets/textures/saturn_ring.png');

  /// File path: assets/textures/stars.jpg
  AssetGenImage get stars => const AssetGenImage('assets/textures/stars.jpg');

  /// File path: assets/textures/stars1.jpg
  AssetGenImage get stars1 => const AssetGenImage('assets/textures/stars1.jpg');

  /// File path: assets/textures/sun.jpg
  AssetGenImage get sun => const AssetGenImage('assets/textures/sun.jpg');

  /// File path: assets/textures/uranus.jpg
  AssetGenImage get uranus => const AssetGenImage('assets/textures/uranus.jpg');

  /// File path: assets/textures/uranus_ring.png
  AssetGenImage get uranusRing =>
      const AssetGenImage('assets/textures/uranus_ring.png');

  /// File path: assets/textures/venus.jpg
  AssetGenImage get venus => const AssetGenImage('assets/textures/venus.jpg');

  /// List of all assets
  List<AssetGenImage> get values => [
        earth,
        jupiter,
        mars,
        mercury,
        neptune,
        pluto,
        saturn,
        saturnRing,
        stars,
        stars1,
        sun,
        uranus,
        uranusRing,
        venus
      ];
}

class Assets {
  Assets._();

  static const $AssetsTexturesGen textures = $AssetsTexturesGen();
}

class AssetGenImage {
  const AssetGenImage(
    this._assetName, {
    this.size,
    this.flavors = const {},
  });

  final String _assetName;

  final Size? size;
  final Set<String> flavors;

  Image image({
    Key? key,
    AssetBundle? bundle,
    ImageFrameBuilder? frameBuilder,
    ImageErrorWidgetBuilder? errorBuilder,
    String? semanticLabel,
    bool excludeFromSemantics = false,
    double? scale,
    double? width,
    double? height,
    Color? color,
    Animation<double>? opacity,
    BlendMode? colorBlendMode,
    BoxFit? fit,
    AlignmentGeometry alignment = Alignment.center,
    ImageRepeat repeat = ImageRepeat.noRepeat,
    Rect? centerSlice,
    bool matchTextDirection = false,
    bool gaplessPlayback = false,
    bool isAntiAlias = false,
    String? package,
    FilterQuality filterQuality = FilterQuality.low,
    int? cacheWidth,
    int? cacheHeight,
  }) {
    return Image.asset(
      _assetName,
      key: key,
      bundle: bundle,
      frameBuilder: frameBuilder,
      errorBuilder: errorBuilder,
      semanticLabel: semanticLabel,
      excludeFromSemantics: excludeFromSemantics,
      scale: scale,
      width: width,
      height: height,
      color: color,
      opacity: opacity,
      colorBlendMode: colorBlendMode,
      fit: fit,
      alignment: alignment,
      repeat: repeat,
      centerSlice: centerSlice,
      matchTextDirection: matchTextDirection,
      gaplessPlayback: gaplessPlayback,
      isAntiAlias: isAntiAlias,
      package: package,
      filterQuality: filterQuality,
      cacheWidth: cacheWidth,
      cacheHeight: cacheHeight,
    );
  }

  ImageProvider provider({
    AssetBundle? bundle,
    String? package,
  }) {
    return AssetImage(
      _assetName,
      bundle: bundle,
      package: package,
    );
  }

  String get path => _assetName;

  String get keyName => _assetName;
}

import 'dart:convert';

class ConfigOptions {
  ConfigOptions({
    required this.antialias,
    required this.alpha,
    required this.width,
    required this.height,
    this.dpr,
    this.canvas,
    this.gl,
  });

  bool antialias;
  bool alpha;
  num width;
  num height;
  double? dpr;
  dynamic gl;
  dynamic canvas;

  ConfigOptions copyWith({
    bool? antialias,
    bool? alpha,
    int? width,
    int? height,
    double? dpr,
    dynamic canvas,
    dynamic gl,
  }) {
    return ConfigOptions(
      antialias: antialias ?? this.antialias,
      alpha: alpha ?? this.alpha,
      width: width ?? this.width,
      height: height ?? this.height,
      dpr: dpr ?? this.dpr,
      canvas: canvas ?? this.canvas,
      gl: gl ?? this.gl,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'antialias': antialias,
      'alpha': alpha,
      'width': width,
      'height': height,
      'dpr': dpr,
      'cavas': canvas,
      'gl': gl,
    };
  }

  String toJson() => json.encode(toMap());

  @override
  String toString() {
    return 'ConfigOptions(antialias: $antialias, alpha: $alpha, width: $width, height: $height, dpr: $dpr)';
  }
}

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gl/flutter_gl.dart';
import 'package:flutter_solar_system/gen/assets.gen.dart';
import 'package:flutter_solar_system/models/config_options.dart';
import 'package:flutter_solar_system/models/planet.dart';
import 'package:flutter_solar_system/res/extensions/planet_extension.dart';
import 'package:three_dart/three_dart.dart' as three;
import 'package:three_dart_jsm/three_dart_jsm.dart' as three_jsm;

class SolarSystemWidget extends StatefulWidget {
  const SolarSystemWidget({super.key});

  @override
  State<SolarSystemWidget> createState() => _SolarSystemWidgetState();
}

class _SolarSystemWidgetState extends State<SolarSystemWidget> {
  late final GlobalKey<three_jsm.DomLikeListenableState> _domLikeKey;

  three.WebGLRenderer? renderer;
  three.WebGLRenderTarget? renderTarget;

  late FlutterGlPlugin three3dRender;

  late double width;
  late double height;
  late three.Scene _scene;
  late three.Camera _camera;
  Size? screenSize;
  double dpr = 1;
  late int sourceTexture;

  late three.Mesh _sun;
  late Planet _planet;

  @override
  void initState() {
    super.initState();
    _domLikeKey = GlobalKey();
    _planet = const Planet();
  }

  @override
  Widget build(BuildContext context) {
    return three_jsm.DomLikeListenable(
      key: _domLikeKey,
      builder: (context) {
        _initSize();
        return Builder(
          builder: (BuildContext context) {
            if (three3dRender.isInitialized) {
              if (kIsWeb) {
                return HtmlElementView(
                  viewType: three3dRender.textureId!.toString(),
                );
              }
              return Texture(
                textureId: three3dRender.textureId!,
              );
            }
            return Container();
          },
        );
      },
    );
  }

  void _initSize() {
    if (screenSize != null) return;

    final mediaQuery = MediaQuery.of(context);
    screenSize = mediaQuery.size;
    dpr = mediaQuery.devicePixelRatio;

    _initPlatformState();
  }

  Future<void> _initPlatformState() async {
    width = screenSize!.width;
    height = screenSize!.height;

    three3dRender = FlutterGlPlugin();

    // Tạo cònig cấu hình WebGL plugin.
    final options = ConfigOptions(
      antialias: true,
      alpha: true,
      width: width.toInt(),
      height: height.toInt(),
      dpr: dpr,
    );

    await three3dRender.initialize(options: options.toMap());
    setState(() {});

    Future.delayed(const Duration(milliseconds: 100), () async {
      await three3dRender.prepareContext();
      await _initScene(); // khởi tạo cảnh 3D.
    });
  }

  Future<void> _initScene() async {
    await _initRenderer();
    _scene = three.Scene(); // tạo scene mới.

    // tạo camera
    _camera = three.PerspectiveCamera(45, width / height, 0.1, 1000);
    final orbit = three_jsm.OrbitControls(
        _camera, _domLikeKey); // Sxoay camera bằng OrbitControls
    _camera.position.set(190, 140, 300); // vị trí camera.
    orbit.update();

    // ánh sáng nối trg
    final ambientLight = three.AmbientLight(0x333333);
    _scene.add(ambientLight); // Thêm ánh sáng vào scene.

    // Tải và áp dụng hình nền (texture các vì sao).
    // final backgroundTextureLoader = three.TextureLoader(null);
    // final backgroundTexture = await backgroundTextureLoader.loadAsync(
    //   Assets.textures.stars.path,
    // );
    // _scene.background = backgroundTexture; // Đặt texture nền.

    // tạo hệ mặt trời.
    await _createSolarSystem();
  }

  Future<void> _initRenderer() async {
    final options = ConfigOptions(
      antialias: true,
      alpha: true,
      width: width,
      height: height,
      gl: three3dRender.gl,
    );

    renderer = three.WebGLRenderer(options.toMap());
    renderer!.setPixelRatio(dpr); // Đặt tỷ lệ pixel.
    renderer!.setSize(width, height); // Đặt kích thước renderer.
    renderer!.shadowMap.enabled = true; // Bật đổ bóng.

    if (!kIsWeb) {
      final pars = three.WebGLRenderTargetOptions({'format': three.RGBAFormat});
      renderTarget = three.WebGLRenderTarget(
        (width * dpr).toInt(),
        (height * dpr).toInt(),
        pars,
      );
      renderTarget!.samples = 4;
      renderer!.setRenderTarget(renderTarget);
      sourceTexture = renderer!.getRenderTargetGLTexture(renderTarget!);
    } else {
      renderTarget = null;
    }
  }

  Future<void> _createSolarSystem() async {
    // tạohình cầu cho mặt trời và tải texture mặt trời.
    final sunGeo = three.SphereGeometry(16, 30, 30);
    final sunTextureLoader = three.TextureLoader(null);
    final sunMat = three.MeshBasicMaterial({
      'map': await sunTextureLoader.loadAsync(Assets.textures.sun.path),
    });
    _sun = three.Mesh(sunGeo, sunMat); // tạo mesh cho mặt trời.
    _scene.add(_sun); // thêm mặt trời vào scene.

    // thêm ánh sáng điểm từ mặt trời.
    final pointLight = three.PointLight(0xFFFFFFFF, 2, 300);
    _scene.add(pointLight);

    //  tạo các hành tinh vào scene.
    _planet = await _planet.initializePlanets(_scene);

    // hoạt ảnh quay quanh mặt trời.
    await _planet.animate(
      sun: _sun,
      planet: _planet,
      render: () {
        renderer!.render(_scene, _camera);
      },
    );
  }
}

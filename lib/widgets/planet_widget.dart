// import 'package:flutter/foundation.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_gl/flutter_gl.dart';
// import 'package:flutter_solar_system/gen/assets.gen.dart';
// import 'package:flutter_solar_system/models/config_options.dart';
// import 'package:flutter_solar_system/models/planet.dart';
// import 'package:flutter_solar_system/res/extensions/planet_extension.dart';
// import 'package:three_dart/three_dart.dart' as three;
// import 'package:three_dart_jsm/three_dart_jsm.dart' as three_jsm;

// class Planetwidget extends StatefulWidget {
//   const Planetwidget({super.key});

//   @override
//   State<Planetwidget> createState() => _PlanetwidgetState();
// }

// class _PlanetwidgetState extends State<Planetwidget> {
//   /// Keys
//   late final GlobalKey<three_jsm.DomLikeListenableState> _domLikeKey;

//   /// three
//   three.WebGLRenderer? renderer;
//   three.WebGLRenderTarget? renderTarget;

//   /// GL
//   late FlutterGlPlugin three3dRender;

//   /// config
//   late double width;
//   late double height;
//   late three.Scene _scene;
//   late three.Camera _camera;
//   Size? screenSize;
//   double dpr = 1;
//   late int sourceTexture;

//   /// planets
//   late three.Mesh _sun;
//   late Planet _planet;

//   @override
//   void initState() {
//     super.initState();
//     _domLikeKey = GlobalKey(); // Khóa để kiểm soát widget DomLikeListenable.
//     _planet = const Planet(); // Khởi tạo đối tượng Planet rỗng.
//   }

//   @override
//   Widget build(BuildContext context) {
//     return three_jsm.DomLikeListenable(
//       key: _domLikeKey, // Sử dụng DomLikeListenable để tương tác với WebGL.
//       builder: (context) {
//         _initSize(); // Khởi tạo kích thước màn hình và dpr (device pixel ratio).
//         return Builder(
//           builder: (BuildContext context) {
//             if (three3dRender.isInitialized) {
//               // Nếu chạy trên web, sử dụng `HtmlElementView`, ngược lại sử dụng `Texture`.
//               if (kIsWeb) {
//                 return HtmlElementView(
//                   viewType: three3dRender.textureId!.toString(),
//                 );
//               }
//               return Texture(
//                 textureId: three3dRender.textureId!,
//               );
//             }
//             return Container(); // Hiển thị container trống nếu chưa khởi tạo xong.
//           },
//         );
//       },
//     );
//   }

//   void _initSize() {
//     if (screenSize != null) return; // Nếu đã lấy kích thước, không làm lại.

//     final mediaQuery =
//         MediaQuery.of(context); // Lấy kích thước màn hình từ MediaQuery.
//     screenSize = mediaQuery.size; // Gán kích thước màn hình.
//     dpr =
//         mediaQuery.devicePixelRatio; // Gán tỷ lệ điểm ảnh trên màn hình (DPR).

//     _initPlatformState(); // Khởi tạo trạng thái nền tảng (GL và WebGL).
//   }

//   Future<void> _initPlatformState() async {
//     width = screenSize!.width; // Gán chiều rộng màn hình.
//     height = screenSize!.height; // Gán chiều cao màn hình.

//     three3dRender = FlutterGlPlugin(); // Khởi tạo FlutterGlPlugin cho WebGL.

//     // Tạo đối tượng ConfigOptions để cấu hình WebGL plugin.
//     final options = ConfigOptions(
//       antialias: true, // Bật khử răng cưa.
//       alpha: true, // Sử dụng nền trong suốt.
//       width: width.toInt(),
//       height: height.toInt(),
//       dpr: dpr,
//     );

//     await three3dRender.initialize(
//         options: options.toMap()); // Khởi tạo WebGL plugin với cấu hình.
//     setState(() {}); // Cập nhật trạng thái để hiển thị giao diện.

//     Future.delayed(const Duration(milliseconds: 100), () async {
//       await three3dRender.prepareContext(); // Chuẩn bị context WebGL.
//       await _initScene(); // Khởi tạo cảnh 3D.
//     });
//   }

//   Future<void> _initScene() async {
//     await _initRenderer(); // Khởi tạo renderer WebGL.
//     _scene = three.Scene(); // Tạo scene mới.

//     // Tạo camera với góc nhìn 45 độ, tỉ lệ khung hình, và cắt gần - xa.
//     _camera = three.PerspectiveCamera(90, width / height, 0.1, 1000);
//     final orbit = three_jsm.OrbitControls(
//         _camera, _domLikeKey); // Sử dụng OrbitControls để xoay camera.
//     _camera.position.set(190, 140, 300); // Đặt vị trí camera.
//     orbit.update(); // Cập nhật trạng thái camera.

//     // Thêm ánh sáng môi trường để làm sáng cảnh.
//     final ambientLight = three.AmbientLight(0x333333);
//     _scene.add(ambientLight); // Thêm ánh sáng vào scene.
//     // Gọi hàm khởi tạo hệ mặt trời.
//     await _createSolarSystem();
//   }

//   Future<void> _initRenderer() async {
//     final options = ConfigOptions(
//       antialias: true, // Khử răng cưa.
//       alpha: true, // Nền trong suốt.
//       width: width,
//       height: height,
//       gl: three3dRender.gl, // Sử dụng ngữ cảnh WebGL của FlutterGlPlugin.
//     );
//     // Khởi tạo WebGLRenderer với các tùy chọn cấu hình.
//     renderer = three.WebGLRenderer(options.toMap());
//     renderer!.setPixelRatio(dpr); // Đặt tỷ lệ pixel.
//     renderer!.setSize(width, height); // Đặt kích thước renderer.
//     renderer!.shadowMap.enabled = true; // Bật đổ bóng.

//     if (!kIsWeb) {
//       final pars = three.WebGLRenderTargetOptions({'format': three.RGBAFormat});
//       renderTarget = three.WebGLRenderTarget(
//         (width * dpr).toInt(),
//         (height * dpr).toInt(),
//         pars,
//       );
//       renderTarget!.samples = 4; // Tăng chất lượng mẫu.
//       renderer!.setRenderTarget(renderTarget); // Đặt render target.
//       sourceTexture = renderer!.getRenderTargetGLTexture(
//           renderTarget!); // Lấy texture của render target.
//     } else {
//       renderTarget = null; // Nếu là web, không cần render target.
//     }
//   }

//   Future<void> _createSolarSystem() async {
//     // Tạo hình cầu cho mặt trời và tải texture mặt trời.
//     final sunGeo = three.SphereGeometry(16, 30, 30);
//     final sunTextureLoader = three.TextureLoader(null);
//     final sunMat = three.MeshBasicMaterial({
//       'map': await sunTextureLoader.loadAsync(Assets.textures.sun.path),
//     });
//     _sun = three.Mesh(sunGeo, sunMat); // Tạo đối tượng mesh cho mặt trời.
//     _scene.add(_sun); // Thêm mặt trời vào scene.

//     // Thêm ánh sáng điểm từ mặt trời.
//     final pointLight = three.PointLight(0xFFFFFFFF, 2, 300);
//     _scene.add(pointLight);
//     // Bắt đầu hoạt ảnh quay quanh mặt trời.
//     await _planet.animate(
//       sun: _sun,
//       planet: _planet,
//       render: () {
//         renderer!.render(_scene, _camera);
//       },
//     );
//   }
// }

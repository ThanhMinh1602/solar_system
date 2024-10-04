import 'package:three_dart_jsm/three_dart_jsm.dart' as three_jsm;
import 'package:three_dart/three3d/three.dart' as three;

class LoadGlbUtils {
  // Phương thức tĩnh để tải mô hình GLB từ đường dẫn
  static Future<three.Object3D?> loadGLBModel(
      String path, three.Scene scene) async {
    final loader = three_jsm.GLTFLoader(null); // Khởi tạo GLTFLoader

    try {
      // Tải tệp GLB
      final gltf = await loader.loadAsync(path);

      // Lấy đối tượng chính từ mô hình
      final object = gltf["scene"] as three.Object3D;

      // Đặt vị trí ban đầu cho đối tượng (có thể điều chỉnh sau)
      object.position.set(0, 0, 0);

      // Thêm đối tượng vào scene
      scene.add(object);

      return object; // Trả về đối tượng đã tải
    } catch (e) {
      print("Error loading GLB model: $e");
      return null; // Trả về null nếu có lỗi xảy ra
    }
  }
}

import 'package:image_picker/image_picker.dart';

class FilePickerHelper {
  static Future<String?> imagePicker({int imageQuality = 25}) async {
    // ignore: invalid_use_of_visible_for_testing_member
    try {
      String path = await ImagePicker.platform
          .getImage(source: ImageSource.gallery, imageQuality: imageQuality)
          .then((img) {
        return img?.path ?? '';
      });
      return path == '' ? null : path;
    } catch (e) {
      return null;
    }
  }
}

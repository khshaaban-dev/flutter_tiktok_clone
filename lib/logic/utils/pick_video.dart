import 'package:image_picker/image_picker.dart';

Future<String?> pickVideo({required ImageSource source}) async {
  final video = await ImagePicker().pickVideo(
    source: source,
  );

  return video?.path;
}

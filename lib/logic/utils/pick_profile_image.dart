import 'package:image_picker/image_picker.dart';

Future<String?> pickImage({required ImageSource source}) async {
  final image = await ImagePicker().pickImage(
    source: source,
  );

  return image?.path;
}

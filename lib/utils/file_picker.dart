import 'package:file_picker/file_picker.dart';

Future<String> pickImage() async {
  FilePickerResult? result = await FilePicker.platform.pickFiles(
    type: FileType.image,
  );

  if (result != null) {
    PlatformFile file = result.files.first;
    String imagePath = file.path!;
    return imagePath;
  } else {
    throw Exception('error');
  }
}

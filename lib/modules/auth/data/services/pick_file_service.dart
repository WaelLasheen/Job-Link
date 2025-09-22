import 'dart:io';
import 'package:file_picker/file_picker.dart';

class PickFileService {
  static final PickFileService _instance = PickFileService._internal();
  factory PickFileService() => _instance;
  PickFileService._internal();

  Future<File?> pickFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf', 'doc', 'docx'],
    );
    if (result != null) {
      return File(result.files.first.path!);
    }
    return null;
  }
}

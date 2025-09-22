import 'dart:io';
import 'package:supabase_flutter/supabase_flutter.dart';

class SupabaseCloudService {
  static final SupabaseCloudService _instance =
      SupabaseCloudService._internal();
  factory SupabaseCloudService() => _instance;
  SupabaseCloudService._internal();

  Future<String?> uploadCV(File file) async {
    final supabase = Supabase.instance.client;

    try {
      String fileName = file.path.split('/').last;
      StorageFileApi storage = supabase.storage.from('freelancers_CV');

      await storage.upload(
        fileName,
        file,
        fileOptions: const FileOptions(upsert: true),
      );

      return storage.getPublicUrl(fileName);
    } catch (e) {
      throw 'Error in supabase upload: $e';
    }
  }
}

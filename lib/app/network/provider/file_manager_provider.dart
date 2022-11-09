import 'dart:io';

import 'package:path_provider/path_provider.dart';

class FileManagerProvider {
  // static String path = '/HCP';
  late Directory path;
  static String subMedia = '/Media';
  static String subBackups = '/Backups';
  static String subDatabases = '/Databases';
  static String subMediaAudio = '/HCP Audio';
  static String subMediaVideo = '/HCP Video';
  static String subMediaImages = '/HCP Images';
  static String subMediaDocuments = '/HCP Documents';
  static String subMediaStickers = '/HCP Stickers';

  init<FileManagerProvider>() async {
    path = await getApplicationDocumentsDirectory();
    return this;
  }

  saveFile({required String path, required File file}) {}

  File readFile({required String path}) {
    return File(path);
  }
}

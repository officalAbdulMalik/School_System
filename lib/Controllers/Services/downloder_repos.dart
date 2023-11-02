import 'dart:io';

import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

class Downloader {
  static Future startDownload(String url) async {
    // final directory = await getExternalStorageDirectory();
    // final directory = await getExternalStorageDirectory();

    final status = await Permission.storage.request();

    if (status.isGranted) {
      List<Directory>? directory =
          await getExternalStorageDirectories(type: StorageDirectory.downloads);
      final myFilePath = '${directory![0].path}/SchoolApp';

      final myImgDir = await Directory(myFilePath).create();
      // print(myImgDir);
      final taskId = await FlutterDownloader.enqueue(
        url: url,
        headers: {},
        // optional: header send with url (auth token etc)
        savedDir: myImgDir.path,
        //  showNotification: true,
        // show download progress in status bar (for Android)
        openFileFromNotification: true,
        // click on notification to open downloaded file (for Android)
        saveInPublicStorage: true,
      );
      print(taskId);
    }
  }
}

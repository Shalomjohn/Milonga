import 'dart:io';

import 'package:dio/dio.dart';

Future downloadFile(Dio dio, String url, String savePath,
    Function(int, int) showDownloadProgress) async {
  try {
    Response response = await dio.get(
      url,
      onReceiveProgress: showDownloadProgress,
    );
    print(response.headers);
    // File file = File(savePath);
    // var raf = file.openSync(mode: FileMode.write);
    // raf.writeFromSync(response.data);
    // await raf.close();
  } catch (e) {
    print(e);
  }
}

import 'dart:io';

import 'package:dio/dio.dart';

Future downloadFile(Dio dio, String url, String savePath,
    Function(int, int) showDownloadProgress, CancelToken cancelToken) async {
  try {
    Response response = await dio.download(url, savePath,
        onReceiveProgress: showDownloadProgress, cancelToken: cancelToken);
    print(response.headers);
  } catch (e) {
    print(e);
  }
}

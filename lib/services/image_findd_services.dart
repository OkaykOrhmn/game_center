import 'dart:io';

import 'package:dio/dio.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

class ImageFinddServices {
  //https://www.googleapis.com/customsearch/v1?q=cats&searchType=image&key=YOUR_API_KEY&cx=YOUR_CSE_ID
  // static final String _apiKey = 'AIzaSyBb9grNX5z7pmNZArqeSClKeobyobQiZxA';

  static final Dio _dio = Dio(BaseOptions(
      // baseUrl: 'https://www.googleapis.com',
      connectTimeout: Duration(seconds: 30),
      sendTimeout: Duration(seconds: 30),
      receiveTimeout: Duration(seconds: 30)))
    ..interceptors.add(PrettyDioLogger());

  static Future<PlatformFile?> downloadAndSaveImage(String imageUrl,
      {final String? name}) async {
    try {
      final response = await _dio.get(imageUrl,
          options: Options(responseType: ResponseType.bytes));
      final directory = await getApplicationDocumentsDirectory();
      final sanitizedFileName =
          (name ?? 'Image-${DateTime.now().toIso8601String()}')
              .replaceAll(':', '-')
              .replaceAll('/', '-');
      final filePath = '${directory.path}/$sanitizedFileName.jpg';
      final file = File(filePath);
      await file.writeAsBytes(response.data);
      if (kDebugMode) {
        print('Image saved to $filePath');
      }

      // Create and return a PlatformFile object
      return PlatformFile(
        name: file.uri.pathSegments.last,
        path: file.path,
        size: await file.length(),
        bytes: response.data,
      );
    } catch (e) {
      if (kDebugMode) {
        print('Error downloading image: $e');
      }
      return null;
    }
  }
}

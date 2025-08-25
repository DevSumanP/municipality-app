import 'package:dio/dio.dart';
import '../../../core/network/dio_client.dart';
import '../../../core/exceptions/app_exceptions.dart';

class MediaRemoteDataSource {
  final DioClient dioClient;

  MediaRemoteDataSource({required this.dioClient});

  Future<void> downloadFile(
    String url,
    String savePath, {
    Function(int, int)? onReceiveProgress,
  }) async {
    try {
      await dioClient.download(
        url,
        savePath,
        onReceiveProgress: onReceiveProgress,
      );
    } on DioException catch (e) {
      if (e.response?.statusCode == 404) {
        throw AppException.notFound('File not found');
      } else {
        throw AppException.network('Download failed');
      }
    } catch (e) {
      throw AppException.unknown('An unknown error occurred during download');
    }
  }

  Future<bool> checkFileExists(String url) async {
    try {
      final response = await dioClient.head(url);
      return response.statusCode == 200;
    } catch (e) {
      return false;
    }
  }
}
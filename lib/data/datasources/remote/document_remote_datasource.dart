import 'package:dio/dio.dart';
import '../../../core/network/dio_client.dart';
import '../../../core/constants/api_endpoints.dart';
import '../../../core/exceptions/app_exceptions.dart';
import '../../models/document_model.dart';

class DocumentRemoteDataSource {
  final DioClient dioClient;

  DocumentRemoteDataSource({required this.dioClient});

  Future<DocumentModel> getNotices() async {
    try {
      final response = await dioClient.get(ApiEndpoints.notices);

      if (response.statusCode == 200) {
        return DocumentModel.fromJson(response.data);
      } else {
        throw AppException.server('Failed to fetch notices');
      }
    } on DioException catch (e) {
      if (e.response?.statusCode == 401) {
        throw AppException.unauthorized('Session expired');
      } else {
        throw AppException.network('Network error occurred');
      }
    } catch (e) {
      throw AppException.unknown('An unknown error occurred');
    }
  }

  Future<DocumentModel> getScrollingNews() async {
    try {
      final response = await dioClient.get(ApiEndpoints.scrollingNews);

      if (response.statusCode == 200) {
        return DocumentModel.fromJson(response.data);
      } else {
        throw AppException.server('Failed to fetch scrolling news');
      }
    } on DioException catch (e) {
      if (e.response?.statusCode == 401) {
        throw AppException.unauthorized('Session expired');
      } else {
        throw AppException.network('Network error occurred');
      }
    } catch (e) {
      throw AppException.unknown('An unknown error occurred');
    }
  }

  Future<DocumentModel> getVideos() async {
    try {
      final response = await dioClient.get(ApiEndpoints.dashboardVideos);

      if (response.statusCode == 200) {
        return DocumentModel.fromJson(response.data);
      } else {
        throw AppException.server('Failed to fetch videos');
      }
    } on DioException catch (e) {
      if (e.response?.statusCode == 401) {
        throw AppException.unauthorized('Session expired');
      } else {
        throw AppException.network('Network error occurred');
      }
    } catch (e) {
      throw AppException.unknown('An unknown error occurred');
    }
  }
}
// Helper method to reduce code duplication
import 'package:dio/dio.dart';
import 'package:municipality_app/core/exceptions/app_exceptions.dart';

List<T> handleListResponse<T>(
    Response response,
    T Function(Map<String, dynamic>) fromJson,
    String resourceName,
  ) {
    if (response.statusCode == 200) {
      try {
        final data = response.data;
        
        // Handle different response structures
        List<dynamic> jsonList;
        if (data is List) {
          jsonList = data;
        } else if (data is Map<String, dynamic>) {
          // If API wraps data in an object like {"data": [...], "results": [...]}
          jsonList = data['data'] as List<dynamic>? ?? 
                     data['results'] as List<dynamic>? ?? 
                     data['items'] as List<dynamic>? ??
                     [data]; // Single object case
        } else {
          throw AppException.parsing('Invalid response format for $resourceName');
        }
        
        return jsonList
            .cast<Map<String, dynamic>>()
            .map((json) => fromJson(json))
            .toList();
            
      } catch (e) {
        if (e is AppException) rethrow;
        throw AppException.parsing('Failed to parse $resourceName response: $e');
      }
    } else {
      throw handleHttpStatusCode(response.statusCode, resourceName);
    }
  }
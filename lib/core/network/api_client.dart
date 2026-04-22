import 'package:dio/dio.dart';
import 'api_constants.dart';

// Dio HTTP client
class ApiClient {
  static final ApiClient _instance = ApiClient._internal();
  factory ApiClient() => _instance;

  late final Dio dio;

  ApiClient._internal() {
    dio = Dio(
      BaseOptions(
        baseUrl: ApiConstants.baseUrl,
        connectTimeout: const Duration(seconds: 10),
        receiveTimeout: const Duration(seconds: 10),
        headers: {
          'Content-Type': 'application/json',
          'X-Admin-Key': ApiConstants.adminApiKey,
        },
      ),
    );

    dio.interceptors.add(
      InterceptorsWrapper(
        onError: (error, handler) {
          final message = _mapDioError(error);
          handler.reject(
            DioException(
              requestOptions: error.requestOptions,
              response: error.response,
              type: error.type,
              error: message,
            ),
          );
        },
      ),
    );
  }

  // Map Dio errors to user-friendly messages
  static String _mapDioError(DioException error) {
    switch (error.type) {
      case DioExceptionType.connectionError:
      case DioExceptionType.connectionTimeout:
        return 'Unable to connect to the server.';
      case DioExceptionType.receiveTimeout:
      case DioExceptionType.sendTimeout:
        return 'Server took too long to respond. Please try again.';
      case DioExceptionType.badResponse:
        final statusCode = error.response?.statusCode ?? 0;
        if (statusCode == 401) return 'Unauthorized. Check your admin key.';
        if (statusCode == 403) return 'Access denied.';
        if (statusCode == 404) return 'Resource not found.';
        if (statusCode == 409) return 'This resource already exists.';
        if (statusCode >= 500) return 'Server error. Please try again later.';

        final data = error.response?.data;
        if (data is Map && data.containsKey('detail')) return data['detail'];
        return 'Request failed (status $statusCode).';

      case DioExceptionType.cancel:
        return 'Request cancelled.';
      default:
        return 'Something went wrong. Please try again.';
    }
  }
}

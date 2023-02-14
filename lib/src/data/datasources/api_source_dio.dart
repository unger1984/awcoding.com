import 'package:dio/dio.dart';
import 'package:portfolio/src/domain/datasources/api_source.dart';
import 'package:portfolio/src/utils/logger.dart';

/// [Dio] реализация поставщика данных API.
class ApiSourceDio extends ApiSource {
  late Dio _dio;
  final String baseUrl;
  final List<Interceptor>? interceptors;
  Future<String?> Function()? _onRefresh;
  void Function()? _onLogout;

  // baseUrl - базовая ссылка на API.
  // dio - экземпляр [Dio].
  // interceptors - интерсепторы для [Dio]
  ApiSourceDio({
    required this.baseUrl,
    Dio? dio,
    this.interceptors,
  }) {
    _dio = dio ?? Dio();
    _dio
      ..options.baseUrl = baseUrl
      ..options.connectTimeout = const Duration(seconds: 5)
      ..options.receiveTimeout = const Duration(seconds: 3)
      ..httpClientAdapter
      ..options.headers = {
        'Connection-Type': 'application/json; charset=UTF-8',
      };

    _addRefreshInterseptor();
  }

  /// Добавляет интерсептор для обновления RefreshToken.
  void _addRefreshInterseptor() {
    _dio.interceptors.clear();
    _dio.interceptors.add(
      InterceptorsWrapper(
        onError: (error, handler) async {
          if (error.response?.statusCode == 401 || error.response?.statusCode == 403) {
            // Сохраняем колбэки.
            final onRefresh = _onRefresh;
            final onLogout = _onLogout;
            // Очищаем старый колбек чтобы он не вызывался сам на себя.
            _onRefresh = null;
            try {
              // Если задан коллбек для восстановления токена.
              if (onRefresh != null) {
                final updatedToken = await onRefresh();
                if (updatedToken != null) {
                  // Если коллбек вернул новый токен.
                  error.requestOptions.headers["Authorization"] =
                      _dio.options.headers['Authorization'] = 'Bearer $updatedToken';
                  // Повторим предыдущий запрос.
                  final opts = Options(method: error.requestOptions.method, headers: error.requestOptions.headers);
                  final cloneReq = await _dio.request<dynamic>(
                    error.requestOptions.path,
                    options: opts,
                    data: error.requestOptions.data,
                    queryParameters: error.requestOptions.queryParameters,
                  );
                  // Восстановим старый колбэк.
                  _onRefresh = onRefresh;

                  return handler.resolve(cloneReq);
                }
              }
              if (onLogout != null) {
                // При неудаче вызовим коллбек разлогинивания.
                onLogout();
              }

              return handler.reject(error);
            } catch (exc, stack) {
              logger.e(exc, stack);
              if (onLogout != null) {
                // При неудаче вызовим коллбек разлогинивания.
                onLogout();
              }

              return handler.reject(error);
            }
          } else {
            return handler.reject(error);
          }
        },
      ),
    );
  }

  @override
  void delAuthHeader() {
    _dio.options.headers.remove('Authorization');
  }

  @override
  void setAuthHeader(String token, {Future<String?> Function()? onRefresh, void Function()? onLogout}) {
    _onRefresh = onRefresh;
    _onLogout = onLogout;
    _dio.options.headers['Authorization'] = 'Bearer $token';
  }

  @override
  Future<T?> get<T>(
    String uri, {
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onReceiveProgress,
  }) async {
    try {
      final response = await _dio.get<T>(
        uri,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
        onReceiveProgress: onReceiveProgress,
      );

      return response.data;
    } on FormatException catch (_) {
      throw const FormatException("Unable to proccess the data");
    } catch (exc) {
      rethrow;
    }
  }

  @override
  Future<T?> post<T>(
    String uri, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
  }) async {
    try {
      final response = await _dio.post<T>(
        uri,
        data: data,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
        onSendProgress: onSendProgress,
        onReceiveProgress: onReceiveProgress,
      );

      return response.data;
    } on FormatException catch (_) {
      throw const FormatException("Unable to process the data");
    } catch (exc) {
      rethrow;
    }
  }

  @override
  Future<T?> put<T>(
    String uri, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
  }) async {
    try {
      final response = await _dio.put<T>(
        uri,
        data: data,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
        onSendProgress: onSendProgress,
        onReceiveProgress: onReceiveProgress,
      );

      return response.data;
    } on FormatException catch (_) {
      throw const FormatException("Unable to process the data");
    } catch (exc) {
      rethrow;
    }
  }

  @override
  Future<T?> delete<T>(
    String uri, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
  }) async {
    try {
      final response = await _dio.delete<T>(
        uri,
        data: data,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
      );

      return response.data;
    } on FormatException catch (_) {
      throw const FormatException("Unable to process the data");
    } catch (e) {
      rethrow;
    }
  }
}

// ignore_for_file: avoid-dynamic, avoid-collection-mutating-methods

import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:logging/logging.dart';
import 'package:portfolio/domain/datasources/api_source.dart';
import 'package:portfolio/utils/types.dart';

/// [Dio] реализация поставщика данных API.
class ApiSourceDio extends ApiSource {
  static final log = Logger('ApiSourceDio');
  // Определен в конструкторе.
  // ignore: avoid-late-keyword
  late Dio _dio;
  final String baseUrl;
  AsyncVoidCallback<String?>? _onRefresh;
  VoidCallback? _onLogout;

  // Конструктор.
  // Param: baseUrl - базовая ссылка на API.
  // Param: dio - экземпляр [Dio].
  // Param: interceptors - интерсепторы для [Dio].
  ApiSourceDio({required this.baseUrl, Dio? dio}) {
    _dio = dio ?? Dio();
    _dio
      ..options.baseUrl = baseUrl
      ..options.connectTimeout = const Duration(seconds: 60)
      ..options.receiveTimeout = const Duration(seconds: 60)
      ..httpClientAdapter
      ..options.headers = {
        Headers.contentTypeHeader: 'application/json; charset=UTF-8',
      };

    _addRefreshInterseptor();
  }

  Future<void> _handleError(DioException error, ErrorInterceptorHandler handler) async {
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
      } catch (exception, stack) {
        log.severe('InterceptorsWrapper error', exception, stack);
        if (onLogout != null) {
          // При неудаче вызовим коллбек разлогинивания.
          onLogout();
        }

        return handler.reject(error);
      }
    } else {
      return handler.reject(error);
    }
  }

  /// Добавляет интерсептор для обновления RefreshToken.
  void _addRefreshInterseptor() {
    _dio.interceptors.clear();
    _dio.interceptors.add(
      InterceptorsWrapper(
        onError: (error, handler) => unawaited(_handleError(error, handler)),
      ),
    );
  }

  @override
  void delAuthHeader() {
    _dio.options.headers.remove('Authorization');
  }

  @override
  void setAuthHeader(String token, {AsyncVoidCallback<String?>? onRefresh, VoidCallback? onLogout}) {
    _onRefresh = onRefresh;
    _onLogout = onLogout;
    _dio.options.headers['Authorization'] = 'Bearer $token';
  }

  @override
  Future<T?> get<T>(String uri, {Map<String, dynamic>? queryParameters, Map<String, dynamic>? headers}) async {
    try {
      final response = await _dio.get<T>(
        uri,
        queryParameters: queryParameters,
        options: headers == null ? null : Options(headers: headers),
      );

      return response.data;
    } on FormatException catch (exception, stack) {
      log.severe('get', exception, stack);
      // Тут так надо.
      // ignore: avoid-throw-in-catch-block
      throw const FormatException("Unable to proccess the data");
    } catch (exception) {
      rethrow;
    }
  }

  @override
  Future<T?> post<T>(
    String uri, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? headers,
  }) async {
    try {
      final response = await _dio.post<T>(
        uri,
        data: data,
        queryParameters: queryParameters,
        options: headers == null ? null : Options(headers: headers),
      );

      return response.data;
    } on FormatException catch (exception, stack) {
      log.severe('post', exception, stack);
      // Тут так надо.
      // ignore: avoid-throw-in-catch-block
      throw const FormatException("Unable to proccess the data");
    } catch (exception) {
      rethrow;
    }
  }

  @override
  Future<T?> put<T>(
    String uri, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? headers,
  }) async {
    try {
      final response = await _dio.put<T>(
        uri,
        data: data,
        queryParameters: queryParameters,
        options: headers == null ? null : Options(headers: headers),
      );

      return response.data;
    } on FormatException catch (exception, stack) {
      log.severe('put', exception, stack);
      // Тут так надо.
      // ignore: avoid-throw-in-catch-block
      throw const FormatException("Unable to proccess the data");
    } catch (exception) {
      rethrow;
    }
  }

  @override
  Future<T?> delete<T>(
    String uri, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? headers,
  }) async {
    try {
      final response = await _dio.delete<T>(
        uri,
        data: data,
        queryParameters: queryParameters,
        options: headers == null ? null : Options(headers: headers),
      );

      return response.data;
    } on FormatException catch (exception, stack) {
      log.severe('delete', exception, stack);
      // Тут так надо.
      // ignore: avoid-throw-in-catch-block
      throw const FormatException("Unable to proccess the data");
    } catch (exception) {
      rethrow;
    }
  }
}

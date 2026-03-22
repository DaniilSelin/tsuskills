import 'dart:convert';
import 'dart:io';

import 'package:fpdart/fpdart.dart';
import 'package:injectable/injectable.dart';
import 'package:http/http.dart' as http;
import 'package:tsu_skills/shared/lib/api/client/api_config.dart';
import 'package:tsu_skills/shared/lib/api/token/token_storage.dart';
import 'package:tsu_skills/shared/lib/core/errors/app_error.dart';

@singleton
class ApiClient {
  final TokenStorage _tokenStorage;
  final http.Client _httpClient;

  ApiClient(this._tokenStorage) : _httpClient = http.Client();

  String _url(String path) => '${ApiConfig.baseUrl}$path';

  Map<String, String> _headers({bool auth = true}) {
    final h = <String, String>{
      HttpHeaders.contentTypeHeader: 'application/json',
      'Accept': 'application/json',
    };
    if (auth && _tokenStorage.accessToken != null) {
      h['Authorization'] = 'Bearer ${_tokenStorage.accessToken}';
    }
    return h;
  }

  // ──── PUBLIC API ────────────────────────

  Future<Either<AppError, Map<String, dynamic>>> get(
    String path, {
    bool auth = true,
    Map<String, String>? queryParams,
  }) async {
    try {
      var uri = Uri.parse(_url(path));
      if (queryParams != null && queryParams.isNotEmpty) {
        uri = uri.replace(queryParameters: queryParams);
      }
      final response = await _httpClient
          .get(uri, headers: _headers(auth: auth))
          .timeout(ApiConfig.receiveTimeout);
      return _handleResponse(response);
    } catch (e) {
      return Left(_mapException(e));
    }
  }

  Future<Either<AppError, Map<String, dynamic>>> post(
    String path, {
    Map<String, dynamic>? body,
    bool auth = true,
  }) async {
    try {
      final response = await _httpClient
          .post(
            Uri.parse(_url(path)),
            headers: _headers(auth: auth),
            body: body != null ? jsonEncode(body) : null,
          )
          .timeout(ApiConfig.receiveTimeout);
      return _handleResponse(response);
    } catch (e) {
      return Left(_mapException(e));
    }
  }

  Future<Either<AppError, Map<String, dynamic>>> put(
    String path, {
    Map<String, dynamic>? body,
    bool auth = true,
  }) async {
    try {
      final response = await _httpClient
          .put(
            Uri.parse(_url(path)),
            headers: _headers(auth: auth),
            body: body != null ? jsonEncode(body) : null,
          )
          .timeout(ApiConfig.receiveTimeout);
      return _handleResponse(response);
    } catch (e) {
      return Left(_mapException(e));
    }
  }

  Future<Either<AppError, Map<String, dynamic>>> delete(
    String path, {
    bool auth = true,
  }) async {
    try {
      final response = await _httpClient
          .delete(Uri.parse(_url(path)), headers: _headers(auth: auth))
          .timeout(ApiConfig.receiveTimeout);
      return _handleResponse(response);
    } catch (e) {
      return Left(_mapException(e));
    }
  }

  /// GET, возвращает список (для эндпоинтов возвращающих JSON-массив)
  Future<Either<AppError, List<dynamic>>> getList(
    String path, {
    bool auth = true,
    Map<String, String>? queryParams,
  }) async {
    try {
      var uri = Uri.parse(_url(path));
      if (queryParams != null && queryParams.isNotEmpty) {
        uri = uri.replace(queryParameters: queryParams);
      }
      final response = await _httpClient
          .get(uri, headers: _headers(auth: auth))
          .timeout(ApiConfig.receiveTimeout);
      return _handleListResponse(response);
    } catch (e) {
      return Left(_mapException(e));
    }
  }

  // ──── INTERNAL ──────────────────────────

  Either<AppError, Map<String, dynamic>> _handleResponse(http.Response resp) {
    final body = resp.body.isEmpty
        ? <String, dynamic>{}
        : jsonDecode(resp.body) as Map<String, dynamic>;

    if (resp.statusCode >= 200 && resp.statusCode < 300) {
      return Right(body);
    }

    return Left(_mapStatusCode(resp.statusCode, body));
  }

  Either<AppError, List<dynamic>> _handleListResponse(http.Response resp) {
    if (resp.statusCode >= 200 && resp.statusCode < 300) {
      final decoded = jsonDecode(resp.body);
      if (decoded is List) {
        return Right(decoded);
      }
      // Если ответ — объект с полем содержащим список
      if (decoded is Map<String, dynamic>) {
        // пробуем найти первый List внутри
        for (final v in decoded.values) {
          if (v is List) return Right(v);
        }
      }
      return Right([decoded]);
    }

    final body = resp.body.isEmpty
        ? <String, dynamic>{}
        : jsonDecode(resp.body) as Map<String, dynamic>;
    return Left(_mapStatusCode(resp.statusCode, body));
  }

  AppError _mapStatusCode(int code, Map<String, dynamic> body) {
    final msg = body['message'] as String? ?? '';
    switch (code) {
      case 400:
        return AppError.validationError(message: msg.isEmpty ? 'Bad request' : msg);
      case 401:
        return const AppError.permissionDenied();
      case 403:
        return const AppError.permissionDenied();
      case 404:
        return const AppError.notFound();
      case 409:
        return const AppError.userAlreadyExistsError();
      default:
        return const AppError.serverError();
    }
  }

  AppError _mapException(Object e) {
    if (e is SocketException) return const AppError.networkConnectionError();
    if (e is HttpException) return const AppError.serverError();
    return const AppError.unknownError();
  }
}

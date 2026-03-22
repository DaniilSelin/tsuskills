import 'package:injectable/injectable.dart';

/// Хранилище JWT-токенов. В production заменить на flutter_secure_storage.
@singleton
class TokenStorage {
  String? _accessToken;
  String? _refreshToken;
  String? _userId;

  String? get accessToken => _accessToken;
  String? get refreshToken => _refreshToken;
  String? get userId => _userId;

  bool get isAuthenticated => _accessToken != null;

  void saveTokens({
    required String accessToken,
    required String refreshToken,
    String? userId,
  }) {
    _accessToken = accessToken;
    _refreshToken = refreshToken;
    if (userId != null) _userId = userId;
  }

  void saveUserId(String id) {
    _userId = id;
  }

  void clear() {
    _accessToken = null;
    _refreshToken = null;
    _userId = null;
  }
}

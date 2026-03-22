/// Конфигурация API — единая точка входа через gateway
class ApiConfig {
  // Для локальной разработки:
  // Android эмулятор → 10.0.2.2, iOS → localhost, Web → localhost
  static const String baseUrl = 'http://localhost:8000';

  // Таймауты
  static const Duration connectTimeout = Duration(seconds: 10);
  static const Duration receiveTimeout = Duration(seconds: 15);
}

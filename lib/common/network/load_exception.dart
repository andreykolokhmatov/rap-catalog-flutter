/// Ошибка загрузки, которую data-слой отдаёт наверх вместо `DioException`.
sealed class LoadException implements Exception {
  const LoadException();
}

/// Сервер недоступен: нет сети, неверный адрес, таймаут, CORS.
final class ConnectionLoadException extends LoadException {
  const ConnectionLoadException();

  @override
  String toString() => 'ConnectionLoadException';
}

/// Сервер ответил ошибкой. 503 у MusicBrainz — превышен лимит запросов.
final class ServerLoadException extends LoadException {
  const ServerLoadException(this.statusCode);

  final int? statusCode;

  @override
  String toString() => 'ServerLoadException($statusCode)';
}

/// Запрошенной записи на сервере нет.
final class NotFoundLoadException extends LoadException {
  const NotFoundLoadException();

  @override
  String toString() => 'NotFoundLoadException';
}

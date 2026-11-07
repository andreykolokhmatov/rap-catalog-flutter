import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

abstract final class DioClient {
  /// Единственное место с адресом MusicBrainz.
  static const baseUrl = 'https://musicbrainz.org/ws/2/';

  // MusicBrainz просит не чаще запроса в секунду, иначе отвечает 503.
  static const _musicBrainzInterval = Duration(milliseconds: 1100);
  static const _retryDelay = Duration(seconds: 2);

  static Dio create() {
    final dio = Dio(
      BaseOptions(
        baseUrl: baseUrl,
        connectTimeout: const Duration(seconds: 10),
        receiveTimeout: const Duration(seconds: 15),
        // В браузере User-Agent задать нельзя, его подставит сам браузер.
        headers: kIsWeb
            ? null
            : {
                'User-Agent':
                    'rap-catalog/1.0 '
                    '(https://github.com/andreykolokhmatov/rap-catalog-flutter)',
              },
      ),
    );
    final host = Uri.parse(baseUrl).host;
    dio.interceptors.addAll([
      _ThrottleInterceptor(host: host, interval: _musicBrainzInterval),
      _RetryOn503Interceptor(dio, host: host, delay: _retryDelay),
    ]);
    if (kDebugMode) {
      dio.interceptors.add(
        LogInterceptor(requestHeader: false, responseHeader: false),
      );
    }
    return dio;
  }
}

/// Выпускает запросы к [host] по одному не чаще раза в [interval].
/// Запросы к другим серверам (Википедия) идут без очереди.
class _ThrottleInterceptor extends Interceptor {
  _ThrottleInterceptor({required this.host, required this.interval});

  final String host;
  final Duration interval;

  Future<void> _queue = Future.value();
  DateTime _lastSent = DateTime.fromMillisecondsSinceEpoch(0);

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    if (options.uri.host != host) {
      handler.next(options);
      return;
    }
    _queue = _queue.then((_) async {
      final wait = _lastSent.add(interval).difference(DateTime.now());
      if (wait > Duration.zero) await Future<void>.delayed(wait);
      _lastSent = DateTime.now();
      handler.next(options);
    });
  }
}

/// 503 у MusicBrainz — «слишком часто». Повторяет запрос один раз после паузы;
/// второй 503 уходит наверх и превращается в `ServerLoadException`.
class _RetryOn503Interceptor extends Interceptor {
  _RetryOn503Interceptor(this._dio, {required this.host, required this.delay});

  static const _retriedKey = 'retried';

  final Dio _dio;
  final String host;
  final Duration delay;

  @override
  Future<void> onError(
    DioException err,
    ErrorInterceptorHandler handler,
  ) async {
    final options = err.requestOptions;
    if (err.response?.statusCode != 503 ||
        options.uri.host != host ||
        options.extra[_retriedKey] == true) {
      handler.next(err);
      return;
    }
    await Future<void>.delayed(delay);
    options.extra[_retriedKey] = true;
    try {
      handler.resolve(await _dio.fetch<dynamic>(options));
    } on DioException catch (e) {
      handler.next(e);
    }
  }
}

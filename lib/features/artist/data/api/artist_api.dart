import 'package:dio/dio.dart';

import '../dto/artist_dto.dart';

/// MusicBrainz. Базовый адрес задан в `DioClient`.
class ArtistApi {
  const ArtistApi(this._dio);

  final Dio _dio;

  /// `GET artist?query=` — поиск на языке запросов Lucene.
  Future<ArtistSearchDto> searchArtists({
    required String query,
    required int limit,
    required int offset,
  }) async {
    final response = await _dio.get<Map<String, dynamic>>(
      'artist',
      queryParameters: {
        'query': query,
        'limit': limit,
        'offset': offset,
        'fmt': 'json',
      },
    );
    return ArtistSearchDto.fromJson(response.data!);
  }

  /// `GET artist/{id}` — карточка со всем, что нужно детали, одним запросом.
  Future<ArtistDto> getArtist(String id) async {
    final response = await _dio.get<Map<String, dynamic>>(
      'artist/$id',
      queryParameters: {
        'inc': 'aliases+tags+artist-rels+url-rels+release-groups',
        // Фильтр для release-groups: только альбомы.
        'type': 'album',
        'fmt': 'json',
      },
    );
    return ArtistDto.fromJson(response.data!);
  }
}

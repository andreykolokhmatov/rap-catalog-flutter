import 'package:dio/dio.dart';

import '../dto/wiki_dto.dart';

/// Справка и фото: Викиданные дают названия статей и фото с Викисклада, Википедия — первый абзац.
/// Это другие серверы, поэтому адреса полные, а не относительно `DioClient.baseUrl`.
class WikiApi {
  const WikiApi(this._dio);

  static const _wikidataUrl = 'https://www.wikidata.org/w/api.php';
  static const _sparqlUrl = 'https://query.wikidata.org/sparql';

  // Фото не должны задерживать список: не успели — список покажется с буквами.
  static const _sparqlTimeout = Duration(seconds: 5);

  final Dio _dio;

  /// `GET wikidata.org/w/api.php?action=wbgetentities` — статьи о сущности.
  Future<WikidataEntitiesDto> getSitelinks(
    String wikidataId, {
    required List<String> wikis,
  }) async {
    final response = await _dio.get<Map<String, dynamic>>(
      _wikidataUrl,
      queryParameters: {
        'action': 'wbgetentities',
        'ids': wikidataId,
        'props': 'sitelinks',
        'sitefilter': wikis.join('|'),
        'format': 'json',
        // Без этого Викиданные не отдают заголовок CORS.
        'origin': '*',
      },
    );
    return WikidataEntitiesDto.fromJson(response.data!);
  }

  /// `GET query.wikidata.org/sparql` — фото (P18) исполнителей по их MBID (P434).
  Future<WikidataImagesDto> getImages(List<String> mbids) async {
    final values = mbids.map((id) => '"$id"').join(' ');
    final response = await _dio.get<Map<String, dynamic>>(
      _sparqlUrl,
      queryParameters: {
        'query':
            'SELECT ?mbid ?image WHERE { VALUES ?mbid { $values } '
            '?item wdt:P434 ?mbid; wdt:P18 ?image. }',
        'format': 'json',
      },
      options: Options(receiveTimeout: _sparqlTimeout),
    );
    return WikidataImagesDto.fromJson(response.data!);
  }

  /// `GET {lang}.wikipedia.org/api/rest_v1/page/summary/{title}`.
  Future<WikiSummaryDto> getSummary({
    required String lang,
    required String title,
  }) async {
    final path = Uri.encodeComponent(title.replaceAll(' ', '_'));
    final response = await _dio.get<Map<String, dynamic>>(
      'https://$lang.wikipedia.org/api/rest_v1/page/summary/$path',
    );
    return WikiSummaryDto.fromJson(response.data!);
  }
}

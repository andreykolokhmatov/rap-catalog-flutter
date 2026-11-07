import 'package:dio/dio.dart';

import '../../../../common/network/load_exception.dart';
import '../api/artist_api.dart';
import '../api/wiki_api.dart';
import '../dto/artist_dto.dart';
import '../dto/wiki_dto.dart';
import 'i_artist_data_source.dart';

class NetworkArtistDataSource implements IArtistDataSource {
  const NetworkArtistDataSource(this._artistApi, this._wikiApi);

  // Каталог — исполнители и группы с тегами «hip hop» и «rap».
  static const _catalogQuery =
      'tag:"hip hop" AND tag:rap AND (type:person OR type:group)';

  static final _luceneSpecial = RegExp(r'[+\-&|!(){}\[\]^"~*?:\\/]');

  final ArtistApi _artistApi;
  final WikiApi _wikiApi;

  @override
  Future<ArtistSearchDto> searchArtists({
    required String name,
    required int limit,
    required int offset,
  }) => _guard(
    () => _artistApi.searchArtists(
      query: _query(name),
      limit: limit,
      offset: offset,
    ),
  );

  @override
  Future<ArtistDto> getArtist(String id) => _guard(
    () => _artistApi.getArtist(id),
    // На id не в формате MBID MusicBrainz отвечает 400.
    notFoundCodes: const {400, 404},
  );

  @override
  Future<WikidataEntitiesDto> getSitelinks(
    String wikidataId, {
    required List<String> wikis,
  }) => _guard(() => _wikiApi.getSitelinks(wikidataId, wikis: wikis));

  @override
  Future<WikiSummaryDto> getSummary({
    required String lang,
    required String title,
  }) => _guard(() => _wikiApi.getSummary(lang: lang, title: title));

  @override
  Future<WikidataImagesDto> getImages(List<String> mbids) async {
    if (mbids.isEmpty) {
      return const WikidataImagesDto(results: SparqlResultsDto());
    }
    return _guard(() => _wikiApi.getImages(mbids));
  }

  /// `lil way` → `… AND artist:(lil* AND way*)`: каждое слово — начало слова в имени.
  static String _query(String name) {
    final words = name
        .trim()
        .split(RegExp(r'\s+'))
        .where((w) => w.isNotEmpty)
        .map(
          (w) => '${w.replaceAllMapped(_luceneSpecial, (m) => '\\${m[0]}')}*',
        );
    if (words.isEmpty) return _catalogQuery;
    return '$_catalogQuery AND artist:(${words.join(' AND ')})';
  }

  static Future<T> _guard<T>(
    Future<T> Function() request, {
    Set<int> notFoundCodes = const {404},
  }) async {
    try {
      return await request();
    } on DioException catch (e) {
      throw _toLoadException(e, notFoundCodes);
    }
  }

  static LoadException _toLoadException(
    DioException e,
    Set<int> notFoundCodes,
  ) {
    final status = e.response?.statusCode;
    return switch (e.type) {
      DioExceptionType.badResponse when notFoundCodes.contains(status) =>
        const NotFoundLoadException(),
      DioExceptionType.badResponse => ServerLoadException(status),
      DioExceptionType.connectionTimeout ||
      DioExceptionType.sendTimeout ||
      DioExceptionType.receiveTimeout ||
      DioExceptionType.transformTimeout ||
      DioExceptionType.connectionError ||
      DioExceptionType.badCertificate ||
      DioExceptionType.cancel ||
      DioExceptionType.unknown => const ConnectionLoadException(),
    };
  }
}

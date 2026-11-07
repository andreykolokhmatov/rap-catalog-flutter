import '../dto/artist_dto.dart';
import '../dto/wiki_dto.dart';

/// Любой сбой — `LoadException` из `common/network`.
abstract interface class IArtistDataSource {
  /// Хип-хоп исполнители, у которых имя начинается с [name]; пустое имя — все.
  Future<ArtistSearchDto> searchArtists({
    required String name,
    required int limit,
    required int offset,
  });

  /// Нет такого id — `NotFoundLoadException`.
  Future<ArtistDto> getArtist(String id);

  Future<WikidataEntitiesDto> getSitelinks(
    String wikidataId, {
    required List<String> wikis,
  });

  Future<WikiSummaryDto> getSummary({
    required String lang,
    required String title,
  });

  /// Пустой список MBID — пустой ответ без запроса.
  Future<WikidataImagesDto> getImages(List<String> mbids);
}

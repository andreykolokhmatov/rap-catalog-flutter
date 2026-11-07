import '../../../common/network/load_exception.dart';
import '../domain/artist_model.dart';
import '../domain/artist_page.dart';
import '../domain/i_artist_repository.dart';
import 'data_sources/i_artist_data_source.dart';
import 'mappers/artist_mapper.dart';
import 'mappers/wiki_mapper.dart';

class ArtistRepository implements IArtistRepository {
  const ArtistRepository(this._dataSource);

  final IArtistDataSource _dataSource;

  @override
  Future<ArtistPage> getArtists({String query = '', int offset = 0}) async {
    final dto = await _dataSource.searchArtists(
      name: query,
      limit: IArtistRepository.pageSize,
      offset: offset,
    );
    final photos = await _photos([for (final a in dto.artists) a.id]);
    return ArtistPage(
      artists: [
        for (final artist in dto.artists) artist.toModel(photos: photos),
      ],
      total: dto.count,
    );
  }

  @override
  Future<ArtistModel?> getArtist(String id) async {
    try {
      final dto = await _dataSource.getArtist(id);
      // Справка и фото с разных серверов: оба запроса уходят сразу, ждём оба.
      final biographies = _biographies(dto.wikidataId);
      final photos = _photos(dto.photoIds);
      final (:en, :ru) = await biographies;
      return dto.toModel(biography: en, biographyRu: ru, photos: await photos);
    } on NotFoundLoadException {
      return null;
    }
  }

  /// MBID → адрес фото с Викисклада. Как и справка, фото — дополнение: без него
  /// рисуется буквенная плитка, поэтому сбой не валит список.
  Future<Map<String, String>> _photos(List<String> ids) async {
    try {
      final dto = await _dataSource.getImages(ids);
      return dto.toPhotoUrls();
    } on LoadException {
      return const {};
    }
  }

  /// Первые абзацы статей английской и русской Википедии, грузятся параллельно.
  Future<({String en, String ru})> _biographies(String? wikidataId) async {
    if (wikidataId == null) return (en: '', ru: '');
    try {
      final entities = await _dataSource.getSitelinks(
        wikidataId,
        wikis: const ['enwiki', 'ruwiki'],
      );
      final sitelinks = entities.entities[wikidataId]?.sitelinks ?? const {};
      Future<String> extract(String lang) async {
        final title = sitelinks['${lang}wiki']?.title;
        if (title == null) return '';
        final summary = await _dataSource.getSummary(lang: lang, title: title);
        return summary.extract ?? '';
      }

      // Future.wait бросает исходную ошибку, а не ParallelWaitError, как у (a, b).wait.
      final [en, ru] = await Future.wait([extract('en'), extract('ru')]);
      return (en: en, ru: ru);
    } on LoadException {
      // Справка — дополнение с другого сервера: без неё деталь всё равно полная,
      // поэтому её сбой не валит экран. Сбой самого MusicBrainz идёт наверх.
      return (en: '', ru: '');
    }
  }
}

import 'artist_model.dart';
import 'artist_page.dart';

/// Ошибки загрузки — `LoadException` из `common/network`.
abstract interface class IArtistRepository {
  static const pageSize = 30;

  /// Пустой [query] — весь каталог. [offset] — сколько записей уже загружено.
  Future<ArtistPage> getArtists({String query = '', int offset = 0});

  /// `null` — такой записи нет.
  Future<ArtistModel?> getArtist(String id);
}

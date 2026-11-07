import 'artist_model.dart';

abstract interface class IArtistRepository {
  /// Пустой [query] — весь каталог.
  Future<List<ArtistModel>> getArtists({String query = ''});

  Future<ArtistModel?> getArtist(String id);

  Future<List<ArtistModel>> getRelated(ArtistModel artist);
}

import '../domain/artist_model.dart';
import '../domain/i_artist_repository.dart';
import 'artist_mocks.dart';

class ArtistRepository implements IArtistRepository {
  ArtistRepository() : _byId = {for (final a in artistMocks) a.id: a};

  final Map<String, ArtistModel> _byId;

  @override
  Future<List<ArtistModel>> getArtists({String query = ''}) async {
    final needle = query.trim().toLowerCase();
    if (needle.isEmpty) return artistMocks;
    return artistMocks
        .where((a) => a.name.toLowerCase().contains(needle))
        .toList();
  }

  @override
  Future<ArtistModel?> getArtist(String id) async => _byId[id];

  @override
  Future<List<ArtistModel>> getRelated(ArtistModel artist) async => [
    for (final id in artist.relatedArtistIds) ?_byId[id],
  ];
}

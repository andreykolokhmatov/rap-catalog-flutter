import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/i_artist_repository.dart';
import 'artist_list_state.dart';

class ArtistListCubit extends Cubit<ArtistListState> {
  ArtistListCubit(this._repository) : super(const ArtistListLoading());

  final IArtistRepository _repository;

  // Последний запрошенный поиск: ответ на устаревший запрос не должен перетереть свежий.
  String _query = '';

  Future<void> load() => search('');

  Future<void> search(String query) async {
    _query = query;
    final artists = await _repository.getArtists(query: query);
    if (isClosed || query != _query) return;
    emit(
      artists.isEmpty
          ? ArtistListNotFound(query: query)
          : ArtistListLoaded(artists: artists, query: query),
    );
  }
}

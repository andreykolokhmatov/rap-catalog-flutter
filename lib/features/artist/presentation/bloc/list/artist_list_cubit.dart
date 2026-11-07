import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../common/network/load_exception.dart';
import '../../../domain/i_artist_repository.dart';
import 'artist_list_state.dart';

class ArtistListCubit extends Cubit<ArtistListState> {
  ArtistListCubit(this._repository) : super(const ArtistListLoading());

  // Запрос уходит, когда пользователь перестал печатать: MusicBrainz пускает раз в секунду.
  static const _searchDelay = Duration(milliseconds: 400);

  final IArtistRepository _repository;

  // Последний запрошенный поиск: ответ на устаревший запрос не должен перетереть свежий.
  String _query = '';
  Timer? _searchTimer;

  Future<void> load() => _loadFirstPage(_query);

  Future<void> retry() => _loadFirstPage(_query);

  void search(String query) {
    _searchTimer?.cancel();
    _query = query;
    emit(ArtistListLoading(query: query));
    _searchTimer = Timer(_searchDelay, () => _loadFirstPage(query));
  }

  Future<void> loadMore() async {
    final current = state;
    if (current is! ArtistListLoaded ||
        !current.hasMore ||
        current.nextPage == NextPageStatus.loading) {
      return;
    }
    emit(current.copyWith(nextPage: NextPageStatus.loading));
    try {
      final page = await _repository.getArtists(
        query: current.query,
        offset: current.nextOffset,
      );
      if (isClosed || current.query != _query) return;
      final seen = {for (final artist in current.artists) artist.id};
      emit(
        current.copyWith(
          artists: [
            ...current.artists,
            ...page.artists.where((artist) => seen.add(artist.id)),
          ],
          // Пустая страница — сервер отдал всё, хоть count и обещал больше.
          total: page.artists.isEmpty ? current.nextOffset : page.total,
          nextOffset: current.nextOffset + page.artists.length,
          nextPage: NextPageStatus.idle,
        ),
      );
    } on LoadException {
      if (isClosed || current.query != _query) return;
      emit(current.copyWith(nextPage: NextPageStatus.error));
    }
  }

  Future<void> _loadFirstPage(String query) async {
    _searchTimer?.cancel();
    emit(ArtistListLoading(query: query));
    try {
      final page = await _repository.getArtists(query: query);
      if (isClosed || query != _query) return;
      emit(
        page.artists.isEmpty
            ? ArtistListNotFound(query: query)
            : ArtistListLoaded(
                artists: page.artists,
                query: query,
                total: page.total,
                nextOffset: page.artists.length,
              ),
      );
    } on LoadException catch (error) {
      if (isClosed || query != _query) return;
      emit(ArtistListError(query: query, error: error));
    }
  }

  @override
  Future<void> close() {
    _searchTimer?.cancel();
    return super.close();
  }
}

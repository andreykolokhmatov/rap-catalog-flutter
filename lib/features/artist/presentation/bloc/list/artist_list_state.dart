import 'package:equatable/equatable.dart';

import '../../../../../common/network/load_exception.dart';
import '../../../domain/artist_model.dart';

sealed class ArtistListState extends Equatable {
  const ArtistListState({required this.query});

  final String query;

  @override
  List<Object?> get props => [query];
}

final class ArtistListLoading extends ArtistListState {
  const ArtistListLoading({super.query = ''});
}

/// Состояние догрузки следующей страницы под уже показанным списком.
enum NextPageStatus { idle, loading, error }

final class ArtistListLoaded extends ArtistListState {
  const ArtistListLoaded({
    required this.artists,
    required super.query,
    required this.total,
    required this.nextOffset,
    this.nextPage = NextPageStatus.idle,
  });

  final List<ArtistModel> artists;

  /// Сколько записей по запросу на сервере.
  final int total;

  /// С какой позиции просить следующую страницу. Не равен `artists.length`:
  /// повторы между страницами отбрасываются.
  final int nextOffset;

  final NextPageStatus nextPage;

  bool get isFiltered => query.trim().isNotEmpty;

  bool get hasMore => nextOffset < total;

  ArtistListLoaded copyWith({
    List<ArtistModel>? artists,
    int? total,
    int? nextOffset,
    NextPageStatus? nextPage,
  }) => ArtistListLoaded(
    artists: artists ?? this.artists,
    query: query,
    total: total ?? this.total,
    nextOffset: nextOffset ?? this.nextOffset,
    nextPage: nextPage ?? this.nextPage,
  );

  @override
  List<Object?> get props => [artists, query, total, nextOffset, nextPage];
}

final class ArtistListNotFound extends ArtistListState {
  const ArtistListNotFound({required super.query});
}

final class ArtistListError extends ArtistListState {
  const ArtistListError({required super.query, required this.error});

  final LoadException error;

  @override
  List<Object?> get props => [query, error];
}

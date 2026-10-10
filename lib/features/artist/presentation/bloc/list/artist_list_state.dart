import 'package:equatable/equatable.dart';

import '../../../domain/artist_model.dart';

sealed class ArtistListState extends Equatable {
  const ArtistListState();

  @override
  List<Object?> get props => [];
}

final class ArtistListLoading extends ArtistListState {
  const ArtistListLoading();
}

final class ArtistListLoaded extends ArtistListState {
  const ArtistListLoaded({required this.artists, required this.query});

  final List<ArtistModel> artists;
  final String query;

  bool get isFiltered => query.trim().isNotEmpty;

  @override
  List<Object?> get props => [artists, query];
}

final class ArtistListNotFound extends ArtistListState {
  const ArtistListNotFound({required this.query});

  final String query;

  @override
  List<Object?> get props => [query];
}

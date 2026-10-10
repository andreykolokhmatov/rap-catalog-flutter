import 'package:equatable/equatable.dart';

import '../../../domain/artist_model.dart';

sealed class ArtistDetailState extends Equatable {
  const ArtistDetailState();

  @override
  List<Object?> get props => [];
}

final class ArtistDetailLoading extends ArtistDetailState {
  const ArtistDetailLoading();
}

final class ArtistDetailLoaded extends ArtistDetailState {
  const ArtistDetailLoaded({required this.artist, required this.related});

  final ArtistModel artist;
  final List<ArtistModel> related;

  @override
  List<Object?> get props => [artist, related];
}

final class ArtistDetailNotFound extends ArtistDetailState {
  const ArtistDetailNotFound();
}

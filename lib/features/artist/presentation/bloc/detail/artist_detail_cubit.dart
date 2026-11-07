import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/i_artist_repository.dart';
import 'artist_detail_state.dart';

class ArtistDetailCubit extends Cubit<ArtistDetailState> {
  ArtistDetailCubit(this._repository) : super(const ArtistDetailLoading());

  final IArtistRepository _repository;

  Future<void> load(String id) async {
    final artist = await _repository.getArtist(id);
    if (isClosed) return;
    if (artist == null) {
      emit(const ArtistDetailNotFound());
      return;
    }
    final related = await _repository.getRelated(artist);
    if (isClosed) return;
    emit(ArtistDetailLoaded(artist: artist, related: related));
  }
}

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../common/network/load_exception.dart';
import '../../../domain/i_artist_repository.dart';
import 'artist_detail_state.dart';

class ArtistDetailCubit extends Cubit<ArtistDetailState> {
  ArtistDetailCubit(this._repository) : super(const ArtistDetailLoading());

  final IArtistRepository _repository;

  Future<void> load(String id) async {
    emit(const ArtistDetailLoading());
    try {
      final artist = await _repository.getArtist(id);
      if (isClosed) return;
      emit(
        artist == null
            ? const ArtistDetailNotFound()
            : ArtistDetailLoaded(artist: artist, related: artist.related),
      );
    } on LoadException catch (error) {
      if (isClosed) return;
      emit(ArtistDetailError(error));
    }
  }
}

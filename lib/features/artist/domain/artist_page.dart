import 'package:equatable/equatable.dart';

import 'artist_model.dart';

/// Страница каталога: [artists] с позиции `offset` и сколько всего записей по запросу.
class ArtistPage extends Equatable {
  const ArtistPage({required this.artists, required this.total});

  final List<ArtistModel> artists;
  final int total;

  @override
  List<Object?> get props => [artists, total];
}

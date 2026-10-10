import 'package:equatable/equatable.dart';

enum ArtistType { person, group, other }

enum Genre {
  hipHop,
  rap,
  popRap,
  eastCoast,
  westCoast,
  southern,
  gangstaRap,
  gFunk,
  conscious,
  political,
  hardcore,
  boomBap,
  jazzRap,
  instrumental,
  experimental,
  alternative,
  underground,
  oldSchool,
  rapRock,
  trap,
  crunk,
  emoRap,
  cloudRap,
  trapMetal,
  rage,
}

class ArtistModel extends Equatable {
  const ArtistModel({
    required this.id,
    required this.name,
    required this.sortName,
    required this.disambiguation,
    required this.type,
    required this.country,
    required this.area,
    required this.beginArea,
    required this.lifeSpanBegin,
    required this.lifeSpanEnd,
    required this.ended,
    required this.genres,
    required this.tags,
    required this.aliases,
    required this.releaseGroups,
    required this.relatedArtistIds,
    required this.biography,
    required this.biographyRu,
  });

  final String id;
  final String name;
  final String sortName;
  final String disambiguation;
  final ArtistType type;
  final String country;
  final String area;
  final String beginArea;
  final String lifeSpanBegin;
  final String lifeSpanEnd;
  final bool ended;
  final List<Genre> genres;
  final List<TagModel> tags;
  final List<AliasModel> aliases;
  final List<ReleaseGroupModel> releaseGroups;
  final List<String> relatedArtistIds;
  final String biography;
  final String biographyRu;

  @override
  List<Object?> get props => [id];
}

class TagModel extends Equatable {
  const TagModel({required this.name, required this.count});

  final String name;
  final int count;

  @override
  List<Object?> get props => [name, count];
}

class AliasModel extends Equatable {
  const AliasModel({required this.name, required this.primary});

  final String name;
  final bool primary;

  @override
  List<Object?> get props => [name, primary];
}

class ReleaseGroupModel extends Equatable {
  const ReleaseGroupModel({
    required this.id,
    required this.title,
    required this.firstReleaseDate,
    required this.primaryType,
  });

  final String id;
  final String title;
  final String firstReleaseDate;
  final String primaryType;

  @override
  List<Object?> get props => [id];
}

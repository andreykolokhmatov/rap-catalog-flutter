import 'package:json_annotation/json_annotation.dart';

part 'artist_dto.g.dart';

// Ключи MusicBrainz — через дефис: `sort-name`, `life-span`, `begin-area`.

@JsonSerializable(fieldRename: FieldRename.kebab, createToJson: false)
class ArtistSearchDto {
  const ArtistSearchDto({
    required this.count,
    required this.offset,
    required this.artists,
  });

  factory ArtistSearchDto.fromJson(Map<String, dynamic> json) =>
      _$ArtistSearchDtoFromJson(json);

  final int count;
  final int offset;
  final List<ArtistDto> artists;
}

@JsonSerializable(fieldRename: FieldRename.kebab, createToJson: false)
class ArtistDto {
  const ArtistDto({
    required this.id,
    required this.name,
    this.sortName,
    this.disambiguation,
    this.type,
    this.country,
    this.area,
    this.beginArea,
    this.lifeSpan,
    this.tags = const [],
    this.aliases = const [],
    this.releaseGroups = const [],
    this.relations = const [],
  });

  factory ArtistDto.fromJson(Map<String, dynamic> json) =>
      _$ArtistDtoFromJson(json);

  final String id;
  final String name;
  final String? sortName;
  final String? disambiguation;
  final String? type;
  final String? country;
  final AreaDto? area;
  final AreaDto? beginArea;
  final LifeSpanDto? lifeSpan;
  final List<TagDto> tags;
  final List<AliasDto> aliases;
  final List<ReleaseGroupDto> releaseGroups;
  final List<RelationDto> relations;
}

@JsonSerializable(createToJson: false)
class AreaDto {
  const AreaDto({required this.name});

  factory AreaDto.fromJson(Map<String, dynamic> json) =>
      _$AreaDtoFromJson(json);

  final String name;
}

@JsonSerializable(createToJson: false)
class LifeSpanDto {
  const LifeSpanDto({this.begin, this.end, this.ended});

  factory LifeSpanDto.fromJson(Map<String, dynamic> json) =>
      _$LifeSpanDtoFromJson(json);

  final String? begin;
  final String? end;
  final bool? ended;
}

@JsonSerializable(createToJson: false)
class TagDto {
  const TagDto({required this.name, required this.count});

  factory TagDto.fromJson(Map<String, dynamic> json) => _$TagDtoFromJson(json);

  final String name;
  final int count;
}

@JsonSerializable(createToJson: false)
class AliasDto {
  const AliasDto({required this.name, this.type, this.primary, this.locale});

  factory AliasDto.fromJson(Map<String, dynamic> json) =>
      _$AliasDtoFromJson(json);

  final String name;
  final String? type;
  final bool? primary;

  /// Язык, для которого псевдоним основной: `en`, `ja`, `en_US`.
  final String? locale;
}

@JsonSerializable(fieldRename: FieldRename.kebab, createToJson: false)
class ReleaseGroupDto {
  const ReleaseGroupDto({
    required this.id,
    required this.title,
    this.firstReleaseDate,
    this.primaryType,
    this.secondaryTypes = const [],
  });

  factory ReleaseGroupDto.fromJson(Map<String, dynamic> json) =>
      _$ReleaseGroupDtoFromJson(json);

  final String id;
  final String title;
  final String? firstReleaseDate;
  final String? primaryType;
  final List<String> secondaryTypes;
}

/// Связь с другим исполнителем (`artist`) или со ссылкой (`url`).
@JsonSerializable(fieldRename: FieldRename.kebab, createToJson: false)
class RelationDto {
  const RelationDto({
    required this.type,
    this.targetType,
    this.artist,
    this.url,
  });

  factory RelationDto.fromJson(Map<String, dynamic> json) =>
      _$RelationDtoFromJson(json);

  final String type;
  final String? targetType;
  final ArtistDto? artist;
  final UrlDto? url;
}

@JsonSerializable(createToJson: false)
class UrlDto {
  const UrlDto({required this.resource});

  factory UrlDto.fromJson(Map<String, dynamic> json) => _$UrlDtoFromJson(json);

  final String resource;
}

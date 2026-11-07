// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'artist_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ArtistSearchDto _$ArtistSearchDtoFromJson(Map<String, dynamic> json) =>
    ArtistSearchDto(
      count: (json['count'] as num).toInt(),
      offset: (json['offset'] as num).toInt(),
      artists: (json['artists'] as List<dynamic>)
          .map((e) => ArtistDto.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

ArtistDto _$ArtistDtoFromJson(Map<String, dynamic> json) => ArtistDto(
  id: json['id'] as String,
  name: json['name'] as String,
  sortName: json['sort-name'] as String?,
  disambiguation: json['disambiguation'] as String?,
  type: json['type'] as String?,
  country: json['country'] as String?,
  area: json['area'] == null
      ? null
      : AreaDto.fromJson(json['area'] as Map<String, dynamic>),
  beginArea: json['begin-area'] == null
      ? null
      : AreaDto.fromJson(json['begin-area'] as Map<String, dynamic>),
  lifeSpan: json['life-span'] == null
      ? null
      : LifeSpanDto.fromJson(json['life-span'] as Map<String, dynamic>),
  tags:
      (json['tags'] as List<dynamic>?)
          ?.map((e) => TagDto.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const [],
  aliases:
      (json['aliases'] as List<dynamic>?)
          ?.map((e) => AliasDto.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const [],
  releaseGroups:
      (json['release-groups'] as List<dynamic>?)
          ?.map((e) => ReleaseGroupDto.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const [],
  relations:
      (json['relations'] as List<dynamic>?)
          ?.map((e) => RelationDto.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const [],
);

AreaDto _$AreaDtoFromJson(Map<String, dynamic> json) =>
    AreaDto(name: json['name'] as String);

LifeSpanDto _$LifeSpanDtoFromJson(Map<String, dynamic> json) => LifeSpanDto(
  begin: json['begin'] as String?,
  end: json['end'] as String?,
  ended: json['ended'] as bool?,
);

TagDto _$TagDtoFromJson(Map<String, dynamic> json) =>
    TagDto(name: json['name'] as String, count: (json['count'] as num).toInt());

AliasDto _$AliasDtoFromJson(Map<String, dynamic> json) => AliasDto(
  name: json['name'] as String,
  type: json['type'] as String?,
  primary: json['primary'] as bool?,
);

ReleaseGroupDto _$ReleaseGroupDtoFromJson(Map<String, dynamic> json) =>
    ReleaseGroupDto(
      id: json['id'] as String,
      title: json['title'] as String,
      firstReleaseDate: json['first-release-date'] as String?,
      primaryType: json['primary-type'] as String?,
      secondaryTypes:
          (json['secondary-types'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
    );

RelationDto _$RelationDtoFromJson(Map<String, dynamic> json) => RelationDto(
  type: json['type'] as String,
  targetType: json['target-type'] as String?,
  artist: json['artist'] == null
      ? null
      : ArtistDto.fromJson(json['artist'] as Map<String, dynamic>),
  url: json['url'] == null
      ? null
      : UrlDto.fromJson(json['url'] as Map<String, dynamic>),
);

UrlDto _$UrlDtoFromJson(Map<String, dynamic> json) =>
    UrlDto(resource: json['resource'] as String);

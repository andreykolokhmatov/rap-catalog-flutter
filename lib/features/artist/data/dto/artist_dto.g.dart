// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'artist_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ArtistSearchDto _$ArtistSearchDtoFromJson(Map<String, dynamic> json) =>
    $checkedCreate('ArtistSearchDto', json, ($checkedConvert) {
      final val = ArtistSearchDto(
        count: $checkedConvert('count', (v) => (v as num).toInt()),
        offset: $checkedConvert('offset', (v) => (v as num).toInt()),
        artists: $checkedConvert(
          'artists',
          (v) => (v as List<dynamic>)
              .map((e) => ArtistDto.fromJson(e as Map<String, dynamic>))
              .toList(),
        ),
      );
      return val;
    });

ArtistDto _$ArtistDtoFromJson(Map<String, dynamic> json) => $checkedCreate(
  'ArtistDto',
  json,
  ($checkedConvert) {
    final val = ArtistDto(
      id: $checkedConvert('id', (v) => v as String),
      name: $checkedConvert('name', (v) => v as String),
      sortName: $checkedConvert('sort-name', (v) => v as String?),
      disambiguation: $checkedConvert('disambiguation', (v) => v as String?),
      type: $checkedConvert('type', (v) => v as String?),
      country: $checkedConvert('country', (v) => v as String?),
      area: $checkedConvert(
        'area',
        (v) => v == null ? null : AreaDto.fromJson(v as Map<String, dynamic>),
      ),
      beginArea: $checkedConvert(
        'begin-area',
        (v) => v == null ? null : AreaDto.fromJson(v as Map<String, dynamic>),
      ),
      lifeSpan: $checkedConvert(
        'life-span',
        (v) =>
            v == null ? null : LifeSpanDto.fromJson(v as Map<String, dynamic>),
      ),
      tags: $checkedConvert(
        'tags',
        (v) =>
            (v as List<dynamic>?)
                ?.map((e) => TagDto.fromJson(e as Map<String, dynamic>))
                .toList() ??
            const [],
      ),
      aliases: $checkedConvert(
        'aliases',
        (v) =>
            (v as List<dynamic>?)
                ?.map((e) => AliasDto.fromJson(e as Map<String, dynamic>))
                .toList() ??
            const [],
      ),
      releaseGroups: $checkedConvert(
        'release-groups',
        (v) =>
            (v as List<dynamic>?)
                ?.map(
                  (e) => ReleaseGroupDto.fromJson(e as Map<String, dynamic>),
                )
                .toList() ??
            const [],
      ),
      relations: $checkedConvert(
        'relations',
        (v) =>
            (v as List<dynamic>?)
                ?.map((e) => RelationDto.fromJson(e as Map<String, dynamic>))
                .toList() ??
            const [],
      ),
    );
    return val;
  },
  fieldKeyMap: const {
    'sortName': 'sort-name',
    'beginArea': 'begin-area',
    'lifeSpan': 'life-span',
    'releaseGroups': 'release-groups',
  },
);

AreaDto _$AreaDtoFromJson(Map<String, dynamic> json) =>
    $checkedCreate('AreaDto', json, ($checkedConvert) {
      final val = AreaDto(name: $checkedConvert('name', (v) => v as String));
      return val;
    });

LifeSpanDto _$LifeSpanDtoFromJson(Map<String, dynamic> json) =>
    $checkedCreate('LifeSpanDto', json, ($checkedConvert) {
      final val = LifeSpanDto(
        begin: $checkedConvert('begin', (v) => v as String?),
        end: $checkedConvert('end', (v) => v as String?),
        ended: $checkedConvert('ended', (v) => v as bool?),
      );
      return val;
    });

TagDto _$TagDtoFromJson(Map<String, dynamic> json) =>
    $checkedCreate('TagDto', json, ($checkedConvert) {
      final val = TagDto(
        name: $checkedConvert('name', (v) => v as String),
        count: $checkedConvert('count', (v) => (v as num).toInt()),
      );
      return val;
    });

AliasDto _$AliasDtoFromJson(Map<String, dynamic> json) =>
    $checkedCreate('AliasDto', json, ($checkedConvert) {
      final val = AliasDto(
        name: $checkedConvert('name', (v) => v as String),
        type: $checkedConvert('type', (v) => v as String?),
        primary: $checkedConvert('primary', (v) => v as bool?),
        locale: $checkedConvert('locale', (v) => v as String?),
      );
      return val;
    });

ReleaseGroupDto _$ReleaseGroupDtoFromJson(Map<String, dynamic> json) =>
    $checkedCreate(
      'ReleaseGroupDto',
      json,
      ($checkedConvert) {
        final val = ReleaseGroupDto(
          id: $checkedConvert('id', (v) => v as String),
          title: $checkedConvert('title', (v) => v as String),
          firstReleaseDate: $checkedConvert(
            'first-release-date',
            (v) => v as String?,
          ),
          primaryType: $checkedConvert('primary-type', (v) => v as String?),
          secondaryTypes: $checkedConvert(
            'secondary-types',
            (v) =>
                (v as List<dynamic>?)?.map((e) => e as String).toList() ??
                const [],
          ),
        );
        return val;
      },
      fieldKeyMap: const {
        'firstReleaseDate': 'first-release-date',
        'primaryType': 'primary-type',
        'secondaryTypes': 'secondary-types',
      },
    );

RelationDto _$RelationDtoFromJson(Map<String, dynamic> json) =>
    $checkedCreate('RelationDto', json, ($checkedConvert) {
      final val = RelationDto(
        type: $checkedConvert('type', (v) => v as String),
        targetType: $checkedConvert('target-type', (v) => v as String?),
        artist: $checkedConvert(
          'artist',
          (v) =>
              v == null ? null : ArtistDto.fromJson(v as Map<String, dynamic>),
        ),
        url: $checkedConvert(
          'url',
          (v) => v == null ? null : UrlDto.fromJson(v as Map<String, dynamic>),
        ),
      );
      return val;
    }, fieldKeyMap: const {'targetType': 'target-type'});

UrlDto _$UrlDtoFromJson(Map<String, dynamic> json) =>
    $checkedCreate('UrlDto', json, ($checkedConvert) {
      final val = UrlDto(
        resource: $checkedConvert('resource', (v) => v as String),
      );
      return val;
    });

// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'wiki_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WikidataEntitiesDto _$WikidataEntitiesDtoFromJson(Map<String, dynamic> json) =>
    WikidataEntitiesDto(
      entities:
          (json['entities'] as Map<String, dynamic>?)?.map(
            (k, e) => MapEntry(
              k,
              WikidataEntityDto.fromJson(e as Map<String, dynamic>),
            ),
          ) ??
          const {},
    );

WikidataEntityDto _$WikidataEntityDtoFromJson(Map<String, dynamic> json) =>
    WikidataEntityDto(
      sitelinks:
          (json['sitelinks'] as Map<String, dynamic>?)?.map(
            (k, e) =>
                MapEntry(k, SitelinkDto.fromJson(e as Map<String, dynamic>)),
          ) ??
          const {},
    );

SitelinkDto _$SitelinkDtoFromJson(Map<String, dynamic> json) =>
    SitelinkDto(title: json['title'] as String);

WikiSummaryDto _$WikiSummaryDtoFromJson(Map<String, dynamic> json) =>
    WikiSummaryDto(extract: json['extract'] as String?);

WikidataImagesDto _$WikidataImagesDtoFromJson(Map<String, dynamic> json) =>
    WikidataImagesDto(
      results: SparqlResultsDto.fromJson(
        json['results'] as Map<String, dynamic>,
      ),
    );

SparqlResultsDto _$SparqlResultsDtoFromJson(Map<String, dynamic> json) =>
    SparqlResultsDto(
      bindings:
          (json['bindings'] as List<dynamic>?)
              ?.map((e) => ImageBindingDto.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
    );

ImageBindingDto _$ImageBindingDtoFromJson(Map<String, dynamic> json) =>
    ImageBindingDto(
      mbid: SparqlValueDto.fromJson(json['mbid'] as Map<String, dynamic>),
      image: SparqlValueDto.fromJson(json['image'] as Map<String, dynamic>),
    );

SparqlValueDto _$SparqlValueDtoFromJson(Map<String, dynamic> json) =>
    SparqlValueDto(value: json['value'] as String);

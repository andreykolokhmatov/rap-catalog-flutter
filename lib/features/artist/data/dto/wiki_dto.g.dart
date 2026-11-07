// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'wiki_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WikidataEntitiesDto _$WikidataEntitiesDtoFromJson(Map<String, dynamic> json) =>
    $checkedCreate('WikidataEntitiesDto', json, ($checkedConvert) {
      final val = WikidataEntitiesDto(
        entities: $checkedConvert(
          'entities',
          (v) =>
              (v as Map<String, dynamic>?)?.map(
                (k, e) => MapEntry(
                  k,
                  WikidataEntityDto.fromJson(e as Map<String, dynamic>),
                ),
              ) ??
              const {},
        ),
      );
      return val;
    });

WikidataEntityDto _$WikidataEntityDtoFromJson(Map<String, dynamic> json) =>
    $checkedCreate('WikidataEntityDto', json, ($checkedConvert) {
      final val = WikidataEntityDto(
        sitelinks: $checkedConvert(
          'sitelinks',
          (v) =>
              (v as Map<String, dynamic>?)?.map(
                (k, e) => MapEntry(
                  k,
                  SitelinkDto.fromJson(e as Map<String, dynamic>),
                ),
              ) ??
              const {},
        ),
      );
      return val;
    });

SitelinkDto _$SitelinkDtoFromJson(Map<String, dynamic> json) =>
    $checkedCreate('SitelinkDto', json, ($checkedConvert) {
      final val = SitelinkDto(
        title: $checkedConvert('title', (v) => v as String),
      );
      return val;
    });

WikiSummaryDto _$WikiSummaryDtoFromJson(Map<String, dynamic> json) =>
    $checkedCreate('WikiSummaryDto', json, ($checkedConvert) {
      final val = WikiSummaryDto(
        extract: $checkedConvert('extract', (v) => v as String?),
      );
      return val;
    });

WikidataImagesDto _$WikidataImagesDtoFromJson(Map<String, dynamic> json) =>
    $checkedCreate('WikidataImagesDto', json, ($checkedConvert) {
      final val = WikidataImagesDto(
        results: $checkedConvert(
          'results',
          (v) => SparqlResultsDto.fromJson(v as Map<String, dynamic>),
        ),
      );
      return val;
    });

SparqlResultsDto _$SparqlResultsDtoFromJson(Map<String, dynamic> json) =>
    $checkedCreate('SparqlResultsDto', json, ($checkedConvert) {
      final val = SparqlResultsDto(
        bindings: $checkedConvert(
          'bindings',
          (v) =>
              (v as List<dynamic>?)
                  ?.map(
                    (e) => ImageBindingDto.fromJson(e as Map<String, dynamic>),
                  )
                  .toList() ??
              const [],
        ),
      );
      return val;
    });

ImageBindingDto _$ImageBindingDtoFromJson(Map<String, dynamic> json) =>
    $checkedCreate('ImageBindingDto', json, ($checkedConvert) {
      final val = ImageBindingDto(
        mbid: $checkedConvert(
          'mbid',
          (v) => SparqlValueDto.fromJson(v as Map<String, dynamic>),
        ),
        image: $checkedConvert(
          'image',
          (v) => SparqlValueDto.fromJson(v as Map<String, dynamic>),
        ),
      );
      return val;
    });

SparqlValueDto _$SparqlValueDtoFromJson(Map<String, dynamic> json) =>
    $checkedCreate('SparqlValueDto', json, ($checkedConvert) {
      final val = SparqlValueDto(
        value: $checkedConvert('value', (v) => v as String),
      );
      return val;
    });

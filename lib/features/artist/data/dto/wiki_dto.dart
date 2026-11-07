import 'package:json_annotation/json_annotation.dart';

part 'wiki_dto.g.dart';

/// Ответ Викиданных `wbgetentities`: id сущности → её статьи в Википедиях.
@JsonSerializable(createToJson: false)
class WikidataEntitiesDto {
  const WikidataEntitiesDto({this.entities = const {}});

  factory WikidataEntitiesDto.fromJson(Map<String, dynamic> json) =>
      _$WikidataEntitiesDtoFromJson(json);

  final Map<String, WikidataEntityDto> entities;
}

@JsonSerializable(createToJson: false)
class WikidataEntityDto {
  const WikidataEntityDto({this.sitelinks = const {}});

  factory WikidataEntityDto.fromJson(Map<String, dynamic> json) =>
      _$WikidataEntityDtoFromJson(json);

  /// Ключ — вики (`enwiki`, `ruwiki`).
  final Map<String, SitelinkDto> sitelinks;
}

@JsonSerializable(createToJson: false)
class SitelinkDto {
  const SitelinkDto({required this.title});

  factory SitelinkDto.fromJson(Map<String, dynamic> json) =>
      _$SitelinkDtoFromJson(json);

  final String title;
}

/// Краткое содержание статьи Википедии: первый абзац в `extract`.
@JsonSerializable(createToJson: false)
class WikiSummaryDto {
  const WikiSummaryDto({this.extract});

  factory WikiSummaryDto.fromJson(Map<String, dynamic> json) =>
      _$WikiSummaryDtoFromJson(json);

  final String? extract;
}

/// Ответ SPARQL Викиданных: строки «MBID — изображение (P18)».
@JsonSerializable(createToJson: false)
class WikidataImagesDto {
  const WikidataImagesDto({required this.results});

  factory WikidataImagesDto.fromJson(Map<String, dynamic> json) =>
      _$WikidataImagesDtoFromJson(json);

  final SparqlResultsDto results;
}

@JsonSerializable(createToJson: false)
class SparqlResultsDto {
  const SparqlResultsDto({this.bindings = const []});

  factory SparqlResultsDto.fromJson(Map<String, dynamic> json) =>
      _$SparqlResultsDtoFromJson(json);

  final List<ImageBindingDto> bindings;
}

@JsonSerializable(createToJson: false)
class ImageBindingDto {
  const ImageBindingDto({required this.mbid, required this.image});

  factory ImageBindingDto.fromJson(Map<String, dynamic> json) =>
      _$ImageBindingDtoFromJson(json);

  final SparqlValueDto mbid;

  /// `http://commons.wikimedia.org/wiki/Special:FilePath/<имя файла>`.
  final SparqlValueDto image;
}

@JsonSerializable(createToJson: false)
class SparqlValueDto {
  const SparqlValueDto({required this.value});

  factory SparqlValueDto.fromJson(Map<String, dynamic> json) =>
      _$SparqlValueDtoFromJson(json);

  final String value;
}

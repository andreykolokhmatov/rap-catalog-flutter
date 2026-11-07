import '../../domain/artist_model.dart';
import '../dto/artist_dto.dart';

extension ArtistDtoMapper on ArtistDto {
  static const _maxTags = 5;
  static const _maxAliases = 6;
  static const _maxRelated = 8;

  // Какие связи MusicBrainz показываем в «Связанных».
  static const _relatedTypes = {
    'member of band',
    'subgroup',
    'collaboration',
    'is person',
  };

  // Теги MusicBrainz → жанры каталога. Остальные теги в жанры не попадают.
  static const _genreByTag = {
    'hip hop': Genre.hipHop,
    'hip-hop': Genre.hipHop,
    'rap': Genre.rap,
    'pop rap': Genre.popRap,
    'east coast hip hop': Genre.eastCoast,
    'west coast hip hop': Genre.westCoast,
    'southern hip hop': Genre.southern,
    'gangsta rap': Genre.gangstaRap,
    'g-funk': Genre.gFunk,
    'conscious hip hop': Genre.conscious,
    'political hip hop': Genre.political,
    'hardcore hip hop': Genre.hardcore,
    'boom bap': Genre.boomBap,
    'jazz rap': Genre.jazzRap,
    'instrumental hip hop': Genre.instrumental,
    'experimental hip hop': Genre.experimental,
    'alternative hip hop': Genre.alternative,
    'underground hip hop': Genre.underground,
    'old school hip hop': Genre.oldSchool,
    'rap rock': Genre.rapRock,
    'trap': Genre.trap,
    'crunk': Genre.crunk,
    'emo rap': Genre.emoRap,
    'cloud rap': Genre.cloudRap,
    'trap metal': Genre.trapMetal,
    'rage': Genre.rage,
  };

  /// Q-идентификатор Викиданных из ссылок исполнителя, если есть.
  String? get wikidataId {
    for (final relation in relations) {
      final url = relation.url?.resource;
      if (relation.type == 'wikidata' && url != null) {
        return Uri.parse(url).pathSegments.last;
      }
    }
    return null;
  }

  /// Все MBID карточки: сам исполнитель и связанные — для одного запроса фото.
  List<String> get photoIds => [
    id,
    for (final relation in relations) ?relation.artist?.id,
  ];

  /// [photos] — MBID → адрес фото, для исполнителя и связанных артистов.
  ArtistModel toModel({
    String biography = '',
    String biographyRu = '',
    Map<String, String> photos = const {},
  }) {
    final tagsByCount = tags.where((t) => t.count > 0).toList()
      ..sort((a, b) => b.count.compareTo(a.count));
    return ArtistModel(
      id: id,
      name: name,
      sortName: sortName ?? name,
      disambiguation: disambiguation ?? '',
      type: switch (type) {
        'Person' => ArtistType.person,
        'Group' => ArtistType.group,
        _ => ArtistType.other,
      },
      country: country ?? '',
      area: area?.name ?? '',
      beginArea: beginArea?.name ?? '',
      lifeSpanBegin: lifeSpan?.begin ?? '',
      lifeSpanEnd: lifeSpan?.end ?? '',
      ended: lifeSpan?.ended ?? false,
      genres: {
        for (final tag in tagsByCount) ?_genreByTag[tag.name.toLowerCase()],
      }.toList(),
      tags: [
        for (final tag in tagsByCount.take(_maxTags))
          TagModel(name: tag.name, count: tag.count),
      ],
      aliases: _aliases(),
      releaseGroups: [
        for (final release in releaseGroups)
          // Только номерные альбомы: без сборников, микстейпов и концертников.
          if (release.primaryType == 'Album' && release.secondaryTypes.isEmpty)
            ReleaseGroupModel(
              id: release.id,
              title: release.title,
              firstReleaseDate: release.firstReleaseDate ?? '',
              primaryType: release.primaryType ?? '',
            ),
      ],
      related: _related(photos),
      biography: biography,
      biographyRu: biographyRu,
      photoUrl: photos[id] ?? '',
    );
  }

  List<AliasModel> _aliases() {
    final seen = {name.toLowerCase()};
    return [
      for (final alias in aliases)
        // «Search hint» — опечатки и транслитерации для поиска, не псевдонимы.
        if (alias.type != 'Search hint' && seen.add(alias.name.toLowerCase()))
          AliasModel(name: alias.name, primary: alias.primary ?? false),
    ].take(_maxAliases).toList();
  }

  List<ArtistModel> _related(Map<String, String> photos) {
    final seen = {id};
    return [
      for (final relation in relations)
        if (relation.artist case final other?
            when _relatedTypes.contains(relation.type) && seen.add(other.id))
          other.toModel(photos: photos),
    ].take(_maxRelated).toList();
  }
}

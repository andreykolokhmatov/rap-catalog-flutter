import 'package:flutter/widgets.dart';

import '../../../../l10n/app_localizations.dart';
import '../../domain/artist_model.dart';

extension ArtistModelX on ArtistModel {
  /// Подзаголовок: уточнение из MusicBrainz, а если его нет — тип записи.
  String subtitle(AppLocalizations l10n) {
    if (disambiguation.isNotEmpty) return disambiguation;
    return switch (type) {
      ArtistType.person => l10n.artistTypePerson,
      ArtistType.group => l10n.artistTypeGroup,
      ArtistType.other => l10n.artistTypeOther,
    };
  }

  /// Строки «Страна / Откуда / Годы» для шапки детали.
  List<String> facts(AppLocalizations l10n) => [
    if (country.isNotEmpty) l10n.labelCountry(country),
    if (beginArea.isNotEmpty && area.isNotEmpty)
      l10n.labelOrigin(beginArea, area),
    if (lifeSpanBegin.isNotEmpty)
      switch ((type == ArtistType.group, ended)) {
        (true, true) => l10n.labelGroupRange(lifeSpanBegin, lifeSpanEnd),
        (true, false) => l10n.labelGroupSince(lifeSpanBegin),
        (false, true) => l10n.labelLifespan(lifeSpanBegin, lifeSpanEnd),
        (false, false) => l10n.labelBorn(lifeSpanBegin),
      },
  ];

  /// Русская справка — отдельная статья русской Википедии, а не перевод.
  String biographyFor(Locale locale) =>
      locale.languageCode == 'ru' && biographyRu.isNotEmpty
      ? biographyRu
      : biography;

  String get initial => name.isEmpty ? '' : name.characters.first.toUpperCase();

  List<ReleaseGroupModel> get releasesByDate =>
      [...releaseGroups]
        ..sort((a, b) => a.firstReleaseDate.compareTo(b.firstReleaseDate));

  int get maxTagCount =>
      tags.fold(0, (max, tag) => tag.count > max ? tag.count : max);
}

extension ReleaseGroupModelX on ReleaseGroupModel {
  String get year => firstReleaseDate.length >= 4
      ? firstReleaseDate.substring(0, 4)
      : firstReleaseDate;
}

extension AliasModelX on AliasModel {
  /// Отметка «основной» — только у основного псевдонима для языка интерфейса.
  String label(AppLocalizations l10n) =>
      isPrimaryFor(l10n.localeName) ? l10n.aliasPrimary(name) : name;

  /// `en_US` и `en` — один язык: сравниваются коды до подчёркивания.
  bool isPrimaryFor(String languageCode) =>
      primary && _language(locale) == _language(languageCode);

  static String _language(String locale) =>
      locale.split(RegExp('[_-]')).first.toLowerCase();
}

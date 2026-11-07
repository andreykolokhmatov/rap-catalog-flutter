import '../../../../l10n/app_localizations.dart';
import '../../domain/artist_model.dart';

extension GenreX on Genre {
  String label(AppLocalizations l10n) => switch (this) {
    Genre.hipHop => l10n.genreHipHop,
    Genre.rap => l10n.genreRap,
    Genre.popRap => l10n.genrePopRap,
    Genre.eastCoast => l10n.genreEastCoast,
    Genre.westCoast => l10n.genreWestCoast,
    Genre.southern => l10n.genreSouthern,
    Genre.gangstaRap => l10n.genreGangstaRap,
    Genre.gFunk => l10n.genreGFunk,
    Genre.conscious => l10n.genreConscious,
    Genre.political => l10n.genrePolitical,
    Genre.hardcore => l10n.genreHardcore,
    Genre.boomBap => l10n.genreBoomBap,
    Genre.jazzRap => l10n.genreJazzRap,
    Genre.instrumental => l10n.genreInstrumental,
    Genre.experimental => l10n.genreExperimental,
    Genre.alternative => l10n.genreAlternative,
    Genre.underground => l10n.genreUnderground,
    Genre.oldSchool => l10n.genreOldSchool,
    Genre.rapRock => l10n.genreRapRock,
    Genre.trap => l10n.genreTrap,
    Genre.crunk => l10n.genreCrunk,
    Genre.emoRap => l10n.genreEmoRap,
    Genre.cloudRap => l10n.genreCloudRap,
    Genre.trapMetal => l10n.genreTrapMetal,
    Genre.rage => l10n.genreRage,
  };
}

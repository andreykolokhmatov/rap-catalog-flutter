import 'package:flutter/material.dart';

import '../../../../../common/theme/app_colors.dart';
import '../../../../../l10n/app_localizations.dart';
import '../../../domain/artist_model.dart';
import '../../utils/artist_model_x.dart';
import 'artist_artwork.dart';
import 'genre_chip.dart';

class ArtistHeader extends StatelessWidget {
  const ArtistHeader({super.key, required this.artist});

  final ArtistModel artist;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final accent = artist.genres.isEmpty
        ? theme.colorScheme.primary
        : AppColors.genre(artist.genres.first);

    return DecoratedBox(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [accent.withValues(alpha: 0.35), accent.withValues(alpha: 0)],
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
        child: Column(
          spacing: 14,
          children: [
            SizedBox.square(
              dimension: 120,
              child: ArtistArtwork(artist: artist, borderRadius: 30),
            ),
            Text(
              artist.name,
              textAlign: TextAlign.center,
              style: theme.textTheme.headlineLarge,
            ),
            Text(
              artist.subtitle(AppLocalizations.of(context)),
              textAlign: TextAlign.center,
              style: theme.textTheme.bodyMedium?.copyWith(
                color: theme.colorScheme.onSurfaceVariant,
              ),
            ),
            Wrap(
              alignment: WrapAlignment.center,
              spacing: 8,
              runSpacing: 8,
              children: [for (final g in artist.genres) GenreChip(genre: g)],
            ),
          ],
        ),
      ),
    );
  }
}

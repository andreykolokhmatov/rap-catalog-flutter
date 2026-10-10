import 'package:flutter/material.dart';

import '../../../../../common/theme/app_colors.dart';
import '../../../../../l10n/app_localizations.dart';
import '../../../domain/artist_model.dart';
import '../../utils/genre_x.dart';

class GenreChip extends StatelessWidget {
  const GenreChip({super.key, required this.genre});

  final Genre genre;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: AppColors.genre(genre),
        borderRadius: BorderRadius.circular(6),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        child: Text(
          genre.label(AppLocalizations.of(context)),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: Theme.of(context).textTheme.labelSmall
              ?.copyWith(color: AppColors.onGenre, fontWeight: FontWeight.w700),
        ),
      ),
    );
  }
}

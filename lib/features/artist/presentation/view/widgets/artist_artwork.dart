import 'package:flutter/material.dart';

import '../../../../../common/theme/app_colors.dart';
import '../../../../../common/theme/image_sources.dart';
import '../../../domain/artist_model.dart';
import '../../utils/artist_model_x.dart';

/// Снимок исполнителя, а без снимка — первая буква на градиенте цветов жанров.
class ArtistArtwork extends StatelessWidget {
  const ArtistArtwork({
    super.key,
    required this.artist,
    required this.borderRadius,
  });

  final ArtistModel artist;
  final double borderRadius;

  @override
  Widget build(BuildContext context) {
    final photo = ImageSources.artistPhoto(artist.id);
    return ClipRRect(
      borderRadius: BorderRadius.circular(borderRadius),
      child: photo != null
          ? Image.asset(
              photo,
              fit: BoxFit.cover,
              semanticLabel: artist.name,
              errorBuilder: (context, error, stackTrace) => _Fallback(artist),
            )
          : _Fallback(artist),
    );
  }
}

class _Fallback extends StatelessWidget {
  const _Fallback(this.artist);

  final ArtistModel artist;

  @override
  Widget build(BuildContext context) {
    final primary = Theme.of(context).colorScheme.primary;
    final colors = switch (artist.genres) {
      [] => [primary, primary],
      [final only] => [AppColors.genre(only), AppColors.genre(only)],
      [final first, final second, ...] => [
        AppColors.genre(first),
        AppColors.genre(second),
      ],
    };
    return DecoratedBox(
      decoration: BoxDecoration(gradient: LinearGradient(colors: colors)),
      child: LayoutBuilder(
        builder: (context, constraints) => Center(
          child: Text(
            artist.initial,
            style: TextStyle(
              color: AppColors.onGenre,
              fontWeight: FontWeight.w700,
              fontSize: constraints.biggest.shortestSide * 0.4,
            ),
          ),
        ),
      ),
    );
  }
}

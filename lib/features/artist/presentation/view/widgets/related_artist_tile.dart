import 'package:flutter/material.dart';

import '../../../domain/artist_model.dart';
import 'artist_artwork.dart';

class RelatedArtistTile extends StatelessWidget {
  const RelatedArtistTile({
    super.key,
    required this.artist,
    required this.onTap,
  });

  final ArtistModel artist;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Card(
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Row(
            spacing: 14,
            children: [
              SizedBox.square(
                dimension: 40,
                child: ArtistArtwork(artist: artist, borderRadius: 10),
              ),
              Expanded(
                child: Text(artist.name, style: theme.textTheme.titleSmall),
              ),
              Icon(
                Icons.chevron_right,
                color: theme.colorScheme.onSurfaceVariant,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

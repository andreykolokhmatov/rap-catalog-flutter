import 'package:flutter/material.dart';

import '../../../domain/artist_model.dart';
import 'artist_artwork.dart';
import 'genre_chip.dart';

class ArtistCard extends StatelessWidget {
  const ArtistCard({super.key, required this.artist, required this.onTap});

  final ArtistModel artist;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            spacing: 8,
            children: [
              Expanded(
                child: SizedBox(
                  width: double.infinity,
                  child: ArtistArtwork(artist: artist, borderRadius: 12),
                ),
              ),
              Text(
                artist.name,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.titleSmall,
              ),
              if (artist.genres.isNotEmpty)
                GenreChip(genre: artist.genres.first),
            ],
          ),
        ),
      ),
    );
  }
}

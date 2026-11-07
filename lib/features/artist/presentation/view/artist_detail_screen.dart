import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../common/navigation/app_routes.dart';
import '../../../../common/widgets/catalog_app_bar.dart';
import '../../../../common/widgets/content_frame.dart';
import '../../../../common/widgets/message_view.dart';
import '../../../../common/widgets/section.dart';
import '../../../../l10n/app_localizations.dart';
import '../../domain/artist_model.dart';
import '../../domain/i_artist_repository.dart';
import '../bloc/detail/artist_detail_cubit.dart';
import '../bloc/detail/artist_detail_state.dart';
import '../utils/artist_model_x.dart';
import 'widgets/alias_pill.dart';
import 'widgets/artist_header.dart';
import 'widgets/related_artist_tile.dart';
import 'widgets/release_row.dart';
import 'widgets/tag_bar.dart';

class ArtistDetailScreen extends StatelessWidget {
  const ArtistDetailScreen({super.key, required this.artistId});

  final String artistId;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          ArtistDetailCubit(context.read<IArtistRepository>())..load(artistId),
      child: Scaffold(
        appBar: const CatalogAppBar(),
        body: BlocBuilder<ArtistDetailCubit, ArtistDetailState>(
          builder: (context, state) => switch (state) {
            ArtistDetailLoading() => const Center(
              child: CircularProgressIndicator(),
            ),
            ArtistDetailNotFound() => Center(
              child: MessageView(
                text: AppLocalizations.of(context).detailNotFound,
              ),
            ),
            ArtistDetailLoaded(:final artist, :final related) =>
              _ArtistDetailBody(artist: artist, related: related),
          },
        ),
      ),
    );
  }
}

class _ArtistDetailBody extends StatelessWidget {
  const _ArtistDetailBody({required this.artist, required this.related});

  final ArtistModel artist;
  final List<ArtistModel> related;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final theme = Theme.of(context);
    final secondary = theme.textTheme.bodyMedium?.copyWith(
      color: theme.colorScheme.onSurfaceVariant,
    );
    final biography = artist.biographyFor(Localizations.localeOf(context));

    return SingleChildScrollView(
      padding: const EdgeInsets.only(bottom: 28),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          ArtistHeader(artist: artist),
          ContentFrame(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(20, 4, 20, 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                spacing: 28,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    spacing: 6,
                    children: [
                      for (final fact in artist.facts(l10n))
                        Text(fact, style: secondary),
                    ],
                  ),
                  if (biography.isNotEmpty)
                    Section(
                      title: l10n.sectionAbout,
                      child: ConstrainedBox(
                        constraints: const BoxConstraints(maxWidth: 680),
                        child: Text(biography, style: secondary),
                      ),
                    ),
                  if (artist.aliases.isNotEmpty)
                    Section(
                      title: l10n.sectionAliases,
                      child: Wrap(
                        spacing: 8,
                        runSpacing: 8,
                        children: [
                          for (final alias in artist.aliases)
                            AliasPill(text: alias.label(l10n)),
                        ],
                      ),
                    ),
                  if (artist.releaseGroups.isNotEmpty)
                    Section(
                      title: l10n.sectionReleases,
                      child: Column(
                        children: [
                          for (final (i, release)
                              in artist.releasesByDate.indexed) ...[
                            if (i > 0) const Divider(),
                            ReleaseRow(release: release),
                          ],
                        ],
                      ),
                    ),
                  if (artist.tags.isNotEmpty)
                    Section(
                      title: l10n.sectionTags,
                      child: Column(
                        children: [
                          for (final tag in artist.tags)
                            TagBar(tag: tag, maxCount: artist.maxTagCount),
                        ],
                      ),
                    ),
                  if (related.isNotEmpty)
                    Section(
                      title: l10n.sectionRelated,
                      child: Column(
                        spacing: 8,
                        children: [
                          for (final other in related)
                            RelatedArtistTile(
                              artist: other,
                              // push, а не go: «назад» должен вернуть на эту деталь.
                              onTap: () =>
                                  context.push(AppRoutes.artist(other.id)),
                            ),
                        ],
                      ),
                    ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

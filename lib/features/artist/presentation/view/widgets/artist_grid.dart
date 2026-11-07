import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../../common/navigation/app_routes.dart';
import '../../../../../common/widgets/error_view.dart';
import '../../../../../l10n/app_localizations.dart';
import '../../bloc/list/artist_list_cubit.dart';
import '../../bloc/list/artist_list_state.dart';
import 'artist_card.dart';

class ArtistGrid extends StatelessWidget {
  const ArtistGrid({super.key, required this.state});

  static const _padding = 20.0;
  static const _spacing = 12.0;

  final ArtistListLoaded state;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final theme = Theme.of(context);
    final count = state.artists.length;
    final cubit = context.read<ArtistListCubit>();

    return LayoutBuilder(
      builder: (context, constraints) {
        final width = constraints.maxWidth;
        final columns = width >= 720 ? 3 : (width >= 300 ? 2 : 1);

        return NotificationListener<ScrollNotification>(
          // Следующая страница — когда до конца осталось меньше экрана.
          onNotification: (notification) {
            final metrics = notification.metrics;
            if (metrics.axis == Axis.vertical &&
                metrics.extentAfter < metrics.viewportDimension) {
              cubit.loadMore();
            }
            return false;
          },
          child: CustomScrollView(
            // Ключ сохраняет позицию прокрутки, пока экран деталей лежит поверх.
            key: const PageStorageKey('artist-grid'),
            slivers: [
              SliverPadding(
                padding: const EdgeInsets.fromLTRB(
                  _padding,
                  _spacing,
                  _padding,
                  4,
                ),
                sliver: SliverToBoxAdapter(
                  child: Text(
                    (state.isFiltered
                            ? l10n.listFound(state.total)
                            : l10n.listCount(state.total))
                        .toUpperCase(),
                    style: theme.textTheme.labelSmall?.copyWith(
                      color: theme.colorScheme.onSurfaceVariant,
                    ),
                  ),
                ),
              ),
              SliverPadding(
                padding: const EdgeInsets.all(_padding).copyWith(top: _spacing),
                sliver: SliverGrid.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: columns,
                    mainAxisSpacing: _spacing,
                    crossAxisSpacing: _spacing,
                    childAspectRatio: 0.8,
                  ),
                  itemCount: count,
                  itemBuilder: (context, index) {
                    final artist = state.artists[index];
                    return ArtistCard(
                      key: ValueKey(artist.id),
                      artist: artist,
                      onTap: () => context.push(AppRoutes.artist(artist.id)),
                    );
                  },
                ),
              ),
              SliverToBoxAdapter(
                child: switch (state.nextPage) {
                  NextPageStatus.idle => const SizedBox.shrink(),
                  NextPageStatus.loading => const Padding(
                    padding: EdgeInsets.only(bottom: _padding),
                    child: Center(child: CircularProgressIndicator()),
                  ),
                  NextPageStatus.error => Center(
                    child: ErrorView(
                      text: l10n.listNextPageFailed,
                      onRetry: cubit.retryNextPage,
                    ),
                  ),
                },
              ),
            ],
          ),
        );
      },
    );
  }
}

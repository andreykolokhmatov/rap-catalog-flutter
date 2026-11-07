import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../common/widgets/catalog_app_bar.dart';
import '../../../../common/widgets/content_frame.dart';
import '../../../../common/widgets/message_view.dart';
import '../../../../l10n/app_localizations.dart';
import '../bloc/list/artist_list_cubit.dart';
import '../bloc/list/artist_list_state.dart';
import 'widgets/artist_grid.dart';
import 'widgets/artist_search_field.dart';

class ArtistListScreen extends StatefulWidget {
  const ArtistListScreen({super.key});

  @override
  State<ArtistListScreen> createState() => _ArtistListScreenState();
}

class _ArtistListScreenState extends State<ArtistListScreen> {
  late final TextEditingController _searchController;

  @override
  void initState() {
    super.initState();
    // Cubit списка живёт в корне, поэтому поле восстанавливаем из его состояния.
    final query = switch (context.read<ArtistListCubit>().state) {
      ArtistListLoaded(:final query) ||
      ArtistListNotFound(:final query) => query,
      ArtistListLoading() => '',
    };
    _searchController = TextEditingController(text: query);
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _clearSearch() {
    _searchController.clear();
    context.read<ArtistListCubit>().search('');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CatalogAppBar(),
      body: ContentFrame(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 12, 20, 0),
              child: ArtistSearchField(
                controller: _searchController,
                onChanged: context.read<ArtistListCubit>().search,
                onCleared: _clearSearch,
              ),
            ),
            Expanded(
              child: BlocBuilder<ArtistListCubit, ArtistListState>(
                builder: (context, state) => switch (state) {
                  ArtistListLoading() => const Center(
                    child: CircularProgressIndicator(),
                  ),
                  ArtistListNotFound() => MessageView(
                    text: AppLocalizations.of(context).listEmpty,
                  ),
                  ArtistListLoaded() => ArtistGrid(state: state),
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'common/navigation/app_router.dart';
import 'common/network/dio_client.dart';
import 'common/settings/settings_cubit.dart';
import 'common/settings/settings_state.dart';
import 'common/theme/app_theme.dart';
import 'features/artist/data/api/artist_api.dart';
import 'features/artist/data/api/wiki_api.dart';
import 'features/artist/data/artist_repository.dart';
import 'features/artist/data/data_sources/network_artist_data_source.dart';
import 'features/artist/domain/i_artist_repository.dart';
import 'features/artist/presentation/bloc/list/artist_list_cubit.dart';
import 'l10n/app_localizations.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    // Dio один на приложение; дальше по цепочке API → датасорс → репозиторий.
    return RepositoryProvider<IArtistRepository>(
      create: (context) {
        final dio = DioClient.create();
        return ArtistRepository(
          NetworkArtistDataSource(ArtistApi(dio), WikiApi(dio)),
        );
      },
      child: MultiBlocProvider(
        providers: [
          BlocProvider(create: (context) => SettingsCubit()),
          BlocProvider(
            create: (context) =>
                ArtistListCubit(context.read<IArtistRepository>())..load(),
          ),
        ],
        child: BlocBuilder<SettingsCubit, SettingsState>(
          builder: (context, settings) => MaterialApp.router(
            routerConfig: AppRouter.router,
            onGenerateTitle: (context) => AppLocalizations.of(context).appTitle,
            theme: AppTheme.light,
            darkTheme: AppTheme.dark,
            themeMode: settings.themeMode,
            locale: settings.locale,
            localizationsDelegates: AppLocalizations.localizationsDelegates,
            supportedLocales: AppLocalizations.supportedLocales,
            debugShowCheckedModeBanner: false,
          ),
        ),
      ),
    );
  }
}

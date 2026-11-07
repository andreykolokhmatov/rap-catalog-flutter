import 'package:go_router/go_router.dart';

import '../../features/artist/presentation/view/artist_detail_screen.dart';
import '../../features/artist/presentation/view/artist_list_screen.dart';
import 'app_routes.dart';
import 'not_found_screen.dart';

abstract final class AppRouter {
  // Один экземпляр на всё приложение: при смене темы и языка стек экранов не теряется.
  static final router = GoRouter(
    initialLocation: AppRoutes.list,
    errorBuilder: (context, state) => const NotFoundScreen(),
    routes: [
      GoRoute(
        path: AppRoutes.list,
        builder: (context, state) => const ArtistListScreen(),
        routes: [
          GoRoute(
            path: AppRoutes.artistDetail,
            builder: (context, state) => ArtistDetailScreen(
              artistId: state.pathParameters[AppRoutes.artistIdParam]!,
            ),
          ),
        ],
      ),
    ],
  );
}

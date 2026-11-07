import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../l10n/app_localizations.dart';
import '../widgets/catalog_app_bar.dart';
import '../widgets/message_view.dart';
import 'app_routes.dart';

/// Неизвестный адрес, например `/foo`: вместо английской заглушки `go_router` —
/// своё сообщение в теме приложения и переход на список.
class NotFoundScreen extends StatelessWidget {
  const NotFoundScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return Scaffold(
      appBar: const CatalogAppBar(),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            MessageView(text: l10n.routeNotFound),
            FilledButton.tonalIcon(
              onPressed: () => context.go(AppRoutes.list),
              icon: const Icon(Icons.list),
              label: Text(l10n.actionToList),
            ),
          ],
        ),
      ),
    );
  }
}

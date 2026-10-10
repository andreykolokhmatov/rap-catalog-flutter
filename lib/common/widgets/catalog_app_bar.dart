import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../l10n/app_localizations.dart';
import '../settings/settings_cubit.dart';

class CatalogAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CatalogAppBar({super.key});

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final scheme = Theme.of(context).colorScheme;
    final isDark = context.select((SettingsCubit c) => c.state.isDark);
    final settings = context.read<SettingsCubit>();

    return AppBar(
      title: Text(l10n.appTitle),
      actions: [
        IconButton(
          tooltip: l10n.actionSwitchLanguage,
          onPressed: settings.toggleLocale,
          icon: Container(
            padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
            decoration: BoxDecoration(
              border: Border.all(color: scheme.outline),
              borderRadius: BorderRadius.circular(6),
            ),
            child: Text(
              l10n.languageShort,
              style: Theme.of(context).textTheme.labelMedium
                  ?.copyWith(color: scheme.onSurfaceVariant),
            ),
          ),
        ),
        IconButton(
          tooltip: l10n.actionToggleTheme,
          onPressed: settings.toggleTheme,
          icon: Icon(
            isDark ? Icons.light_mode_outlined : Icons.dark_mode_outlined,
          ),
        ),
        const SizedBox(width: 8),
      ],
    );
  }
}

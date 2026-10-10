import 'package:flutter/material.dart';

import '../../../../../l10n/app_localizations.dart';

class ArtistSearchField extends StatelessWidget {
  const ArtistSearchField({
    super.key,
    required this.controller,
    required this.onChanged,
    required this.onCleared,
  });

  final TextEditingController controller;
  final ValueChanged<String> onChanged;
  final VoidCallback onCleared;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return TextField(
      controller: controller,
      onChanged: onChanged,
      textInputAction: TextInputAction.search,
      decoration: InputDecoration(
        hintText: l10n.searchHint,
        prefixIcon: const Icon(Icons.search),
        // Крестик показываем только когда есть что стирать.
        suffixIcon: ListenableBuilder(
          listenable: controller,
          builder: (context, _) => controller.text.isEmpty
              ? const SizedBox.shrink()
              : IconButton(
                  tooltip: l10n.actionClearSearch,
                  onPressed: onCleared,
                  icon: const Icon(Icons.close),
                ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';

import '../../l10n/app_localizations.dart';
import 'message_view.dart';

/// Сообщение об ошибке и кнопка «Повторить».
class ErrorView extends StatelessWidget {
  const ErrorView({super.key, required this.text, required this.onRetry});

  final String text;
  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        MessageView(text: text),
        FilledButton.tonalIcon(
          onPressed: onRetry,
          icon: const Icon(Icons.refresh),
          label: Text(AppLocalizations.of(context).actionRetry),
        ),
      ],
    );
  }
}

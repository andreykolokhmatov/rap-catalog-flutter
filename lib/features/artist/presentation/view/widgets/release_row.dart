import 'package:flutter/material.dart';

import '../../../domain/artist_model.dart';
import '../../utils/artist_model_x.dart';

class ReleaseRow extends StatelessWidget {
  const ReleaseRow({super.key, required this.release});

  final ReleaseGroupModel release;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: 16,
        children: [
          SizedBox(
            width: 40,
            child: Text(
              release.year,
              style: theme.textTheme.labelMedium?.copyWith(
                color: theme.colorScheme.primary,
              ),
            ),
          ),
          Expanded(
            child: Text(release.title, style: theme.textTheme.bodyMedium),
          ),
        ],
      ),
    );
  }
}

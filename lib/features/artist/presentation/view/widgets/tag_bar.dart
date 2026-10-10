import 'package:flutter/material.dart';

import '../../../domain/artist_model.dart';

class TagBar extends StatelessWidget {
  const TagBar({super.key, required this.tag, required this.maxCount});

  final TagModel tag;
  final int maxCount;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        spacing: 12,
        children: [
          SizedBox(
            width: 140,
            child: Text(
              tag.name,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: theme.textTheme.bodySmall,
            ),
          ),
          Expanded(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(3),
              child: LinearProgressIndicator(
                value: maxCount > 0 ? tag.count / maxCount : 0,
                minHeight: 6,
                color: theme.colorScheme.primary,
                backgroundColor: theme.colorScheme.outlineVariant,
              ),
            ),
          ),
          SizedBox(
            width: 28,
            child: Text(
              '${tag.count}',
              textAlign: TextAlign.end,
              style: theme.textTheme.labelMedium?.copyWith(
                color: theme.colorScheme.onSurfaceVariant,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

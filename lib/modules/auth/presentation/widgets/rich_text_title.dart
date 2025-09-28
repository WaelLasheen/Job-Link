import 'package:flutter/material.dart';
import 'package:job_link/core/theme/app_theme.dart';

class RichTextTitle extends StatelessWidget {
  final String titlePart1;
  final String titlePart2;
  final String titlePart3;
  const RichTextTitle({
    super.key,
    required this.titlePart1,
    required this.titlePart2,
    required this.titlePart3,
  });

  @override
  Widget build(BuildContext context) {
    final AppTheme theme = Theme.of(context).extension<AppTheme>()!;
    return RichText(
      textAlign: TextAlign.center,
      text: TextSpan(
        style: theme.richTextTitleStyle,
        children: [
          TextSpan(
            text: titlePart1,
            style: theme.richTextTitleStyle.copyWith(
              color: Colors.blue,
              fontWeight: FontWeight.bold,
            ),
          ),
          TextSpan(text: titlePart2),
          TextSpan(
            text: titlePart3,
            style: theme.richTextTitleStyle.copyWith(
              color: Colors.blue,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}

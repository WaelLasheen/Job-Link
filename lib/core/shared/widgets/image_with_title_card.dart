import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:job_link/core/theme/app_theme.dart';

class ImageWithTitleCard extends StatelessWidget {
  final String imagePath;
  final String title;
  final VoidCallback onTap;
  final bool isSelected;
  final double? height;
  final double? width;

  const ImageWithTitleCard({
    super.key,
    required this.imagePath,
    required this.title,
    required this.onTap,
    required this.isSelected,
    this.height,
    this.width,
  });

  @override
  Widget build(BuildContext context) {
    final AppTheme theme = Theme.of(context).extension<AppTheme>()!;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isSelected ? Colors.blue : Colors.grey,
            width: 2,
          ),
        ),
        child: Column(
          spacing: 16,
          children: [
            SizedBox(
              height: height,
              width: width,
              child: SvgPicture.asset(imagePath, fit: BoxFit.fill),
            ),
            Text(
              title,
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: isSelected ? theme.blue : theme.grey,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

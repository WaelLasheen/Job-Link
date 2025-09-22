import 'package:flutter/material.dart';
import 'package:job_link/modules/task/presentation/widgets/date_chip.dart';

class DateRangeRow extends StatelessWidget {
  final DateTime startDate;
  final DateTime endDate;
  final IconData icon;
  final double fontSize;
  final Color iconColor;

  const DateRangeRow({
    super.key,
    required this.startDate,
    required this.endDate,
    this.icon = Icons.diamond,
    this.fontSize = 20,
    this.iconColor = const Color(0xFFD2D2D2),
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        DateChip(date: startDate, fontSize: fontSize),
        Icon(
          icon,
          size: 30,
          color: iconColor,
        ),
        DateChip(date: endDate, fontSize: fontSize),
      ],
    );
  }
}

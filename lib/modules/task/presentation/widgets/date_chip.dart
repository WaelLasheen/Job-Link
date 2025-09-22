import 'package:flutter/material.dart';

class DateChip extends StatelessWidget {
  final DateTime date;
  final double fontSize;
  final Color textColor;

  const DateChip({
    super.key,
    required this.date,
    this.fontSize = 20,
    this.textColor = Colors.grey,
  });

  String _formatDate(DateTime date) {
    return date.toString().split(' ')[0]; // yyyy-MM-dd
  }

  @override
  Widget build(BuildContext context) {
    return Chip(
      label: Text(
        _formatDate(date),
        style: TextStyle(
          color: textColor,
          fontSize: fontSize,
        ),
      ),
    );
  }
}

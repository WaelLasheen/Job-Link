import 'package:flutter/material.dart';

class ProfileHeader extends StatelessWidget {
  final String name;
  final IconData icon;
  final double radius;
  final double fontSize;

  const ProfileHeader({
    super.key,
    required this.name,
    required this.icon,
    this.radius = 25,
    this.fontSize = 30,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      spacing: 12,
      children: [
        CircleAvatar(
          radius: radius,
          backgroundColor: const Color(0xFFE0E0E0),
          child: Icon(
            icon,
            size: radius * 1.6,
            color: Colors.grey,
          ),
        ),
        Text(
          name,
          style: TextStyle(
            color: Colors.grey.shade700,
            fontSize: fontSize,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}

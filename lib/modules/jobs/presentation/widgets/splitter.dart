import 'package:flutter/material.dart';

class Splitter extends StatelessWidget {
  const Splitter({super.key});

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 14),
      child: Divider(),
    );
  }
}

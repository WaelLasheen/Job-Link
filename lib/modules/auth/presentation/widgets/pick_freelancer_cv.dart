import 'package:flutter/material.dart';
import 'package:job_link/core/consts/assets_path/lottie_url.dart';
import 'package:job_link/modules/auth/controllers/user_provider.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

class PickFreelancerCV extends StatelessWidget {
  final bool isSelected;
  final String title;

  const PickFreelancerCV({
    super.key,
    required this.isSelected,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        await context.read<UserProvider>().pickCV();
      },
      child: Container(
        padding: const EdgeInsets.only(bottom: 16),
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
            SizedBox(child: Lottie.asset(LottieUrl().uploading)),
            Text(
              title,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: isSelected ? Colors.blue : Colors.grey[600],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

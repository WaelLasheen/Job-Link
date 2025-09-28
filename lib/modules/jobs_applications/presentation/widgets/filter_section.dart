import 'package:flutter/material.dart';
import 'package:job_link/modules/jobs_applications/data/enum/application_status_enum.dart';
import 'package:job_link/modules/jobs_applications/presentation/widgets/filter_button.dart';

class FilterSection extends StatelessWidget {
  const FilterSection({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 80,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: JobApplicationStatusEnum.values
            .map((status) => FilterButton(status: status))
            .toList(),
      ),
    );
  }
}
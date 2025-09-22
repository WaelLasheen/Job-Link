import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:job_link/modules/task/controllers/date_cubit/date_cubit.dart';
import 'package:job_link/modules/task/presentation/widgets/date_chip.dart';

class PickDate extends StatelessWidget {
  final String title;
  final bool isStartingDate;
  const PickDate({
    super.key,
    required this.title,
    required this.isStartingDate,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        DateCubit.get(context).pickDate(context, isStartingDate);
      },
      child: BlocBuilder<DateCubit, DateTime>(
        builder: (context, state) {
          DateTime date = isStartingDate
              ? DateCubit.get(context).startingDate
              : DateCubit.get(context).endingDate;

          return DateChip(date: date);
        },
      ),
    );
  }
}

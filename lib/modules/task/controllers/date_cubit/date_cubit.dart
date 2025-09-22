import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DateCubit extends Cubit<DateTime> {
  DateCubit() : super(DateTime.now());
  DateTime startingDate = DateTime.now();
  DateTime endingDate = DateTime.now();

  void pickDate(BuildContext context, bool isStartingDate) {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 1000)),
    ).then((pickedDate) {
      if (pickedDate != null) {
        isStartingDate ? startingDate = pickedDate : endingDate = pickedDate;
        emit(pickedDate);
      }
    });
  }

  static DateCubit get(context) => BlocProvider.of(context);
}

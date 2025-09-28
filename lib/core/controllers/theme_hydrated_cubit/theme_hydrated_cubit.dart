import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:job_link/core/consts/strings/app_consts.dart';

class ThemeHydratedCubit extends HydratedCubit<ThemeMode> {
  ThemeHydratedCubit() : super(ThemeMode.light);

  void toggleTheme() {
    emit(state == ThemeMode.light ? ThemeMode.dark : ThemeMode.light);
  }

  @override
  ThemeMode? fromJson(Map<String, dynamic> json) {
    final isDarkTheme = json[AppConsts().isDark] as bool;
    return isDarkTheme ? ThemeMode.dark : ThemeMode.light;
  }

  @override
  Map<String, dynamic>? toJson(ThemeMode state) => {
    AppConsts().isDark: state == ThemeMode.dark,
  };

  static ThemeHydratedCubit get(BuildContext context) =>
      context.read<ThemeHydratedCubit>();
}

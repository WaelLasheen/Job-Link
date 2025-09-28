import 'dart:io';
import 'package:flutter/material.dart';
import 'package:job_link/core/router/router_strings.dart';
import 'package:job_link/modules/auth/controllers/user_provider.dart';
import 'package:job_link/modules/auth/data/models/freelancer.dart';
import 'package:job_link/core/shared/validation/validation_services.dart';
import 'package:job_link/core/shared/widgets/app_button.dart';
import 'package:job_link/core/shared/widgets/app_text_field.dart';
import 'package:job_link/modules/auth/presentation/widgets/pick_freelancer_cv.dart';
import 'package:job_link/modules/auth/presentation/widgets/rich_text_title.dart';
import 'package:provider/provider.dart';

class FreelancerFormScreen extends StatefulWidget {
  const FreelancerFormScreen({super.key});

  @override
  State<FreelancerFormScreen> createState() => _FreelancerFormScreenState();
}

class _FreelancerFormScreenState extends State<FreelancerFormScreen> {
  final nameController = TextEditingController();
  final jobTitleController = TextEditingController();
  final experienceController = TextEditingController();
  final hourlyRateController = TextEditingController();
  final monthlyRateController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    context.read<UserProvider>()
      ..clearUser()
      ..clearCV();
  }

  @override
  void dispose() {
    super.dispose();
    nameController.dispose();
    jobTitleController.dispose();
    experienceController.dispose();
    hourlyRateController.dispose();
    monthlyRateController.dispose();
    formKey.currentState?.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Form(
              key: formKey,
              child: Column(
                spacing: 16,
                children: [
                  const RichTextTitle(
                    titlePart1: 'Please ',
                    titlePart2: 'fill in the following ',
                    titlePart3: 'information',
                  ),
                  const SizedBox(height: 20),
                  AppTextField(
                    hint: 'Name',
                    prefixIcon: Icons.person,
                    controller: nameController,
                    validator: ValidationServices.validateOnlyCharacter,
                  ),

                  AppTextField(
                    hint: "Job Title",
                    prefixIcon: Icons.work,
                    controller: jobTitleController,
                    validator: ValidationServices.validateOnlyCharacter,
                  ),

                  AppTextField(
                    hint: "Experience",
                    prefixIcon: Icons.star,
                    controller: experienceController,
                    validator: ValidationServices.validateRequiredField,
                    keyboardType: TextInputType.number,
                  ),

                  AppTextField(
                    hint: "Hourly Rate",
                    prefixIcon: Icons.access_time,
                    controller: hourlyRateController,
                    validator: ValidationServices.validatePaymentRate,
                    keyboardType: TextInputType.number,
                  ),

                  AppTextField(
                    hint: "Monthly Rate",
                    prefixIcon: Icons.money,
                    controller: monthlyRateController,
                    validator: ValidationServices.validatePaymentRate,
                    keyboardType: TextInputType.number,
                  ),

                  _pickCV(),
                  const SizedBox(height: 20),
                  _button(context),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _pickCV() {
    return Selector<UserProvider, File?>(
      selector: (_, provider) => provider.freelancerCV,
      builder: (_, freelancerCV, __) {
        bool isSelected = freelancerCV != null;
        return PickFreelancerCV(
          isSelected: isSelected,
          title: isSelected
              ? 'CV uploaded\n${freelancerCV.path.split('/').last}'
              : 'Upload your CV',
        );
      },
    );
  }

  Widget _button(BuildContext context) {
    return AppButton(
      text: 'Next',
      onPressed: () {
        if (formKey.currentState!.validate()) {
          final provider = context.read<UserProvider>();
          if (provider.freelancerCV == null) {
            return;
          }

          provider.setUser(
            Freelancer(
              name: nameController.text,
              jobTitle: jobTitleController.text,
              experience: experienceController.text,
              hourlyRate: int.parse(hourlyRateController.text),
              monthlyRate: int.parse(monthlyRateController.text),
            ),
          );
          Navigator.of(context).pushNamed(RouterStrings.register);
        }
      },
    );
  }
}

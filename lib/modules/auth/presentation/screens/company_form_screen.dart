import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:job_link/core/router/router_strings.dart';
import 'package:job_link/modules/auth/controllers/user_provider.dart';
import 'package:job_link/modules/auth/data/models/job_owner.dart';
import 'package:job_link/core/shared/validation/validation_services.dart';
import 'package:job_link/core/shared/widgets/app_button.dart';
import 'package:job_link/core/shared/widgets/app_text_field.dart';

class CompanyFormScreen extends StatefulWidget {
  const CompanyFormScreen({super.key});

  @override
  State<CompanyFormScreen> createState() => _CompanyFormScreenState();
}

class _CompanyFormScreenState extends State<CompanyFormScreen> {
  final companyNameController = TextEditingController();
  final hourlyRateController = TextEditingController();
  final monthlyRateController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  @override
  void initState() {
    context.read<UserProvider>().clearUser();
    super.initState();
  }

  @override
  void dispose() {
    companyNameController.dispose();
    hourlyRateController.dispose();
    monthlyRateController.dispose();
    formKey.currentState?.dispose();
    super.dispose();
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
                  _title(),
                  const SizedBox(height: 20),
                  AppTextField(
                    hint: 'Company name',
                    prefixIcon: Icons.person,
                    controller: companyNameController,
                    validator: ValidationServices.validateOnlyCharacter,
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

  Widget _title() {
    return RichText(
      textAlign: TextAlign.center,
      text: TextSpan(
        style: const TextStyle(fontSize: 32, color: Colors.black),
        children: const [
          TextSpan(
            text: "Please ",
            style: TextStyle(fontWeight: FontWeight.bold, color: Colors.blue),
          ),
          TextSpan(text: "fill in the following "),
          TextSpan(
            text: "information",
            style: TextStyle(fontWeight: FontWeight.bold, color: Colors.blue),
          ),
        ],
      ),
    );
  }

  Widget _button(BuildContext context) {
    return AppButton(
      text: 'Next',
      onPressed: () {
        if (formKey.currentState!.validate()) {
          context.read<UserProvider>().setUser(
            JobOwner(
              companyName: companyNameController.text,
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

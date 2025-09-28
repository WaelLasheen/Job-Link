import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:job_link/core/consts/assets_path/image_url.dart';
import 'package:job_link/core/shared/widgets/rich_text_title.dart';
import 'package:job_link/modules/auth/data/models/job_owner.dart';
import 'package:job_link/core/shared/validation/validation_services.dart';
import 'package:job_link/core/shared/widgets/app_button.dart';
import 'package:job_link/core/shared/widgets/app_text_field.dart';
import 'package:job_link/modules/jobs/controller/jobs_cubit/jobs_cubit.dart';
import 'package:job_link/modules/jobs/controller/payment_type_cubit/payment_type_cubit.dart';
import 'package:job_link/modules/jobs/data/enum/payment_type_enum.dart';
import 'package:job_link/modules/jobs/data/model/job_model.dart';
import 'package:job_link/modules/jobs/presentation/widgets/payment_type_card.dart';

class AddJobScreen extends StatefulWidget {
  final JobOwner jobOwner;
  const AddJobScreen({super.key, required this.jobOwner});

  @override
  State<AddJobScreen> createState() => _AddJobScreenState();
}

class _AddJobScreenState extends State<AddJobScreen> {
  final jobTitleController = TextEditingController();
  final jobDescriptionController = TextEditingController();
  final jobRequiredSkillsController = TextEditingController();
  final paymentRateController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    super.dispose();
    jobTitleController.dispose();
    jobDescriptionController.dispose();
    jobRequiredSkillsController.dispose();
    paymentRateController.dispose();
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
                    titlePart1: 'Please, ',
                    titlePart2: 'fill in the following ',
                    titlePart3: 'Fields',
                  ),
                  const SizedBox(height: 20),

                  AppTextField(
                    hint: "Job Title",
                    prefixIcon: Icons.work,
                    controller: jobTitleController,
                    validator: ValidationServices.validateOnlyCharacter,
                  ),

                  AppTextField(
                    hint: "Job description",
                    prefixIcon: Icons.description,
                    controller: jobDescriptionController,
                    validator: ValidationServices.validateRequiredField,
                  ),
                  AppTextField(
                    hint: "Required skills",
                    prefixIcon: Icons.workspaces,
                    controller: jobRequiredSkillsController,
                    validator: ValidationServices.validateRequiredField,
                  ),

                  AppTextField(
                    hint: "Payment rate",
                    prefixIcon: Icons.access_time,
                    controller: paymentRateController,
                    validator: ValidationServices.validatePaymentRate,
                  ),
                  paymentType(),
                  const SizedBox(height: 20),
                  _button(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget paymentType() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        PaymentTypeCard(
          imageUrl: ImageUrl().hourlyRate,
          title: 'Per Hour',
          paymentTypeEnum: PaymentTypeEnum.perHour,
        ),
        PaymentTypeCard(
          imageUrl: ImageUrl().monthlyRate,
          title: 'Per Month',
          paymentTypeEnum: PaymentTypeEnum.perMonth,
        ),
      ],
    );
  }

  Widget _button() {
    return BlocConsumer<JobsCubit, JobsState>(
      listener: (context, state) {
        if (state is JobsLoaded) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Job added successfully')),
          );
          Navigator.pop(context);
        }
        if (state is JobsError) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text(state.message)));
        }
      },
      builder: (context, state) {
        return AppButton(
          text: state is JobsLoading ? 'Wait' : 'Add job',
          color: state is JobsLoading ? Colors.grey : Colors.blue,
          onPressed: () {
            if (formKey.currentState!.validate() && state is! JobsLoading) {
              Job job = Job(
                title: jobTitleController.text,
                description: jobDescriptionController.text,
                paymentRate: int.parse(paymentRateController.text),
                paymentType: PaymentTypeCubit.get(context).state,
                requiredSkills: jobRequiredSkillsController.text.split(','),
                jobOwnerId: widget.jobOwner.id!,
                jobOwnerCompanyName: widget.jobOwner.companyName,
              );
              JobsCubit.get(context).addJob(job);
            }
          },
        );
      },
    );
  }
}

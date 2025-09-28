import 'package:flutter/material.dart';
import 'package:job_link/core/consts/assets_path/image_url.dart';
import 'package:job_link/core/router/router_strings.dart';
import 'package:job_link/core/theme/app_theme.dart';
import 'package:job_link/modules/auth/data/enum/user_types_enum.dart';
import 'package:job_link/modules/auth/controllers/user_provider.dart';
import 'package:job_link/core/shared/widgets/app_button.dart';
import 'package:job_link/core/shared/widgets/image_with_title_card.dart';
import 'package:job_link/modules/auth/presentation/widgets/rich_text_title.dart';
import 'package:provider/provider.dart';

class SelectUserTypeScreen extends StatelessWidget {
  const SelectUserTypeScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const RichTextTitle(
                titlePart1: "Let's ",
                titlePart2: 'personalize your ',
                titlePart3: 'experience',
              ),
              const SizedBox(height: 20),
              _subTitle(context),
              const SizedBox(height: 30),
              _selectFreelance(context),
              _selectCompany(context),
              const SizedBox(height: 20),

              _button(context),

              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  Widget _subTitle(BuildContext context) {
    final AppTheme theme = Theme.of(context).extension<AppTheme>()!;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: Text(
        "Tell us who you are so we can tailor the app just for you.",
        textAlign: TextAlign.center,
        style: theme.hintStyle.copyWith(fontSize: 20),
      ),
    );
  }

  Widget _selectFreelance(BuildContext context) {
    return Selector<UserProvider, UserTypeEnum>(
      selector: (_, provider) => provider.selectedType,
      builder: (_, selectedType, __) => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: ImageWithTitleCard(
          imagePath: ImageUrl().freelancer,
          title: "I'm looking for a job",
          onTap: () =>
              context.read<UserProvider>().setUserType(UserTypeEnum.freelancer),
          isSelected: selectedType == UserTypeEnum.freelancer,
          height: MediaQuery.of(context).size.height * 0.25,
        ),
      ),
    );
  }

  Widget _selectCompany(BuildContext context) {
    return Selector<UserProvider, UserTypeEnum>(
      selector: (_, provider) => provider.selectedType,
      builder: (_, selectedType, __) => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: ImageWithTitleCard(
          imagePath: ImageUrl().company,
          title: "I'm hiring talent",
          onTap: () =>
              context.read<UserProvider>().setUserType(UserTypeEnum.jobOwner),
          isSelected: selectedType == UserTypeEnum.jobOwner,
          height: MediaQuery.of(context).size.height * 0.25,
        ),
      ),
    );
  }

  Widget _button(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: AppButton(
        text: 'Next',
        onPressed: () {
          final selected = context.read<UserProvider>().selectedType;
          if (selected == UserTypeEnum.freelancer) {
            Navigator.of(context).pushNamed(RouterStrings.freelancerForm);
          } else if (selected == UserTypeEnum.jobOwner) {
            Navigator.of(context).pushNamed(RouterStrings.companyForm);
          }
        },
      ),
    );
  }
}

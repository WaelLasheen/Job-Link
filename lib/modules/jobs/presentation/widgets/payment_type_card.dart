import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:job_link/core/shared/widgets/image_with_title_card.dart';
import 'package:job_link/modules/jobs/controller/payment_type_cubit/payment_type_cubit.dart';
import 'package:job_link/modules/jobs/data/enum/payment_type_enum.dart';

class PaymentTypeCard extends StatelessWidget {
  final String imageUrl;
  final String title;
  final PaymentTypeEnum paymentTypeEnum;

  const PaymentTypeCard({
    super.key,
    required this.imageUrl,
    required this.title,
    required this.paymentTypeEnum,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PaymentTypeCubit, PaymentTypeEnum>(
      builder: (context, state) {
        return ImageWithTitleCard(
          imagePath: imageUrl,
          title: title,
          onTap: () =>
              PaymentTypeCubit.get(context).changePaymentType(paymentTypeEnum),
          isSelected: state == paymentTypeEnum,
          width: MediaQuery.of(context).size.width * 0.25,
          height: MediaQuery.of(context).size.width * 0.25,
        );
      },
    );
  }
}

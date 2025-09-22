import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:job_link/modules/jobs/data/enum/payment_type_enum.dart';

class PaymentTypeCubit extends Cubit<PaymentTypeEnum> {
  PaymentTypeCubit() : super(PaymentTypeEnum.perHour);

  void changePaymentType(PaymentTypeEnum paymentType) {
    if (state != paymentType) {
      emit(paymentType);
    }
  }

  static PaymentTypeCubit get(context) => BlocProvider.of(context);
}

import 'package:flutter/material.dart';
import 'package:rest_now_tt/src/routes/router.dart';
import 'package:rxdart/rxdart.dart';

class PaymentScreenViewModel {
  final isProcessing = BehaviorSubject<bool>.seeded(false);

  void simulatePayment(BuildContext context) {
    isProcessing.add(true);

    Future.delayed(const Duration(seconds: 2), () {
      isProcessing.add(false);

      if (context.mounted) {
        Navigator.of(context).pushNamedAndRemoveUntil(
          AppRouteKeys.control,
          (route) => false,
        );
      }
    });
  }
}

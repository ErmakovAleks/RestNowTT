import 'package:flutter/material.dart';
import 'package:rest_now_tt/src/constants/app_colors.dart';
import 'package:rest_now_tt/src/ui/payment_screen/payment_screen_view_model.dart';
import 'package:rest_now_tt/src/widgets/primary_button.dart';

class PaymentScreen extends StatefulWidget {
  final PaymentScreenViewModel viewModel;

  const PaymentScreen({
    super.key,
    required this.viewModel,
  });

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<bool>(
          stream: widget.viewModel.isProcessing,
          builder: (context, snapshot) {
            return Stack(
              children: [
                _body(context),
                if (snapshot.data ?? false)
                  const Center(
                    child: CircularProgressIndicator(
                        color: AppColors.primaryDark ),
                  ),
              ],
            );
          }),
    );
  }

  Widget _body(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [AppColors.gradientStart, AppColors.gradientFinish],
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Expanded(
            child: Center(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.0),
                child: Text(
                  'Повсякденне життя має бути приємним',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: AppColors.primaryLight,
                    fontSize: 40.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(52.0, 0.0, 52.0, 40.0),
            child: PrimaryButton(
              title: 'Оплатити',
              onPressed: () {
                widget.viewModel.simulatePayment(context);
              },
            ),
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:rest_now_tt/src/constants/app_colors.dart';

class PrimaryButton extends StatelessWidget {
  final String title;
  final VoidCallback? onPressed;

  const PrimaryButton({
    super.key,
    required this.title,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
        backgroundColor: AppColors.primaryDark,
        foregroundColor: AppColors.primaryLight,
      ),
      onPressed: onPressed,
      child: Text(title),
    );
  }
}

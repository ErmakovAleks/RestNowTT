import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rest_now_tt/src/ui/control_screen/control_screen.dart';
import 'package:rest_now_tt/src/ui/control_screen/control_screen_view_model.dart';
import 'package:rest_now_tt/src/ui/payment_screen/payment_screen.dart';
import 'package:rest_now_tt/src/ui/payment_screen/payment_screen_view_model.dart';

abstract class AppRouteKeys {
  static const String payment = 'payment';
  static const String control = 'control';
}

// ignore: body_might_complete_normally_nullable, non_constant_identifier_names
Route<dynamic>? AppRouter(RouteSettings settings) {
  switch (settings.name) {
    case AppRouteKeys.payment:
      return nativePageRoute(
        settings: settings,
        builder: (context) {
          final viewModel = PaymentScreenViewModel();
          return PaymentScreen(viewModel: viewModel);
        },
      );
    case AppRouteKeys.control:
      return nativePageRoute(
        settings: settings,
        builder: (context) {
          final viewModel = ControlScreenViewModel();
          return ControlScreen(viewModel: viewModel);
        },
      );
  }
}

PageRoute<T>? nativePageRoute<T>({
  required WidgetBuilder builder,
  required RouteSettings settings,
}) {
  if (Platform.isAndroid) {
    return MaterialPageRoute<T>(
      builder: builder,
      settings: settings,
    );
  } else {
    return CupertinoPageRoute<T>(
      builder: builder,
      settings: settings,
    );
  }
}

import 'package:flutter/material.dart';
import 'package:rest_now_tt/src/routes/router.dart';
import 'package:rest_now_tt/src/utils/shared_preferences_wrapper.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SharedPreferencesWrapper.processInitialize();
  
  runApp(const MassageApp());
}

class MassageApp extends StatelessWidget {
  const MassageApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Massage Simulator',
      initialRoute: AppRouteKeys.payment,
      onGenerateRoute: AppRouter,
    );
  }
}

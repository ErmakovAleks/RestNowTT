import 'package:flutter/material.dart';
import 'package:rest_now_tt/src/constants/app_colors.dart';
import 'package:rest_now_tt/src/ui/control_screen/control_screen_view_model.dart';
import 'package:rest_now_tt/src/widgets/primary_button.dart';

class ControlScreen extends StatefulWidget {
  final ControlScreenViewModel viewModel;

  const ControlScreen({
    super.key,
    required this.viewModel,
  });

  @override
  State<ControlScreen> createState() => _ControlScreenState();
}

class _ControlScreenState extends State<ControlScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(),
      body: _body(),
    );
  }

  PreferredSizeWidget _appBar() {
    return AppBar(
      title: const Text(
        'Керування масажером',
        style: TextStyle(
          fontSize: 20.0,
          fontWeight: FontWeight.bold,
          color: AppColors.primaryLight,
        ),
      ),
      backgroundColor: AppColors.startShaded,
    );
  }

  Widget _body() {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [AppColors.gradientStart, AppColors.gradientFinish],
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 52.0),
        child: StreamBuilder(
          stream: widget.viewModel.isProcessing,
          builder: (context, snapshot) {
            return Stack(
              children: [
                _content(),
                if (snapshot.data ?? false)
                  const Center(
                    child: CircularProgressIndicator(
                        color: AppColors.primaryDark),
                  ),
              ],
            );
          },
        ),
      ),
    );
  }

  List<Widget> _simulatorStatus(String status) {
    return [
      const Text(
        'Поточний статус тренажера:',
        style: TextStyle(
          fontSize: 24.0,
          fontWeight: FontWeight.bold,
          color: AppColors.primaryLight,
        ),
        textAlign: TextAlign.center,
      ),
      Text(
        status,
        style: const TextStyle(
          fontSize: 24.0,
          fontWeight: FontWeight.bold,
          color: AppColors.primaryLight,
        ),
        textAlign: TextAlign.center,
      ),
    ];
  }

  List<Widget> _buttons() {
    return [
      PrimaryButton(
        title: 'Старт масажу',
        onPressed: () {
          widget.viewModel.sendCommand(SimulatorCommand.start, context);
        },
      ),
      const SizedBox(height: 20.0),
      PrimaryButton(
        title: 'Стоп масажу',
        onPressed: () {
          widget.viewModel.sendCommand(SimulatorCommand.stop, context);
        },
      ),
    ];
  }

  Widget _content() {
    return StreamBuilder<String>(
      stream: widget.viewModel.statusMessage,
      builder: (context, snapshot) {
        final status = (snapshot.data?.isNotEmpty ?? false)
            ? snapshot.data!
            : 'не підключено';
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(
              height: 200,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [..._simulatorStatus(status)],
              ),
            ),
            ..._buttons(),
          ],
        );
      },
    );
  }
}

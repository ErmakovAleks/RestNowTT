import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:rest_now_tt/src/utils/error_handable.dart';
import 'package:rxdart/rxdart.dart';
import 'package:http/http.dart' as http;

enum SimulatorCommand {
  start,
  stop;
}

class ControlScreenViewModel with ErrorHandable {
  final isProcessing = BehaviorSubject<bool>.seeded(false);
  final statusMessage = BehaviorSubject<String>.seeded('');

  Future<void> sendCommand(SimulatorCommand command, BuildContext context) async {
    isProcessing.add(true);

    final cmd = command == SimulatorCommand.start ? 'Старт' : 'Стоп';

    try {
      final response = await http.post(
        Uri.parse('https://jsonplaceholder.typicode.com/posts'),
        // Uri.parse('https://example.com/posts'),
        body: jsonEncode({'command': cmd}),
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode >= 200 && response.statusCode < 300) {
        statusMessage.add('команда "$cmd" виконана успішно');
      } else {
        throw Exception('Помилка сервера');
      }
    } catch (e) {
      print('<!> Error = ${e}');
      if (context.mounted) showAlertDialog(context, 'Помилка команди "$cmd"', 'Сервер не відповідає');
    } finally {
      isProcessing.add(false);
    }
  }
}
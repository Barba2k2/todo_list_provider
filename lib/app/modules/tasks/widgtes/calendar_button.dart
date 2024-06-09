import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../../core/ui/theme_extensions.dart';
import '../../../core/ui/todo_list_ui_config.dart';
import '../task_create_controller.dart';

class CalendarButton extends StatelessWidget {
  final dateFormat = DateFormat('dd/MM/yyyy');

  CalendarButton({super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async {
        var lastDate = DateTime.now();
        lastDate = lastDate.add(
          const Duration(days: 365 * 10),
        );

        final DateTime? selectedDate = await showDatePicker(
          context: context,
          initialDate: DateTime.now(),
          firstDate: DateTime(2020),
          lastDate: lastDate,
          barrierColor: Colors.black.withOpacity(0.5),
          builder: (context, child) => Theme(
            data: TodoListUiConfig.theme.copyWith(
              colorScheme: ColorScheme.light(
                primary: context.primaryColor,
                onPrimary: Colors.white,
              ),
            ),
            child: child!,
          ),
        );

        if (selectedDate != null) {
          log('Seletec Date: $selectedDate');
          context.read<TaskCreateController>().selectedDate = selectedDate;
        }
      },
      borderRadius: BorderRadius.circular(30),
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          border: Border.all(
            color: Colors.grey,
            width: 1,
          ),
          borderRadius: BorderRadius.circular(30),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.calendar_today_rounded,
              color: Colors.grey,
            ),
            const SizedBox(
              width: 10,
            ),
            Selector<TaskCreateController, DateTime?>(
              selector: (context, controller) => controller.selectedDate,
              builder: (context, selectedDate, child) {
                if (selectedDate != null) {
                  return Text(
                    dateFormat.format(selectedDate),
                    style: context.titleStyle.copyWith(
                      fontSize: 16,
                    ),
                  );
                } else {
                  return Text(
                    'SELECIONE UMA DATA',
                    style: context.titleStyle.copyWith(
                      fontSize: 14,
                    ),
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}

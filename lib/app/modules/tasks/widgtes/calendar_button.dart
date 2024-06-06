import 'package:flutter/material.dart';

import '../../../core/ui/theme_extensions.dart';

class CalendarButton extends StatelessWidget {
  const CalendarButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
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
          Text(
            'SELECIONE UMA DATA',
            style: context.titleStyle.copyWith(
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }
}

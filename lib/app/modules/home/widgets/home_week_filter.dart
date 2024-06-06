import 'package:date_picker_timeline/date_picker_timeline.dart';
import 'package:flutter/material.dart';

import '../../../core/ui/theme_extensions.dart';

class HomeWeekFilter extends StatelessWidget {
  const HomeWeekFilter({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(
          height: 20,
        ),
        Text(
          'DIA DA SEMANA',
          style: context.titleStyle,
        ),
        SizedBox(
          height: 10,
        ),
        Container(
          height: 96,
          child: DatePicker(
            DateTime.now(),
            locale: 'pt_BR',
            height: 2,
            initialSelectedDate: DateTime.now(),
            selectionColor: context.primaryColor,
            selectedTextColor: Colors.white,
            daysCount: 7,
            monthTextStyle: TextStyle(
              fontSize: 8,
            ),
            dayTextStyle: TextStyle(
              fontSize: 14,
            ),
            dateTextStyle: TextStyle(
              fontSize: 20,
            ),
          ),
        ),
      ],
    );
  }
}
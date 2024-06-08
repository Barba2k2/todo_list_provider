import 'package:flutter/material.dart';

import '../../../core/ui/theme_extensions.dart';
import 'task.dart';

class HomeTasks extends StatelessWidget {
  const HomeTasks({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(
          height: 20,
        ),
        Text(
          'TASK\'S DE HOJE',
          style: context.titleStyle,
        ),
        const Column(
          children: [
            Task(),
            Task(),
            Task(),
          ],
        )
      ],
    );
  }
}

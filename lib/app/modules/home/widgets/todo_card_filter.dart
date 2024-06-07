import 'package:flutter/material.dart';

import '../../../core/ui/theme_extensions.dart';

class TodoCardFilter extends StatelessWidget {
  const TodoCardFilter({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints(
        minHeight: 120,
        maxWidth: 150,
      ),
      margin: const EdgeInsets.only(right: 10),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: context.primaryColor,
        border: Border.all(
          width: 1,
          color: Colors.grey.withOpacity(.8),
        ),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // SizedBox(
          //   height: 20,
          //   width: 20,
          //   child: CircularProgressIndicator.adaptive(),
          // )
          Text(
            '10 TASKS',
            style: context.titleStyle.copyWith(
              fontSize: 10,
              color: Colors.white,
            ),
          ),
          const Text(
            'HOJE',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          LinearProgressIndicator(
            backgroundColor: context.primaryColorLight,
            valueColor: const AlwaysStoppedAnimation<Color>(Colors.white),
            value: 0.8,
          ),
        ],
      ),
    );
  }
}

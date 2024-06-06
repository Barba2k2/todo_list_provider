import 'package:flutter/material.dart';

class Task extends StatelessWidget {
  const Task({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 6),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: const [
          BoxShadow(
            color: Colors.grey,
          ),
        ],
      ),
      child: IntrinsicHeight(
        child: ListTile(
          contentPadding: const EdgeInsets.all(8),
          leading: Checkbox(
            value: true,
            onChanged: (value) {},
          ),
          title: const Text(
            'Estudar Flutter',
            style: TextStyle(
              decoration: TextDecoration.lineThrough,
            ),
          ),
          subtitle: const Text(
            '20/07/2021',
            style: TextStyle(
              decoration: TextDecoration.lineThrough,
            ),
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
            side: const BorderSide(
              width: 1,
              strokeAlign: BorderSide.strokeAlignCenter,
            ),
          ),
        ),
      ),
    );
  }
}

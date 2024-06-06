import 'package:flutter/material.dart';

import '../../../core/ui/theme_extensions.dart';
import 'todo_card_filter.dart';

class HomeFilter extends StatefulWidget {
  const HomeFilter({super.key});

  @override
  State<HomeFilter> createState() => _HomeFilterState();
}

class _HomeFilterState extends State<HomeFilter> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'FILTROS',
          style: context.titleStyle,
        ),
        const SizedBox(
          height: 10,
        ),
        const SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              TodoCardFilter(),
              TodoCardFilter(),
              TodoCardFilter(),
              TodoCardFilter(),
              TodoCardFilter(),
              TodoCardFilter(),
              TodoCardFilter(),
              TodoCardFilter(),
              TodoCardFilter(),
              TodoCardFilter(),
              TodoCardFilter(),
              TodoCardFilter(),
            ],
          ),
        ),
      ],
    );
  }
}

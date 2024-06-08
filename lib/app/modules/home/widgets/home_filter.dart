import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../core/ui/theme_extensions.dart';
import '../../../models/task_filter_enum.dart';
import '../../../models/total_tasks_models.dart';
import '../home_controller.dart';
import 'todo_card_filter.dart';

class HomeFilter extends StatelessWidget {
  const HomeFilter({super.key});

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
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              TodoCardFilter(
                label: 'HOJE',
                taskFilter: TaskFilterEnum.today,
                totalTasksModel: TotalTasksModel(
                  totalTasks: 8,
                  totalTasksFinish: 10,
                ),
                selected: context.select<HomeController, TaskFilterEnum>(
                      (value) => value.filterSelect,
                    ) ==
                    TaskFilterEnum.today,
              ),
              TodoCardFilter(
                label: 'AMANHÃ',
                taskFilter: TaskFilterEnum.tomorrow,
                totalTasksModel: TotalTasksModel(
                  totalTasks: 10,
                  totalTasksFinish: 8,
                ),
                selected: context.select<HomeController, TaskFilterEnum>(
                      (value) => value.filterSelect,
                    ) ==
                    TaskFilterEnum.tomorrow,
              ),
              TodoCardFilter(
                label: 'SEMANA',
                taskFilter: TaskFilterEnum.week,
                totalTasksModel: TotalTasksModel(
                  totalTasks: 10,
                  totalTasksFinish: 8,
                ),
                selected: context.select<HomeController, TaskFilterEnum>(
                      (value) => value.filterSelect,
                    ) ==
                    TaskFilterEnum.week,
              ),
            ],
          ),
        ),
      ],
    );
  }
}

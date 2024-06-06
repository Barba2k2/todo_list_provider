import 'package:flutter/material.dart';

import '../../core/ui/theme_extensions.dart';
import 'widgets/home_drawer.dart';
import 'widgets/home_filter.dart';
import 'widgets/home_header.dart';
import 'widgets/home_tasks.dart';
import 'widgets/home_week_filter.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(kToolbarHeight),
        child: SafeArea(
          child: AppBar(
            elevation: 0,
            backgroundColor: const Color(0xFFFAFBFA),
            iconTheme: IconThemeData(
              color: context.primaryColor,
            ),
            actions: [
              PopupMenuButton(
                color: Colors.white,
                icon: const Icon(
                  Icons.filter_list_alt,
                  size: 36,
                ),
                itemBuilder: (_) => [
                  const PopupMenuItem<bool>(
                    child: Text('Mostrar tarefas concluidas'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
      backgroundColor: const Color(0xFFFAFBFA),
      drawer: HomeDrawer(),
      body: LayoutBuilder(
        builder: (context, constraints) {
          return SingleChildScrollView(
            child: ConstrainedBox(
              constraints: BoxConstraints(
                minHeight: constraints.maxHeight,
                minWidth: constraints.maxWidth,
              ),
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 20),
                child: const IntrinsicHeight(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      HomeHeader(),
                      HomeFilter(),
                      HomeWeekFilter(),
                      HomeTasks(),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

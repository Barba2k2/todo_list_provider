import 'package:flutter/material.dart';

import '../../core/ui/theme_extensions.dart';
import '../../core/widgets/todo_list_field.dart';
import 'task_create_controller.dart';
import 'widgtes/calendar_button.dart';

class TasksCreatePage extends StatelessWidget {
  TaskCreateController _controller;

  TasksCreatePage({
    super.key,
    required TaskCreateController controller,
  }) : _controller = controller;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text('Task'),
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
            onPressed: () {
              // _controller.saveTask();
              Navigator.of(context).pop();
            },
            icon: const Icon(
              Icons.close_rounded,
              color: Colors.black,
              size: 30,
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {},
        backgroundColor: context.primaryColor,
        label: const Text(
          'Salvar Task',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.white,
            fontSize: 18,
          ),
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
        ),
      ),
      body: Form(
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 30),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Align(
                alignment: Alignment.center,
                child: Text(
                  'Criar Task',
                  style: context.titleStyle.copyWith(
                    fontSize: 24,
                    color: Colors.grey[500],
                  ),
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              TodoListField(
                label: 'Título',
              ),
              const SizedBox(
                height: 20,
              ),
              const CalendarButton(),
            ],
          ),
        ),
      ),
    );
  }
}

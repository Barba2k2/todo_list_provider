import 'package:flutter/material.dart';
import 'package:validatorless/validatorless.dart';

import '../../core/notifier/default_listener_notifier.dart';
import '../../core/ui/theme_extensions.dart';
import '../../core/widgets/todo_list_field.dart';
import 'task_create_controller.dart';
import 'widgtes/calendar_button.dart';

class TasksCreatePage extends StatefulWidget {
  final TaskCreateController _controller;
  final String userId;

  const TasksCreatePage({
    super.key,
    required TaskCreateController controller,
    required this.userId,
  }) : _controller = controller;

  @override
  State<TasksCreatePage> createState() => _TasksCreatePageState();
}

class _TasksCreatePageState extends State<TasksCreatePage> {
  final _formKey = GlobalKey<FormState>();
  final _descriptionEC = TextEditingController();

  @override
  void initState() {
    super.initState();
    widget._controller.userId = widget.userId;
    DefaultListenerNotifier(
      changeNotifier: widget._controller,
    ).listener(
      context: context,
      successCallback: (notifier, listenerInstance) {
        listenerInstance.dispose();
        Navigator.of(context).pop();
      },
    );
  }

  @override
  void dispose() {
    super.dispose();
    _descriptionEC.dispose();
  }

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
        onPressed: () {
          final formValid = _formKey.currentState?.validate() ?? false;

          if (formValid) {
            widget._controller.save(
              _descriptionEC.text,
            );
          }
        },
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
        key: _formKey,
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
                controller: _descriptionEC,
                validator: Validatorless.multiple([
                  Validatorless.required('Descrição é obrigatória'),
                  Validatorless.min(3, 'Mínimo de 3 caracteres'),
                ]),
              ),
              const SizedBox(
                height: 20,
              ),
              CalendarButton(),
            ],
          ),
        ),
      ),
    );
  }
}

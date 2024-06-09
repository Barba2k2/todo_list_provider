import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'app_widget.dart';
import 'core/auth/auth_provider.dart';
import 'core/database/sqlite_connection_factory.dart';
import 'modules/home/home_controller.dart';
import 'repositories/tasks/tasks_repository.dart';
import 'repositories/tasks/tasks_repository_impl.dart';
import 'repositories/user/user_repository.dart';
import 'repositories/user/user_repository_impl.dart';
import 'services/tasks/tasks_service.dart';
import 'services/tasks/tasks_service_impl.dart';
import 'services/user/user_service.dart';
import 'services/user/user_service_impl.dart';

class AppModule extends StatelessWidget {
  const AppModule({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider(
          create: (_) => FirebaseAuth.instance,
        ),
        Provider(
          create: (_) => SqliteConnectionFactory(),
          lazy: false,
        ),
        Provider<UserRepository>(
          create: (context) => UserRepositoryImpl(
            firebaseAuth: context.read(),
          ),
        ),
        Provider<UserService>(
          create: (context) => UserServiceImpl(
            userRepository: context.read(),
          ),
        ),
        Provider<TasksRepository>(
          create: (context) => TasksRepositoryImpl(
            sqliteConnectionFactory: context.read(),
          ),
        ),
        Provider<TasksService>(
          create: (context) => TasksServiceImpl(
            tasksRepository: context.read(),
          ),
        ),
        ChangeNotifierProvider(
          create: (context) => TodoListAuthProvider(
            firebaseAuth: context.read<FirebaseAuth>(),
            userService: context.read<UserService>(),
          )..loadListener(),
          lazy: false,
        ),
        ChangeNotifierProvider(
          create: (context) => HomeController(
            tasksService: context.read<TasksService>(),
          ),
        ),
        ProxyProvider<User?, String?>(
          update: (context, user, previous) => user?.uid,
        ),
      ],
      child: const AppWidget(),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';

import 'core/database/sqlite_adm_connection.dart';
import 'core/database/sqlite_connection_factory.dart';
import 'core/navigator/todo_list_navigator.dart';
import 'core/ui/todo_list_ui_config.dart';
import 'modules/auth/auth_module.dart';
import 'modules/home/home_controller.dart';
import 'modules/home/home_module.dart';
import 'modules/splash/splash_page.dart';
import 'modules/tasks/tasks_module.dart';
import 'repositories/tasks/tasks_repository.dart';
import 'repositories/tasks/tasks_repository_impl.dart';
import 'services/tasks/tasks_service.dart';
import 'services/tasks/tasks_service_impl.dart';

class AppWidget extends StatefulWidget {
  const AppWidget({super.key});

  @override
  State<AppWidget> createState() => _AppWidgetState();
}

class _AppWidgetState extends State<AppWidget> {
  final sqliteAdmConnection = SqliteAdmConnection();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(
      sqliteAdmConnection,
    );
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(
      sqliteAdmConnection,
    );
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider(
          create: (_) => sqliteAdmConnection,
        ),
        Provider<TasksRepository>(
          create: (context) => TasksRepositoryImpl(
            sqliteConnectionFactory: context.read<SqliteConnectionFactory>(),
          ),
        ),
        Provider<TasksService>(
          create: (context) => TasksServiceImpl(
            tasksRepository: context.read<TasksRepository>(),
          ),
        ),
        ChangeNotifierProvider(
          create: (context) => HomeController(
            tasksService: context.read<TasksService>(),
          ),
        ),
      ],
      child: MaterialApp(
        title: 'Todo List Provider',
        theme: TodoListUiConfig.theme,
        navigatorKey: TodoListNavigator.navigatorKey,
        localizationsDelegates: const [
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: const [
          Locale('pt', 'BR'),
        ],
        routes: {
          ...AuthModule().routers,
          ...HomeModule().routers,
          ...TasksModule().routers,
        },
        home: const SplashPage(),
      ),
    );
  }
}

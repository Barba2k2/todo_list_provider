import 'package:provider/provider.dart';

import '../../core/modules/todo_list_module.dart';
import '../home/home_controller.dart';
import 'login/login_controller.dart';
import 'login/login_page.dart';
import 'register/register_controller.dart';
import 'register/register_page.dart';

class AuthModule extends TodoListModule {
  AuthModule()
      : super(
          bindings: [
            ChangeNotifierProvider(
              create: (context) => LoginController(
                homeController: context.read<HomeController>(),
                userService: context.read(),
                authProvider: context.read(),
              ),
            ),
            ChangeNotifierProvider(
              create: (context) => RegisterController(
                userService: context.read(),
              ),
            ),
          ],
          routers: {
            '/login': (context) => const LoginPage(),
            '/register': (context) => const RegisterPage(),
          },
        );
}

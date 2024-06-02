import 'package:flutter/material.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';

import '../../../core/widgets/todo_list_field.dart';
import '../../../core/widgets/todo_list_logo.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            return SingleChildScrollView(
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  minHeight: constraints.maxHeight,
                  minWidth: constraints.maxHeight,
                ),
                child: IntrinsicHeight(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const SizedBox(
                        height: 10,
                      ),
                      const TodoListLogo(),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 40,
                          vertical: 20,
                        ),
                        child: Form(
                          child: Column(
                            children: [
                              TodoListField(
                                label: 'E-mail',
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              TodoListField(
                                label: 'Senha',
                                obscureText: true,
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  TextButton(
                                    onPressed: () {},
                                    child: const Text('Esqueceu sua senha?'),
                                  ),
                                  ElevatedButton(
                                    onPressed: () {},
                                    // ignore: sort_child_properties_last
                                    child: const Padding(
                                      padding: EdgeInsets.all(10),
                                      child: Text(
                                        'Login',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.w500,
                                          fontSize: 16,
                                        ),
                                      ),
                                    ),
                                    style: ElevatedButton.styleFrom(
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                      // primary: Theme.of(context).buttonColor,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Expanded(
                        child: Container(
                          decoration: BoxDecoration(
                            color: const Color(0xFFF0F3F7),
                            border: Border(
                              top: BorderSide(
                                color: Colors.grey.withAlpha(50),
                                width: 2,
                              ),
                            ),
                          ),
                          child: Column(
                            children: [
                              const SizedBox(
                                height: 20,
                              ),
                              SignInButton(
                                Buttons.Google,
                                text: 'Continue com Google',
                                padding: const EdgeInsets.all(6),
                                shape: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(30),
                                  borderSide: BorderSide.none,
                                ),
                                onPressed: () {},
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Text('Não tem uma conta?'),
                                  TextButton(
                                    onPressed: () {
                                      Navigator.of(context).pushNamed(
                                        '/register',
                                      );
                                    },
                                    child: const Text('Cadastre-se'),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

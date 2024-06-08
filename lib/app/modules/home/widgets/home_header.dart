import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../core/auth/auth_provider.dart';
import '../../../core/ui/theme_extensions.dart';

class HomeHeader extends StatelessWidget {
  const HomeHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20.0),
      child: Selector<TodoListAuthProvider, String>(
        selector: (context, authProvider) {
          return authProvider.user?.displayName ?? 'Nao informado';
        },
        builder: (_, value, __) {
          return Text(
            'E aí, $value!',
            style: context.textTheme.headlineMedium?.copyWith(
              fontWeight: FontWeight.bold,
            ),
            overflow: TextOverflow.ellipsis,
          );
        },
      ),
    );
  }
}

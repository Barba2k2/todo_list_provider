import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../core/auth/auth_provider.dart';
import '../../../core/ui/messages.dart';
import '../../../core/ui/theme_extensions.dart';
import '../../../services/user/user_service.dart';

class HomeDrawer extends StatelessWidget {
  final nameVN = ValueNotifier<String>('');

  HomeDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(20),
          bottomRight: Radius.circular(20),
        ),
      ),
      child: ListView(
        children: [
          DrawerHeader(
            decoration: BoxDecoration(
              color: context.primaryColor.withAlpha(70),
            ),
            child: Row(
              children: [
                Selector<TodoListAuthProvider, String>(
                  selector: (context, authProvider) {
                    return authProvider.user?.photoURL ??
                        'https://encrypted-tbn2.gstatic.com/images?q=tbn:ANd9GcQM78CdN1ec7XmOaPKLnzLP2CbKNWgEeGNzzzHx_6w-WOBAyhOD4DzKhAypWV57t6_93zvPpoFNyWppUTwNM-qaEHS5ItdqwPWAnwnxPDs';
                  },
                  builder: (_, value, __) {
                    return CircleAvatar(
                      backgroundImage: NetworkImage(value),
                      radius: 30,
                    );
                  },
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Selector<TodoListAuthProvider, String>(
                      selector: (context, authProvider) {
                        return authProvider.user?.displayName ??
                            'Nao informado';
                      },
                      builder: (_, value, __) {
                        return Text(
                          value,
                          style: context.textTheme.titleMedium,
                        );
                      },
                    ),
                  ),
                )
              ],
            ),
          ),
          ListTile(
            onTap: () {
              showDialog(
                context: context,
                builder: (_) => AlertDialog(
                  title: const Text('Alterar nome'),
                  content: TextField(
                    onChanged: (value) => nameVN.value = value,
                    decoration: InputDecoration(
                      labelText: 'Nome',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                        borderSide: BorderSide(
                          width: 1.0,
                          color: context.primaryColor,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                        borderSide: BorderSide(
                          width: 2.0,
                          color: context.primaryColor,
                        ),
                      ),
                      focusedErrorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                        borderSide: const BorderSide(
                          width: 3.0,
                          color: Colors.red,
                        ),
                      ),
                    ),
                  ),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.of(context).pop(),
                      child: const Text(
                        'Cancelar',
                        style: TextStyle(
                          color: Colors.red,
                        ),
                      ),
                    ),
                    TextButton(
                      onPressed: () async {
                        final nameValue = nameVN.value;
                        if (nameValue.isEmpty) {
                          Messages.of(context).showError(
                            'Nome não pode ser vazio',
                          );
                        } else {
                          await context
                              .read<UserService>()
                              .updateDisplayName(nameValue);
                          Navigator.of(context).pop();
                        }
                      },
                      child: const Text('Alterar'),
                    ),
                  ],
                ),
              );
            },
            title: const Text('Alterar nome'),
          ),
          ListTile(
            title: const Text('Sair'),
            onTap: () => context.read<TodoListAuthProvider>().logout(),
          )
        ],
      ),
    );
  }
}

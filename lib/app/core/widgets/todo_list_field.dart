import 'package:flutter/material.dart';

class TodoListField extends StatelessWidget {
  final String label;
  final bool obscureText;
  final IconButton? suffixIconButton;
  final Icon? suffixIcon;
  final ValueNotifier<bool> obscureTextVN;
  final TextEditingController? controller;
  final FormFieldValidator<String>? validator;
  final FocusNode? focusNode;

  TodoListField({
    super.key,
    required this.label,
    this.suffixIconButton,
    this.suffixIcon,
    this.obscureText = false,
    this.controller,
    this.validator,
    this.focusNode,
  })  : assert(
          obscureText == true ? suffixIconButton == null : true,
          'Obscure Text não pode ser enviado em conjunto com SuffixIconButton',
        ),
        obscureTextVN = ValueNotifier(obscureText);

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<bool>(
      valueListenable: obscureTextVN,
      builder: (_, obscureTextValue, child) {
        return TextFormField(
          controller: controller,
          validator: validator,
          focusNode: focusNode,
          decoration: InputDecoration(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
              borderSide: const BorderSide(
                color: Colors.red,
              ),
            ),
            labelText: label,
            labelStyle: const TextStyle(
              color: Colors.black,
              fontSize: 16,
            ),
            isDense: true,
            suffixIcon: suffixIconButton ??
                (obscureText == true
                    ? IconButton(
                        icon: Icon(
                          !obscureTextValue
                              ? Icons.lock_open_rounded
                              : Icons.lock_rounded,
                          size: 22,
                        ),
                        onPressed: () {
                          obscureTextVN.value = !obscureTextVN.value;
                        },
                      )
                    : null),
          ),
          obscureText: obscureTextValue,
        );
      },
    );
  }
}

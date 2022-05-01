import 'package:flutter/material.dart';


class LoginTextFormfield extends StatelessWidget {
  const LoginTextFormfield({
    Key? key,this.icon, this.hint, this.keyboard, this.validator,this.controller
  }) : super(key: key);

  final String? hint;
  final IconData? icon;
  final TextInputType? keyboard;
  final validator;
  // final FormFieldSetter? onSaved;
  // final ValueChanged? onChanged;
  // final bool? obscureText;
  final controller;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(30),
          boxShadow: [
            BoxShadow(
              blurRadius: 10,
              offset: Offset(1, 1),
              color: Colors.grey.withOpacity(0.3),
            ),
          ],
        ),
        child: TextFormField(
          controller: controller,
          obscureText: hint == "비밀번호" ? true : false,
          key: ValueKey(4),
          validator: validator,
          // onChanged: onChanged,
          // onSaved: onSaved,
          keyboardType: keyboard,
          decoration: InputDecoration(
            prefixIcon: Icon(
              icon,
              color: Colors.orangeAccent,
            ),
            enabledBorder: const OutlineInputBorder(
              borderSide: BorderSide(
                color: Colors.orange,
              ),
              borderRadius: BorderRadius.all(
                Radius.circular(35.0),
              ),
            ),
            focusedBorder: const OutlineInputBorder(
              borderSide: BorderSide(
                color: Colors.orange,
              ),
              borderRadius: BorderRadius.all(
                Radius.circular(35.0),
              ),
            ),
            hintText: '$hint',
            hintStyle: const TextStyle(
              fontFamily: 'Jua',
              color: Colors.black38,
              fontSize: 14,
            ),
          ),
        ),
      ),
    );
  }
}


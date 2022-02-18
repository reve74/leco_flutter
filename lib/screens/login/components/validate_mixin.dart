import 'package:flutter/material.dart';

class LoginTextFormfield extends StatelessWidget {
  const LoginTextFormfield(
      {Key? key, this.icon, this.text, this.keyboard, this.validator})
      : super(key: key);

  final String? text;
  final IconData? icon;
  final TextInputType? keyboard;
  final FormFieldValidator? validator;

  @override
  Widget build(BuildContext context) {

    String userName = '';
    String userEmail = '';
    String userPassword = '';


    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
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
        child: Form(
          child: TextFormField(
            validator: (value) {
              if (value!.isEmpty || value.length < 4) {
                return '4글자 이상 입력해주세요';
              }
              return null;
            },
            onSaved: (value) {
              userName = value!;
            },
            keyboardType: keyboard,
            decoration: InputDecoration(
              prefixIcon: Icon(
                icon!,
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
              hintText: text!,
              hintStyle: const TextStyle(
                color: Colors.black38,
                fontSize: 14,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

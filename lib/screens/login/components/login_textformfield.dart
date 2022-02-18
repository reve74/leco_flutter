import 'package:flutter/material.dart';


class LoginTextField extends StatefulWidget {
  const LoginTextField({Key? key, this.icon, this.text, this.keyboard, this.validator,this.onChanged})
      : super(key: key);

  final String? text;
  final IconData? icon;
  final TextInputType? keyboard;
  final FormFieldValidator? validator;
  final ValueChanged<String>? onChanged;



  @override
  State<LoginTextField> createState() => _LoginTextFieldState();
}

class _LoginTextFieldState extends State<LoginTextField> {
  // final String? validator;

  final _formKey = GlobalKey<FormState>();

  String userName = '';
  String userEmail = '';
  String userPassword = '';


  @override
  Widget build(BuildContext context) {
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
            key: _formKey,
            validator:
              (value) {
              if (value!.isEmpty || value.length < 4) {
                return '4글자 이상 입력해주세요';
              }
              return null;
            },
            onChanged: (value) {
              userName = value;
            },
            onSaved: (value) {
              userName = value!;
            },
            keyboardType: widget.keyboard,
            decoration: InputDecoration(
              prefixIcon: Icon(
                widget.icon!,
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
              hintText: widget.text!,
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

//
//   Widget buttons() {
//     return Container(
//       height: 50,
//       width: 150,
//       child: ElevatedButton(
//         style: ElevatedButton.styleFrom(
//           primary: Colors.yellow,
//           elevation: 0.0,
//           shape: RoundedRectangleBorder(
//             borderRadius: BorderRadius.circular(20),
//           ),
//         ),
//         onPressed: () {
//           tryValidation();
//         },
//         child: const Text(
//           'Sign up',
//           style: TextStyle(
//             fontSize: 25,
//             color: Colors.black,
//           ),
//         ),
//       ),
//     );
//   }
//
// }


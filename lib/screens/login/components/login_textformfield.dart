import 'package:flutter/material.dart';


class LoginTextFormfield extends StatelessWidget {
  const LoginTextFormfield({
    Key? key,this.icon, this.text, this.keyboard, this.validator,this.onChanged, this.onSaved, this.obscureText=false
  }) : super(key: key);

  final String? text;
  final IconData? icon;
  final TextInputType? keyboard;
  final FormFieldValidator<String>? validator;
  final FormFieldSetter? onSaved;
  final ValueChanged? onChanged;
  final bool? obscureText;

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
        child: TextFormField(
          obscureText: obscureText!,
          key: ValueKey(4),
          validator: validator,
          onChanged: onChanged,
          onSaved: onSaved,
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
            hintText: text,
            hintStyle: const TextStyle(
              color: Colors.black38,
              fontSize: 14,
            ),
          ),
        ),
      ),
    );
  }
}




// class LoginTextField extends StatelessWidget {
//   const LoginTextField({Key? key, this.icon, this.text, this.keyboard, this.validator,this.onChanged})
//       : super(key: key);
//
//   final String? text;
//   final IconData? icon;
//   final TextInputType? keyboard;
//   final FormFieldValidator<String>? validator;
//   final ValueChanged<String>? onChanged;
//
//
//   // final _formKey = GlobalKey<FormState>();
//
//
//
//
//   @override
//   Widget build(BuildContext context) {
//     String userName = '';
//     String userEmail = '';
//     String userPassword = '';
//
//
//     return Padding(
//       padding: const EdgeInsets.symmetric(horizontal: 10),
//       child: Container(
//         decoration: BoxDecoration(
//           color: Colors.white,
//           borderRadius: BorderRadius.circular(30),
//           boxShadow: [
//             BoxShadow(
//               blurRadius: 10,
//               offset: Offset(1, 1),
//               color: Colors.grey.withOpacity(0.3),
//             ),
//           ],
//         ),
//         child: TextFormField(
//           validator: validator,
//           onChanged: onChanged,
//           onSaved: (value) {
//             userName = value!;
//           },
//           keyboardType: keyboard,
//           decoration: InputDecoration(
//             prefixIcon: Icon(
//               icon!,
//               color: Colors.orangeAccent,
//             ),
//             enabledBorder: const OutlineInputBorder(
//               borderSide: BorderSide(
//                 color: Colors.orange,
//               ),
//               borderRadius: BorderRadius.all(
//                 Radius.circular(35.0),
//               ),
//             ),
//             focusedBorder: const OutlineInputBorder(
//               borderSide: BorderSide(
//                 color: Colors.orange,
//               ),
//               borderRadius: BorderRadius.all(
//                 Radius.circular(35.0),
//               ),
//             ),
//             hintText: text,
//             hintStyle: const TextStyle(
//               color: Colors.black38,
//               fontSize: 14,
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }

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


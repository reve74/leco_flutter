import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:leco_flutter/constraints.dart';
import 'package:leco_flutter/screens/login/components/signupimage_with_text.dart';
import 'components/login_textformfield.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({Key? key}) : super(key: key);

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final _formKey = GlobalKey<FormState>();

    String userName = '';
    String userEmail = '';
    String userPassword = '';

  void tryValidation() {
    final isValid = _formKey.currentState!.validate();
    print(isValid);
    if (isValid) {
      _formKey.currentState!.save();
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double width = size.width;
    double height = size.height;
    return Scaffold(
      body: SafeArea(
        child: GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
          },
          child: SingleChildScrollView(
            child: Column(
              children: [
                Column(
                  children:  [
                    SignupImagewithText(), // 이미지와 signup 타이틀
                    LoginTextField(
                      icon: Icons.account_circle,
                      text: 'Username',
                      key: _formKey,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    LoginTextField(
                      icon: Icons.email_outlined,
                      text: 'Email',
                      keyboard: TextInputType.emailAddress,
                    ),
                    SizedBox(
                      height: kDefaultPadding / 2,
                    ),
                    LoginTextField(
                      icon: Icons.lock_open_rounded,
                      text: 'Password',
                    ),
                    SizedBox(
                      height: 30,
                    ),
                  ],
                ),
                Container(
                  height: 50,
                  width: 150,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: Colors.yellow,
                      elevation: 0.0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    onPressed: () {
                      // tryValidation();
                      Get.snackbar('LECO', '로그인이 완료되었습니다!',
                          backgroundColor: Colors.white);
                    },
                    child: const Text(
                      'Sign up',
                      style: TextStyle(
                        fontSize: 25,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

}


// renderTextFormField({
//   @required FormFieldSetter? onSaved,
//   @required FormFieldValidator? validator,
//   @required String? text,
//   @required IconData? icon,
//   @required TextInputType? keyboard,
// }) {
//   assert(onSaved != null);
//   assert(validator != null);
//   assert(text != null);
//   assert(icon != null);
//   assert(keyboard != null);
//
//   return Column(
//     children: [
//       Row(
//         children: [
//           Text(
//             label,
//             style: TextStyle(
//               fontSize: 12.0,
//               fontWeight: FontWeight.w700,
//             ),
//           ),
//         ],
//       ),
//       TextFormField(
//         onSaved: onSaved,
//         validator: validator,
//       ),
//     ],
//   );
// }

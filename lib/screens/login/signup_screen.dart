import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:leco_flutter/constraints.dart';
import 'package:leco_flutter/screens/login/components/signupimage_with_text.dart';
import 'package:leco_flutter/screens/login/login_screen.dart';
import 'package:leco_flutter/screens/product/test.dart';
import 'components/login_textformfield.dart';
import 'package:firebase_auth/firebase_auth.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({Key? key}) : super(key: key);

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final _formKey = GlobalKey<FormState>();
  final _authentication = FirebaseAuth.instance;

  String userName = '';
  String userEmail = '';
  String userPassword = '';

  void _tryValidation() {
    final isValid = _formKey.currentState!.validate();
    print(isValid);
    if (isValid) {
      _formKey.currentState!.save();
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery
        .of(context)
        .size;
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
                  children: [
                    const SignupImagewithText(), // 이미지와 signup 타이틀
                    Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          LoginTextFormfield(
                            validator: (value) {
                              if (value!.isEmpty || value.length < 2) {
                                return '        2자리 이상 입력해주세요';
                              }
                              return null;
                            },
                            onChanged: (value) {
                              userName = value;
                            },
                            onSaved: (value) {
                              userName = value;
                            },
                            text: 'Username',
                            icon: Icons.account_circle,
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          LoginTextFormfield(
                            validator: (value) {
                              if (value!.isEmpty || !value.contains('@')) {
                                return '        이메일 형식을 맞춰주세요';
                              }
                              return null;
                            },
                            onChanged: (value) {
                              userEmail = value;
                            },
                            onSaved: (value) {
                              userEmail = value;
                            },
                            text: 'Email',
                            icon: Icons.email_outlined,
                            keyboard: TextInputType.emailAddress,
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          LoginTextFormfield(
                            validator: (value) {
                              if (value!.isEmpty || value.length < 6) {
                                return '        6자리 이상 입력해주세요';
                              }
                              return null;
                            },
                            onChanged: (value) {
                              userPassword = value;
                            },
                            onSaved: (value) {
                              userPassword = value;
                            },
                            text: 'Password',
                            icon: Icons.lock_open_rounded,
                            obscureText: true,
                          ),
                          const SizedBox(
                            height: 30,
                          ),
                        ],
                      ),
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
                    onPressed: () async{
                      _tryValidation();
                      try{
                        final newUser = await _authentication.createUserWithEmailAndPassword(
                            email: userEmail, password: userPassword);
                        if(newUser.user != null) {
                          Get.snackbar('LECO', '회원가입이 완료되었습니다!',
                              backgroundColor: Colors.white,
                            duration: const Duration(seconds: 2),);
                          Get.to(()=>LoginScreen());
                        }
                      }catch(e){
                        print(e);
                        Get.snackbar('LECO', '회원가입 형식을 확인해주세요!', backgroundColor: Colors.white,
                          duration: const Duration(seconds: 2),);
                      }
                      // print(userName);
                      // print(userEmail);
                      // print(userPassword);
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
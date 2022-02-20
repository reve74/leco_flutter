import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:leco_flutter/constraints.dart';
import 'package:leco_flutter/screens/login/signup_screen.dart';
import 'package:leco_flutter/screens/product/test.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'components/login_textformfield.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _authentication = FirebaseAuth.instance;
  String userName = '';
  String userEmail = '';
  String userPassword = '';
  bool showSpinner = false;

  void _tryValidation() {
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
      body: ModalProgressHUD(
        inAsyncCall: showSpinner,
        child: SafeArea(
          child: GestureDetector(
            onTap: () {
              FocusScope.of(context).unfocus();
            },
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: double.infinity,
                        height: height * 0.4,
                        child: ClipRRect(
                          borderRadius: const BorderRadius.only(
                            bottomLeft: Radius.circular(30),
                            bottomRight: Radius.circular(30),
                          ),
                          child: Image.asset(
                            'images/login_img.jpg',
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 10),
                        child: const Text(
                          'Welcome to LECO',
                          style: TextStyle(
                              fontSize: 30,
                              fontWeight: FontWeight.bold,
                              color: Colors.blueAccent),
                        ),
                      ),
                      Form(
                        key: _formKey,
                        child: Column(
                          children: [
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
                      onPressed: () async {
                        setState(() {
                          showSpinner = true;
                        });
                        _tryValidation();
                        try {
                          final newUser =
                              await _authentication.signInWithEmailAndPassword(
                                  email: userEmail, password: userPassword);


                          if (newUser.user != null) {
                            Get.snackbar(
                              'LECO',
                              '로그인이 완료되었습니다!',
                              backgroundColor: Colors.white,
                              duration: const Duration(seconds: 2),
                            );
                            setState(() {
                              showSpinner = false;
                            });
                            Get.to(() => Test());
                          }
                        } catch (e) {
                          print(e);
                          setState(() {
                            showSpinner = false;
                          });
                          Get.snackbar(
                            'LECO',
                            '이메일 및 비밀번호를 확인해 주세요!',
                            backgroundColor: Colors.white,
                            duration: const Duration(seconds: 2),
                          );
                        }
                      },
                      child: const Text(
                        'Sign in',
                        style: TextStyle(
                          fontSize: 25,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.all(kDefaultPadding),
                    padding: const EdgeInsets.all(kDefaultPadding),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          'Don\'t have an account?  ',
                          style: TextStyle(
                            fontSize: 15,
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            Get.to(() => SignupScreen());
                          },
                          child: const Text(
                            'Create',
                            style: TextStyle(
                                fontSize: 15, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

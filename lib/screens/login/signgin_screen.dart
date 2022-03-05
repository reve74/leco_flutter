import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:leco_flutter/controller/auth_controller.dart';
import 'package:leco_flutter/controller/user_controller.dart';
import 'package:leco_flutter/screens/login/signup_screen.dart';
import 'package:leco_flutter/screens/main/app.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'components/login_textformfield.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({Key? key}) : super(key: key);

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final userController = Get.put(UserController());

  final _formKey = GlobalKey<FormState>();
  final _authentication = FirebaseAuth.instance;

  final email = TextEditingController();
  final password = TextEditingController();
  bool showSpinner = false;

  void _tryValidation() {
    final isValid = _formKey.currentState!.validate();
    print(isValid);
    if (isValid) {
      _formKey.currentState!.save();
    }
  } // validation 체크

  // void _trySignin() async {
  //   try {
  //     final newUser = await _authentication.signInWithEmailAndPassword(
  //         email: email, password: password);
  //
  //     if (newUser.user != null) {
  //       Get.snackbar(
  //         'LECO',
  //         '로그인이 완료되었습니다!',
  //         backgroundColor: Colors.white,
  //         duration: const Duration(seconds: 2),
  //       );
  //       setState(() {
  //         showSpinner = false;
  //       });
  //       Get.to(() => App());
  //     }
  //   } on FirebaseAuthException catch (e) {
  //     print(e);
  //     setState(() {
  //       showSpinner = false;
  //     });
  //     Get.snackbar(
  //       'LECO',
  //       '이메일 및 비밀번호를 확인해 주세요!',
  //       backgroundColor: Colors.white,
  //       duration: const Duration(seconds: 2),
  //     );
  //   }
  // } // signin 메소드

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
                crossAxisAlignment: CrossAxisAlignment.stretch,
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
                            'assets/images/login_img.jpg',
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.symmetric(
                            horizontal: 40, vertical: 10),
                        child: const Text(
                          'LECO',
                          style: TextStyle(
                              fontSize: 30,
                              fontFamily: 'Jua',
                              fontWeight: FontWeight.bold,
                              color: Colors.black),
                        ),
                      ),
                      Form(
                        key: _formKey,
                        child: Column(
                          children: [
                            LoginTextFormfield(
                              controller: email,
                              validator: (value) {
                                if (value!.isEmpty || !value.contains('@')) {
                                  return '        이메일 형식을 맞춰주세요';
                                }
                                return null;
                              },
                              // onChanged: (value) {
                              //   email = value;
                              // },
                              // onSaved: (value) {
                              //   email = value;
                              // },
                              hint: '이메일',
                              icon: Icons.email_outlined,
                              keyboard: TextInputType.emailAddress,
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            LoginTextFormfield(
                              controller: password,
                              validator: (value) {
                                if (value!.isEmpty || value.length < 6) {
                                  return '        6자리 이상 입력해주세요';
                                }
                                return null;
                              },
                              // onChanged: (value) {
                              //   password = value;
                              // },
                              // onSaved: (value) {
                              //   password = value;
                              // },
                              hint: '비밀번호',
                              icon: Icons.lock_open_rounded,
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
                    padding: const EdgeInsets.symmetric(horizontal: 30),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: Colors.yellow,
                        elevation: 0.0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                      onPressed: () {
                        setState(() {
                          showSpinner = true;
                        });
                        _tryValidation();
                        UserController.to.login(email.text.trim(), password.text.trim());
                      },
                      child: const Text(
                        '로그인',
                        style: TextStyle(
                          fontFamily: 'Jua',
                          fontSize: 25,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 10,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      GestureDetector(
                        onTap: () {
                          userController.signInWithGoogle();
                          print('구글로그인');
                          // Get.to(() => App);
                        },
                        child: Image.asset(
                          'assets/images/google.png',
                          width: 50,
                          height: 50,
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      GestureDetector(
                        onTap: () {
                          Get.to(() => App);
                        },
                        child: Image.asset(
                          'assets/images/facebook.png',
                          width: 50,
                          height: 50,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        '계정이 없으신가요? ',
                        style: TextStyle(
                          fontFamily: 'Jua',
                          fontSize: 15,
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          Get.to(() => const SignupScreen());
                        },
                        child: const Text(
                          '가입하기',
                          style: TextStyle(
                            color: Colors.black,
                            fontFamily: 'Jua',
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
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

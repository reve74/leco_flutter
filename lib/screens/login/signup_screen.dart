import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:leco_flutter/controller/user_controller.dart';
import 'package:leco_flutter/screens/login/components/signupimage_with_text.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
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


  final _email = TextEditingController();
  final _username = TextEditingController();
  final _password = TextEditingController();
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
                    children: [
                      SignupImagewithText(title: '회원가입', color: Colors.blueAccent), // 이미지와 signup 타이틀
                      Form(
                        key: _formKey,
                        child: Column(
                          children: [
                            LoginTextFormfield(
                              controller: _username,
                              validator: (value) {
                                if (value!.isEmpty || value.length < 2) {
                                  return '        2자리 이상 입력해주세요';
                                }
                                return null;
                              },
                              hint: '이름',
                              icon: Icons.account_circle,
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            LoginTextFormfield(
                              controller: _email,
                              validator: (value) {
                                if (value!.isEmpty || !value.contains('@')) {
                                  return '        이메일 형식을 맞춰주세요';
                                }
                                return null;
                              },
                              hint: '이메일',
                              icon: Icons.email_outlined,
                              keyboard: TextInputType.emailAddress,
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            LoginTextFormfield(
                              controller: _password,
                              validator: (value) {
                                if (value!.isEmpty || value.length < 6) {
                                  return '        6자리 이상 입력해주세요';
                                }
                                return null;
                              },
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
                        UserController.to.register(_username.text.trim(),
                            _email.text.trim(), _password.text.trim());
                        setState(() {
                          showSpinner = false;
                        });
                      },
                      child: const Text(
                        '가입하기',
                        style: TextStyle(
                          fontFamily: 'Jua',
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
      ),
    );
  }
}

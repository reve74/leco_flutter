import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:leco_flutter/constraints.dart';
import 'package:leco_flutter/screens/login/signup_screen.dart';
import 'package:leco_flutter/screens/main/app.dart';
import 'package:leco_flutter/screens/main/home.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'components/login_textformfield.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({Key? key}) : super(key: key);

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final _formKey = GlobalKey<FormState>();
  final _authentication = FirebaseAuth.instance;
  String userName = '';
  String userEmail = '';
  String userPassword = '';
  bool showSpinner = false;

  Future<UserCredential> signInWithGoogle() async {
    // Trigger the authentication flow
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    if(googleUser != null) {
      print(googleUser);
    }

    // Obtain the auth details from the request
    final GoogleSignInAuthentication? googleAuth = await googleUser?.authentication;

    // Create a new credential
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );

    // Once signed in, return the UserCredential
    return await FirebaseAuth.instance.signInWithCredential(credential);
  } // 구글 로그인

  void _tryValidation() {
    final isValid = _formKey.currentState!.validate();
    print(isValid);
    if (isValid) {
      _formKey.currentState!.save();
    }
  } // validation 체크

  void _trySignin() async {
    try {
      final newUser = await _authentication.signInWithEmailAndPassword(
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
        Get.to(() => App());
      }
    } on FirebaseAuthException catch (e) {
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
  } // signin 메소드

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
                            'assets/images/login_img.jpg',
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
                  SizedBox(
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
                        setState(() {
                          showSpinner = true;
                        });
                        _tryValidation();
                        _trySignin();
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
                  TextButton(
                    // 구글 로그인
                    onPressed: () {
                      signInWithGoogle();
                      Get.to(const App());
                    },
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: Image.asset(
                        'assets/images/google_login.png',
                        width: 180,
                      ),
                    ),
                  ),
                  Container(
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
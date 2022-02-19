import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:leco_flutter/constraints.dart';
import 'package:leco_flutter/screens/login/signup_screen.dart';
import 'package:leco_flutter/test.dart';

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
      body: SafeArea(
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
                    Container(
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
                          Padding(
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
                                key: ValueKey(4),
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
                                  userEmail = value!;
                                },
                                keyboardType: TextInputType.emailAddress,
                                decoration: const InputDecoration(
                                  prefixIcon: Icon(
                                    Icons.email_outlined,
                                    color: Colors.orangeAccent,
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Colors.orange,
                                    ),
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(35.0),
                                    ),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Colors.orange,
                                    ),
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(35.0),
                                    ),
                                  ),
                                  hintText: 'Email',
                                  hintStyle: TextStyle(
                                    color: Colors.black38,
                                    fontSize: 14,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          // LoginTextField(
                          //   icon: Icons.lock_open_rounded,
                          //   text: 'Password',
                          // ),
                          Padding(
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
                                obscureText: true,
                                key: ValueKey(5),
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
                                  userPassword = value!;
                                },
                                decoration: const InputDecoration(
                                  prefixIcon: Icon(
                                    Icons.lock_open_rounded,
                                    color: Colors.orangeAccent,
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Colors.orange,
                                    ),
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(35.0),
                                    ),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Colors.orange,
                                    ),
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(35.0),
                                    ),
                                  ),
                                  hintText: 'Password',
                                  hintStyle: TextStyle(
                                    color: Colors.black38,
                                    fontSize: 14,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 30,
                          ),
                        ],
                      ),
                    ),
                    // const SizedBox(
                    //   height: 10,
                    // ),
                    // const LoginTextField(
                    //   icon: Icons.email_outlined,
                    //   text: 'Email',
                    //   keyboard: TextInputType.emailAddress,
                    // ),
                    // const SizedBox(
                    //   height: kDefaultPadding / 2,
                    // ),
                    // const LoginTextField(
                    //   icon: Icons.lock_open_rounded,
                    //   text: 'Password',
                    // ),
                    // const SizedBox(
                    //   height: 30,
                    // ),
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
                      _tryValidation();
                      try {
                        final newUser =
                            await _authentication.signInWithEmailAndPassword(
                                email: userEmail, password: userPassword);
                        if(newUser.user != null) {
                          Get.snackbar('LECO', '로그인이 완료되었습니다!',
                              backgroundColor: Colors.white);
                          Get.to(()=>Test());
                        }
                      } catch (e) {
                        print(e);
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
                  margin: EdgeInsets.all(kDefaultPadding),
                  padding: EdgeInsets.all(kDefaultPadding),
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
    );
  }
}

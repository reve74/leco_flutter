import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:leco_flutter/constraints.dart';
import 'package:leco_flutter/screens/login/components/signupimage_with_text.dart';
import 'package:leco_flutter/screens/login/login_screen.dart';
import 'package:leco_flutter/test.dart';
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
                    SignupImagewithText(), // 이미지와 signup 타이틀
                    // LoginTextField(
                    //   icon: Icons.account_circle,
                    //   text: 'Username',
                    //   key: _formKey,
                    // ),
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
                                key: ValueKey(1),
                                validator: (value) {
                                  if (value!.isEmpty || value.length < 4) {
                                    return '        4글자 이상 입력해주세요';
                                  }
                                  return null;
                                },
                                onChanged: (value) {
                                  userName = value;
                                },
                                onSaved: (value) {
                                  userName = value!;
                                },
                                decoration: const InputDecoration(
                                  prefixIcon: Icon(
                                    Icons.account_circle,
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
                                  hintText: 'username',
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
                          //   icon: Icons.email_outlined,
                          //   text: 'Email',
                          //   keyboard: TextInputType.emailAddress,
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
                                key: ValueKey(2),
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
                                key: ValueKey(3),
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
                              backgroundColor: Colors.white);
                          Get.to(()=>LoginScreen());
                        }
                      }catch(e){
                        print(e);
                        Get.snackbar('LECO', '회원가입 형식을 확인해주세요!', backgroundColor: Colors.white);
                      }


                      print(userName);
                      print(userEmail);
                      print(userPassword);
                      // Get.snackbar('LECO', '로그인이 완료되었습니다!',
                      //     backgroundColor: Colors.white);
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
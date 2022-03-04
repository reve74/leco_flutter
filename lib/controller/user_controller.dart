import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:leco_flutter/settings/firebase.dart';

class UserController extends GetxController {
  static UserController get to => Get.find();


  Future<void> login(String email, String password) async{
    final newUser = await auth.signInWithEmailAndPassword(
        email: email, password: password);
  }

  Future<UserCredential> signInWithGoogle() async { // 구글 로그인
    // Trigger the authentication flow
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    if (googleUser != null) {
      print(googleUser);
    }

    // Obtain the auth details from the request
    final GoogleSignInAuthentication? googleAuth =
    await googleUser?.authentication;

    // Create a new credential
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );

    // Once signed in, return the UserCredential
    return await FirebaseAuth.instance.signInWithCredential(credential);
  }
}
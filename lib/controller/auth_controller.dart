import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:leco_flutter/model/user.dart';
import 'package:leco_flutter/screens/login/signgin_screen.dart';
import 'package:leco_flutter/screens/main/app.dart';

import '../settings/firebase.dart';

class AuthController extends GetxController {
  static AuthController get to => Get.find();
  // FirebaseAuth auth = FirebaseAuth.instance;
  // FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  // late Rx<User?> _user;
  //
  //
  // @override
  // void onReady() {
  //   super.onReady();
  //   _user = Rx<User?>(auth.currentUser);
  //   _user.bindStream(auth.authStateChanges());
  //   ever(_user, _initialScreen);
  // }

  // _initialScreen(User? user) {
  //   if (user == null) {
  //     print('longin page');
  //     Get.offAll(() => SignInScreen());
  //   } else {
  //     Get.off(() => App());
  //   }
  // }

  // Sign out
  Future<void> signOut() {
    return auth.signOut();
  }

  Rxn<User> firebaseUser = Rxn<User>();
  Rxn<UserModel> firestoreUser = Rxn<UserModel>();
  RxBool isLoggedIn = false.obs;

  @override
  void onReady() {
    // TODO: implement onReady
    super.onReady();
    //run every time auth state changes
    ever(firebaseUser, handleAuthChanged);
    firebaseUser.bindStream(user);
  }

  handleAuthChanged(_firebaseUser) async {
    //get user data from firestore
    if (_firebaseUser?.uid != null) {
      firestoreUser.bindStream(streamFirestoreUser());
    }
    if (_firebaseUser == null) {
      Get.offAll(() => SignInScreen());
    } else {
      Get.offAll(() => App());
    }
  }


  // Firebase user one-time fetch
  Future<User> get getUser async => auth.currentUser!;

  // Firebase user a realtime stream
  Stream<User?> get user => auth.authStateChanges();

  //Streams the firestore user from the firestore collection
  Stream<UserModel> streamFirestoreUser() {
    print('streamFirestoreUser()');

    return firebaseFirestore
        .doc('/users/${firebaseUser.value!.uid}')
        .snapshots()
        .map((snapshot) => UserModel.fromMap(snapshot.data()!));
  }

  //get the firestore user from the firestore collection
  Future<UserModel> getFirestoreUser() {
    return firebaseFirestore
        .doc('/users/${firebaseUser.value!.uid}')
        .get()
        .then(
            (documentSnapshot) => UserModel.fromMap(documentSnapshot.data()!));
  }

}

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:toastification/toastification.dart';
import '../../services/auth/auth_services.dart';
import '../../utils/routes/app_routes.dart';
import '../model/user_model.dart';
import '../services/firestore_services.dart';

class SignInController extends GetxController {
  RxBool isPasswordVisible = true.obs;

  void changePasswordVisibility() {
    isPasswordVisible.value = !isPasswordVisible.value;
  }

  void login(email, password, name) async {
    String msg = await AuthServices.instance.login(email, password);
    if (msg == "Success") {
      FirestoreServices.firestoreServices.addUser(
        model: UserModel(
          token: await FirebaseMessaging.instance.getToken() ?? "",
          uid: AuthServices.instance.currentUser!.uid ?? "",
          name: name ?? "",
          email: email ?? "",
          password: password,
          image: "https://www.pngmart.com/files/23/Profile-PNG-Photo.png",
          imageIndex: 0,
        ),
      );
      toastification.show(
        title: const Text("Success"),
        description: const Text("Login successfully"),
        type: ToastificationType.success,
        style: ToastificationStyle.fillColored,
        autoCloseDuration: const Duration(seconds: 2),
      );
      Get.offNamed(GetPages.home);
      // Get.offNamed(GetPages.otpVerification);
    } else {
      toastification.show(
        autoCloseDuration: const Duration(seconds: 2),
        title: const Text("Error"),
        description: Text(msg),
        type: ToastificationType.error,
      );
    }
  }

  Future<void> signUpWithGoogle() async {
    await AuthServices.instance.loginWithGoogle();
    Get.offNamed(GetPages.home);
  }

  Future<void> loginWithGoogle() async {
    String msg = await AuthServices.instance.loginWithGoogle();
    if (msg == "Success") {
      Get.offNamed(GetPages.home);
      var user = AuthServices.instance.currentUser;
      if (user != null) {
        FirestoreServices.firestoreServices.addUser(
          model: UserModel(
            token: await FirebaseMessaging.instance.getToken() ?? "",
            uid: user.uid ?? "",
            name: user.displayName ?? "",
            email: user.email ?? "",
            password: "",
            image: user.photoURL ?? "",
            imageIndex: 0,
          ),
        );
      }
    }
  }

  // void loginWithAnonymous() async {
  //   User? user = await AuthServices..anonymousLogin();
  //   if (user != null) {
  //     toastification.show(
  //       title: const Text("Success"),
  //       description: const Text("Login successfully"),
  //       type: ToastificationType.success,
  //       style: ToastificationStyle.fillColored,
  //       autoCloseDuration: const Duration(seconds: 2),
  //     );
  //     Get.offNamed(GetPages.home);
  //   }
  // }

  // Future<void> CurrentUser() async {
  //   User? user = AuthServices.authServices.currentUser!;
  //   if (user != null) {
  //     toastification.show(
  //       title: const Text("Success"),
  //       description: const Text("Login successfully"),
  //       type: ToastificationType.success,
  //       style: ToastificationStyle.fillColored,
  //       autoCloseDuration: const Duration(seconds: 2),
  //     );
  //     // Get.offNamed(GetPages.home);
  //   }
  // }

  void signOut() {
    AuthServices.instance.signOut();
    Get.offNamed(GetPages.signIn);
  }
}

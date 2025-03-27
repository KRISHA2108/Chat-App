import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:toastification/toastification.dart';
import '../../services/auth/auth_services.dart';
import '../utils/routes/app_routes.dart';

class SignUpController extends GetxController {
  Future<void> signUp({required String email, required String password}) async {
    User? user =
        await AuthServices.instance.signUp(email: email, password: password);

    if (user != null) {
      Get.offNamed(GetPages.signIn);
      toastification.show(
        title: const Text("Sign Up Successfully"),
        description: Text("Welcome ${user.email}"),
        type: ToastificationType.success,
        style: ToastificationStyle.fillColored,
        autoCloseDuration: const Duration(seconds: 10),
      );
    } else {
      toastification.show(
        title: const Text("Sign Up Failed"),
        description: const Text("Please Try Again"),
        type: ToastificationType.error,
        style: ToastificationStyle.fillColored,
        autoCloseDuration: const Duration(seconds: 1),
      );
    }
  }
}

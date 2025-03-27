import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../services/auth/auth_services.dart';
import '../../utils/routes/app_routes.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Future.delayed(
      const Duration(
        seconds: 3,
      ),
      () {
        if (AuthServices.instance.currentUser != null) {
          Get.offNamed(GetPages.home);
        } else {
          Get.offNamed(GetPages.signIn);
        }
      },
      // () => Get.toNamed(GetPages.login),
    );
    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Align(
            child: Image.asset(
              'assets/images/splash.png',
              fit: BoxFit.cover,
              height: 200,
            ),
          ),
        ],
      ),
    );
  }
}

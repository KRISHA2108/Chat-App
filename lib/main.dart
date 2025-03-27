import 'package:chat_app/utils/routes/app_routes.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:toastification/toastification.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(
    const ChatApp(),
  );
}

class ChatApp extends StatelessWidget {
  const ChatApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ToastificationWrapper(
      child: GetMaterialApp(
        // home: SignInScreen(),
        debugShowCheckedModeBanner: false,
        getPages: GetPages.getPages,
        // GetPage(
        //   name: AppRoutes.signUp,
        //   page: () => const SignUp(),
        // ),
      ),
    );
  }
}

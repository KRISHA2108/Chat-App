import 'package:chat_app/screen/Login/sign_in.dart';
import 'package:chat_app/screen/chat/chat_page.dart';
import 'package:chat_app/screen/home/home_screen.dart';
import 'package:chat_app/screen/splash/splash.dart';
import 'package:chat_app/screen/wallpaper/wallpaper.dart';
import 'package:get/get.dart';
import '../../screen/setting/setting_page.dart';
import '../../screen/signUp/sign_up.dart';

class GetPages {
  static String splash = '/';
  static String signUp = '/signUp';
  static String signIn = '/signIn';
  static String home = '/home';
  static String chat = '/chat';
  static String setting = '/setting';
  static String wallpaper = '/wallpaper';

  static List<GetPage> getPages = [
    GetPage(
      name: splash,
      page: () => const SplashScreen(),
    ),
    GetPage(
      name: signUp,
      page: () => const SignUpScreen(),
    ),
    GetPage(
      name: signIn,
      page: () => const SignInScreen(),
    ),
    GetPage(
      name: home,
      page: () => const HomePage(),
    ),
    GetPage(
      name: chat,
      page: () => const ChatPage(),
    ),
    GetPage(
      name: wallpaper,
      page: () => const WallpaperPage(),
    ),
    GetPage(
      name: setting,
      page: () => const SettingPage(),
    ),
  ];
}

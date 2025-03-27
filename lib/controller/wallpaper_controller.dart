import 'package:get/get.dart';

import '../model/user_model.dart';

class WallpaperController extends GetxController {
  int currentIndex = 0;
  List images = [
    'assets/images/1.jpg',
    'assets/images/2.jpg',
    'assets/images/3.jpg',
    'assets/images/4.jpg',
    'assets/images/5.jpg',
    'assets/images/6.jpg',
    'assets/images/7.jpg',
    'assets/images/8.jpg',
    'assets/images/9.jpg',
    'assets/images/10.jpg',
    'assets/images/12.jpg',
    'assets/images/13.jpg',
    'assets/images/14.jpg',
    'assets/images/15.jpg',
    'assets/images/16.jpg',
  ];

  void changeImage(int index, UserModel user) {
    currentIndex = index;
    user.imageIndex = index;
    Get.back();
    update();
  }
}

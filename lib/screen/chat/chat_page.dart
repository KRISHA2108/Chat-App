import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../model/chat_model.dart';
import '../../../services/firestore_services.dart';
import '../../controller/chat_controller.dart';
import '../../controller/wallpaper_controller.dart';
import '../../model/user_model.dart';
import '../../services/auth/auth_services.dart';
import '../../services/notification.dart';
import '../../utils/routes/app_routes.dart';

class ChatPage extends StatelessWidget {
  const ChatPage({super.key});

  @override
  Widget build(BuildContext context) {
    UserModel user = Get.arguments;
    ChatController chatController = Get.put(ChatController());
    WallpaperController wallpaperController = Get.put(WallpaperController());
    TextEditingController messageController = TextEditingController();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
        title: Text(user.name),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.call),
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.video_camera_back_outlined),
          ),
          PopupMenuButton(
            itemBuilder: (BuildContext context) {
              return [
                PopupMenuItem(
                  child: const Text("Set WallPaper as Background"),
                  onTap: () {
                    Get.toNamed(GetPages.wallpaper, arguments: user);
                  },
                ),
              ];
            },
          ),
        ],
      ),
      body: Stack(
        children: [
          GetBuilder<WallpaperController>(
            builder: (context) {
              return Container(
                height: double.infinity,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(
                      "${wallpaperController.images[user.imageIndex]}",
                    ),
                    fit: BoxFit.cover,
                  ),
                  borderRadius: BorderRadius.circular(10),
                ),
              );
            },
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                Expanded(
                  child: StreamBuilder(
                    stream: FirestoreServices.firestoreServices.fetchChat(
                        sent: AuthServices.instance.currentUser!.email ?? '',
                        receiver: user.email),
                    builder: (context, snapshot) {
                      var data = snapshot.data;
                      var allData = data?.docs ?? [];
                      List<ChatModal> allChat = allData
                          .map((e) => ChatModal.fromMap(data: e.data()))
                          .toList();
                      return ListView.builder(
                        itemCount: allChat.length,
                        itemBuilder: (context, index) {
                          if ((allChat[index].receiver == user.email)) {
                            return Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                GestureDetector(
                                  onDoubleTap: () {
                                    FirestoreServices.firestoreServices
                                        .deleteChat(
                                      sent: AuthServices
                                              .instance.currentUser?.email ??
                                          "",
                                      receiver: user.email,
                                      id: allData[index].id,
                                    );
                                  },
                                  onLongPress: () {
                                    String msg = messageController.text =
                                        allChat[index].msg;

                                    chatController.changeUpdateValue(
                                        id: allData[index].id);
                                  },
                                  child: Container(
                                    margin: const EdgeInsets.all(7),
                                    padding: const EdgeInsets.all(7),
                                    decoration: BoxDecoration(
                                      color: Colors.black.withOpacity(0.3),
                                      borderRadius: const BorderRadius.all(
                                        Radius.circular(10),
                                      ),
                                    ),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.end,
                                      children: [
                                        Text(
                                          allChat[index].msg,
                                          style: const TextStyle(
                                            fontSize: 14,
                                            color: Colors.white,
                                          ),
                                        ),
                                        Align(
                                          alignment: Alignment.bottomRight,
                                          child: Text(
                                            "${allChat[index].time.toDate().hour}:${allChat[index].time.toDate().minute}",
                                            style: const TextStyle(
                                              fontSize: 9,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.white,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                Align(
                                  alignment: Alignment.bottomLeft,
                                  child: Text(
                                    allChat[index].status == "seen"
                                        ? "seen"
                                        : "send",
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 10,
                                    ),
                                  ),
                                ),
                              ],
                            );
                          } else {
                            FirestoreServices.firestoreServices.seenChat(
                              id: allData[index].id,
                              receiver: user.email,
                              sent: AuthServices.instance.currentUser!.email ??
                                  '',
                              selectIndex:
                                  "${wallpaperController.currentIndex}",
                            );
                            return Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                GestureDetector(
                                  onDoubleTap: () {
                                    FirestoreServices.firestoreServices
                                        .deleteChat(
                                      sent: AuthServices
                                              .instance.currentUser?.email ??
                                          "",
                                      receiver: user.email,
                                      id: allData[index].id,
                                    );
                                  },
                                  child: Container(
                                    padding: const EdgeInsets.all(10),
                                    margin: const EdgeInsets.all(5),
                                    decoration: BoxDecoration(
                                      color: Colors.grey.withOpacity(0.3),
                                      borderRadius: const BorderRadius.all(
                                        Radius.circular(10),
                                      ),
                                    ),
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.end,
                                      children: [
                                        Text(
                                          allChat[index].msg,
                                          style: const TextStyle(
                                            color: Colors.white,
                                          ),
                                        ),
                                        Align(
                                          alignment: Alignment.bottomLeft,
                                          child: Text(
                                            "${allChat[index].time.toDate().hour}:${allChat[index].time.toDate().minute}",
                                            style: const TextStyle(
                                              fontSize: 10,
                                              color: Colors.white,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            );
                          }
                        },
                      );
                    },
                  ),
                ),
                Row(
                  children: [
                    Expanded(
                      child: TextField(
                        style: const TextStyle(
                          color: Colors.white,
                        ),
                        controller: messageController,
                        decoration: const InputDecoration(
                          focusColor: Colors.white,
                          focusedBorder: OutlineInputBorder(),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(10),
                            ),
                          ),
                          labelText: 'Message...',
                          labelStyle: TextStyle(
                            color: Colors.white54,
                          ),
                        ),
                      ),
                    ),
                    GetBuilder<ChatController>(
                      builder: (context) {
                        return IconButton(
                          onPressed: () async {
                            String msg = messageController.text.trim();
                            if (msg.isNotEmpty) {
                              if (!chatController.isUpdate) {
                                ChatModal chatModel = ChatModal(
                                  sender: AuthServices
                                          .instance.currentUser!.email ??
                                      '',
                                  receiver: user.email,
                                  msg: msg,
                                  selectIndex:
                                      "${wallpaperController.currentIndex}",
                                  time: Timestamp.now(),
                                  status: 'Unseen',
                                );

                                FirestoreServices.firestoreServices
                                    .sentChat(chatModel: chatModel);
                                messageController.clear();
                              } else {
                                FirestoreServices.firestoreServices.updateChat(
                                  sent: AuthServices
                                          .instance.currentUser!.email ??
                                      "",
                                  id: chatController.id,
                                  msg: messageController.text.trim(),
                                  receiver: user.email,
                                );
                                messageController.clear();
                                chatController.changeUpdateValueFalse();
                              }
                              await Notifications.notifications
                                  .sendNotification(
                                title: user.name,
                                body: msg,
                                token: user.token,
                              );
                              messageController.clear();
                            }
                          },
                          icon: const Icon(
                            Icons.send,
                            color: Colors.white54,
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

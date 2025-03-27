import 'package:chat_app/services/auth/auth_services.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../model/user_model.dart';
import '../../../services/firestore_services.dart';
import '../../../utils/routes/app_routes.dart';

class ChatWidget extends StatelessWidget {
  const ChatWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: StreamBuilder(
              stream: FirestoreServices.firestoreServices.fetchUser(),
              builder: (context, snapshot) {
                var data = snapshot.data;
                var allData = data?.docs ?? [];
                List<UserModel> allUsers = allData
                    .map((e) => UserModel.fromMap(data: e.data()))
                    .toList();
                return ListView.builder(
                  itemCount: allUsers.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      onTap: () {
                        Get.toNamed(
                          GetPages.chat,
                          arguments: allUsers[index],
                        );
                      },
                      onLongPress: () {
                        FirestoreServices.firestoreServices
                            .deleteUser(email: allUsers[index].email);
                      },
                      leading: CircleAvatar(
                        backgroundImage: NetworkImage(allUsers[index].image),
                      ),
                      title: Text(
                        allUsers[index].name,
                        style: const TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 18,
                          color: Colors.white,
                        ),
                      ),
                      subtitle: Text(
                        allUsers[index].email,
                        style: const TextStyle(
                          fontSize: 14,
                          color: Colors.grey,
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

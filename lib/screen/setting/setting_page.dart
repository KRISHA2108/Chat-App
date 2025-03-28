// import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controller/sign_in_controller.dart';
import '../../model/user_model.dart';
import '../../services/firestore_services.dart';

SignInController loginController = Get.put(SignInController());

class SettingPage extends StatelessWidget {
  const SettingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black38,
      appBar: AppBar(
        backgroundColor: Colors.black54,
        foregroundColor: Colors.white,
        title: const Text('Settings'),
        leading: const BackButton(),
      ),
      body: ListView(
        children: [
          _buildProfileTile(),
          const Divider(),
          _buildSettingsOption(
            Icons.key,
            'Account',
            'Security notifications, change number',
          ),
          _buildSettingsOption(
              Icons.lock, 'Privacy', 'Block contacts, disappearing messages'),
          _buildSettingsOption(
            Icons.person_outline_sharp,
            'Avatar',
            'Create, edit, profile photo',
          ),
          _buildSettingsOption(Icons.list, 'Lists', 'Manage people and groups'),
          ListTile(
            leading: const Icon(
              Icons.logout_outlined,
              color: Colors.grey,
            ),
            title: const Text(
              'Logout',
              style: TextStyle(color: Colors.white),
            ),
            onTap: () {
              loginController.signOut();
            },
          ),
        ],
      ),
    );
  }

  Widget _buildProfileTile() {
    return Expanded(
      child: FutureBuilder(
        future: FirestoreServices.firestoreServices.fetchSingleUser(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(
              child: Text("Error : ${snapshot.error}"),
            );
          } else if (snapshot.hasData) {
            DocumentSnapshot<Map<String, dynamic>>? data = snapshot.data;
            UserModel user = UserModel.fromMap(data: data?.data() ?? {});
            return Column(
              children: [
                const SizedBox(
                  height: 20,
                ),
                CircleAvatar(
                  backgroundImage: NetworkImage(
                    user.image,
                  ),
                  radius: 70,
                ),
                const SizedBox(height: 10),
                Text(user.name,
                    style: const TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold)),
                Text(
                  user.email,
                  style: const TextStyle(color: Colors.grey),
                ),
              ],
            );
          }
          return Container();
        },
      ),
    );
  }

  Widget _buildSettingsOption(
    IconData icon,
    String title,
    String subtitle,
  ) {
    return ListTile(
      leading: Icon(icon, color: Colors.grey),
      title: Text(
        title,
        style: const TextStyle(
          fontSize: 16,
          color: Colors.white,
        ),
      ),
      subtitle: Text(
        subtitle,
        style: const TextStyle(fontSize: 12, color: Colors.grey),
      ),
      onTap: () {},
    );
  }
}

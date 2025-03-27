import 'package:chat_app/screen/home/widget/chat_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../utils/routes/app_routes.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});
  Widget openPopUp() {
    return PopupMenuButton(
      itemBuilder: (context) {
        return List.generate(
          3,
          (index) => const PopupMenuItem(
            child: Text('Setting'),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        appBar: AppBar(
          foregroundColor: Colors.white,
          actions: [
            const Icon(
              Icons.search,
              color: Colors.white,
            ),
            PopupMenuButton(
              color: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(
                  20,
                ),
              ),
              onSelected: (value) {
                Get.toNamed(GetPages.setting);
              },
              itemBuilder: (context) {
                return [
                  const PopupMenuItem(
                    child: Text(
                      'New Group',
                    ),
                  ),
                  const PopupMenuItem(
                    child: Text(
                      'New Broadcast',
                    ),
                  ),
                  const PopupMenuItem(
                    child: Text(
                      'Linked Devices',
                    ),
                  ),
                  const PopupMenuItem(
                    child: Text(
                      'Starred Messages',
                    ),
                  ),
                  const PopupMenuItem(
                    child: Text(
                      'Payments',
                    ),
                  ),
                  PopupMenuItem(
                    onTap: () {
                      Get.toNamed(GetPages.setting);
                    },
                    child: const Text(
                      'Settings',
                    ),
                  ),
                ];
              },
            ),
          ],
          backgroundColor: Colors.teal.shade800,
          title: const Text(
            'WhatsApp',
            style: TextStyle(
              color: Colors.white,
            ),
          ),
          bottom: const TabBar(
            indicatorSize: TabBarIndicatorSize.tab,
            indicatorColor: Colors.white,
            tabs: [
              Tab(
                child: Text(
                  'CHATS',
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
              Tab(
                child: Text(
                  'STATUS',
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
              Tab(
                child: Text(
                  'CALLS',
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
            ],
            labelColor: Colors.black,
          ),
        ),
        backgroundColor: Colors.black,
        // ! THE DESIGNED BODY
        body: const TabBarView(
          children: [
            ChatWidget(),
            Center(
              child: Text(
                'Status feature is coming soon...',
                style: TextStyle(
                  color: Colors.white70,
                ),
              ),
            ),
            Center(
              child: Text(
                'Call feature is coming soon...',
                style: TextStyle(
                  color: Colors.white70,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

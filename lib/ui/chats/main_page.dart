import 'package:flutter/material.dart';
import 'package:gd_chat/providers/app_provider.dart';
import 'package:gd_chat/ui/chats/all_chats_screen.dart';
import 'package:gd_chat/ui/chats/all_users_screen.dart';
import 'package:provider/provider.dart';

class MainPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return DefaultTabController(
      length: 2,
      child: Consumer<AppProvider>(builder: (context, provider, x) {
        return Scaffold(
          appBar: AppBar(
            title: Text('Chat App'),
            actions: [
              IconButton(
                  onPressed: () {
                    provider.logOut();
                  },
                  icon: Icon(Icons.logout))
            ],
            bottom: TabBar(tabs: [
              Tab(
                text: 'All Users',
              ),
              Tab(
                text: 'All Chats',
              ),
            ]),
          ),
          body: TabBarView(
            children: [AllUsersScreen(), AllChatsScreen()],
          ),
        );
      }),
    );
  }
}

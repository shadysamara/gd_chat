import 'package:flutter/material.dart';
import 'package:gd_chat/helpers/router_helper.dart';
import 'package:gd_chat/providers/app_provider.dart';
import 'package:gd_chat/ui/chats/chat_messages_screen.dart';
import 'package:provider/provider.dart';

class AllUsersScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Consumer<AppProvider>(builder: (context, provider, x) {
      return Container(
        child: provider.users == null
            ? Center(
                child: CircularProgressIndicator(),
              )
            : ListView.builder(
                itemCount: provider.users!.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    onTap: () {
                      RouterHelper.routerHelper
                          .routingToSpecificWidgetWithoutPop(
                              AllChatMessagesScreen(
                        otherUser: provider.users![index],
                      ));
                    },
                    leading: CircleAvatar(
                      child: Text(provider.users![index].name[0].toUpperCase()),
                    ),
                    title: Text(provider.users![index].name),
                    subtitle: Text(provider.users![index].email),
                  );
                }),
      );
    });
  }
}

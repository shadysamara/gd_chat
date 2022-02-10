import 'package:flutter/material.dart';
import 'package:gd_chat/helpers/router_helper.dart';
import 'package:gd_chat/providers/app_provider.dart';
import 'package:gd_chat/ui/chats/chat_messages_screen.dart';
import 'package:provider/provider.dart';

class AllChatsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Consumer<AppProvider>(builder: (context, provider, x) {
      return Container(
        child: provider.allMyChats == null
            ? Center(
                child: CircularProgressIndicator(),
              )
            : provider.allMyChats!.isEmpty
                ? Center(
                    child: Text('No Chats Found'),
                  )
                : ListView.builder(
                    itemCount: provider.allMyChats!.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        onTap: () {
                          RouterHelper.routerHelper
                              .routingToSpecificWidgetWithoutPop(
                                  AllChatMessagesScreen(
                                      chat: provider.allMyChats![index]));
                        },
                        leading: CircleAvatar(
                          child: Text(provider.allMyChats![index].membersNames
                              .where(
                                  (element) => element != provider.myUser!.name)
                              .first[0]
                              .toString()
                              .toUpperCase()),
                        ),
                        title: Text(provider.allMyChats![index].membersNames
                            .where(
                                (element) => element != provider.myUser!.name)
                            .first),
                      );
                    }),
      );
    });
  }
}

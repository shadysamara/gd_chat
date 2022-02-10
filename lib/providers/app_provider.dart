import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gd_chat/helpers/router_helper.dart';
import 'package:gd_chat/models/app_user.dart';
import 'package:gd_chat/models/chat.dart';
import 'package:gd_chat/models/message.dart';
import 'package:gd_chat/repositories/auth_helper.dart';
import 'package:gd_chat/repositories/firestore_helper.dart';
import 'package:gd_chat/ui/chats/main_page.dart';
import 'package:gd_chat/ui/widgets/auth/login_screen.dart';

class AppProvider extends ChangeNotifier {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  AppUser? myUser;
  List<AppUser>? users;
  List<Chat>? allMyChats;

  registerNewUser() async {
    AppUser appUser = AppUser(
        email: emailController.text,
        password: passwordController.text,
        name: nameController.text);
    String? userId = await AuthHelper.authHelper
        .registerUsingEmailAndPassword(appUser.email, appUser.password);
    appUser.userId = userId;
    FirestoreHelper.firestoreHelper.registerUser(appUser);
    RouterHelper.routerHelper.routingToSpecificWidgetWithPop(MainPage());
  }

  loginUser() async {
    String? userId = await AuthHelper.authHelper.loginUsingEmailAndPassword(
        emailController.text, passwordController.text);
    if (userId != null) {
      RouterHelper.routerHelper.routingToSpecificWidgetWithPop(MainPage());
    }
  }

  getUsers() async {
    List<QueryDocumentSnapshot<Map<String, dynamic>>> queries =
        await FirestoreHelper.firestoreHelper.getUsersFromFirestore();
    List<AppUser> userList =
        queries.map((e) => AppUser.fromJson(e.data())).toList();
    String myId = FirebaseAuth.instance.currentUser!.uid;

    this.myUser = userList.where((element) => element.userId == myId).first;
    userList.removeWhere((element) => element.userId == myId);
    this.users = userList;
    notifyListeners();
  }

  logOut() async {
    await AuthHelper.authHelper.signOut();
    RouterHelper.routerHelper.routingToSpecificWidgetWithPop(LoginScreen());
  }

  getChats() async {
    List<QueryDocumentSnapshot<Map<String, dynamic>>> list =
        await FirestoreHelper.firestoreHelper.getChats();
    List<Chat> chats = list.map((e) {
      String chatId = e.id;
      Map<String, dynamic> map = e.data();
      map['chatId'] = chatId;
      return Chat.fromJson(map);
    }).toList();
    this.allMyChats = chats;
    notifyListeners();
  }

  sendMessage(Message message, [AppUser? otherUser]) async {
    String chatId = message.chatId;
    bool x =
        await FirestoreHelper.firestoreHelper.checkCollectionExists(chatId);
    if (otherUser == null) {
      FirestoreHelper.firestoreHelper.sendMessage(message);
    } else {
      if (!x) {
        await createChat(chatId, otherUser);
        FirestoreHelper.firestoreHelper.sendMessage(message);
      } else {
        FirestoreHelper.firestoreHelper.sendMessage(message);
      }
    }
  }

  createChat(String chatId, AppUser otherUser) async {
    FirestoreHelper.firestoreHelper.createChat(chatId, this.myUser!, otherUser);
  }

  getChatMessages(String chatId) async {}
}

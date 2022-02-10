import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:gd_chat/helpers/router_helper.dart';
import 'package:gd_chat/providers/app_provider.dart';
import 'package:gd_chat/ui/chats/main_page.dart';
import 'package:gd_chat/ui/widgets/auth/login_screen.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(ChangeNotifierProvider<AppProvider>(
    create: (context) {
      return AppProvider();
    },
    child: MaterialApp(
      navigatorKey: RouterHelper.routerHelper.routerKey,
      home: SplachScreen(),
    ),
  ));
}

class SplachScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Future.delayed(Duration(seconds: 2)).then((v) {
      if (FirebaseAuth.instance.currentUser == null) {
        RouterHelper.routerHelper.routingToSpecificWidgetWithPop(LoginScreen());
      } else {
        Provider.of<AppProvider>(context, listen: false).getUsers();
        Provider.of<AppProvider>(context, listen: false).getChats();
        RouterHelper.routerHelper.routingToSpecificWidgetWithPop(MainPage());
      }
    });
    // TODO: implement build
    return Scaffold(
      body: Center(
        child: Icon(Icons.chat),
      ),
    );
  }
}

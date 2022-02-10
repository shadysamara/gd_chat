import 'package:flutter/material.dart';
import 'package:gd_chat/helpers/router_helper.dart';
import 'package:gd_chat/providers/app_provider.dart';
import 'package:gd_chat/ui/widgets/auth/register_screen.dart';
import 'package:gd_chat/ui/widgets/custom_button.dart';

import 'package:provider/provider.dart';

class LoginScreen extends StatelessWidget {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text('Login Screen'),
      ),
      body: Consumer<AppProvider>(builder: (context, provider, x) {
        return Container(
          margin: EdgeInsets.symmetric(horizontal: 10),
          child: Column(
            children: [
              SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 10,
                    ),
                    TextField(
                      decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15)),
                          label: Text('Email')),
                      controller: provider.emailController,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    TextField(
                      decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15)),
                          label: Text('Password')),
                      controller: provider.passwordController,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                  ],
                ),
              ),
              Spacer(),
              CustomButton(
                title: 'Login',
                function: () {
                  provider.loginUser();
                },
              ),
              SizedBox(
                height: 10,
              ),
              TextButton(
                  onPressed: () {
                    RouterHelper.routerHelper
                        .routingToSpecificWidget(RegisterScreen());
                  },
                  child: Text('Create account'))
            ],
          ),
        );
      }),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:gd_chat/helpers/router_helper.dart';
import 'package:gd_chat/providers/app_provider.dart';
import 'package:gd_chat/ui/widgets/auth/login_screen.dart';
import 'package:gd_chat/ui/widgets/custom_button.dart';

import 'package:provider/provider.dart';

class RegisterScreen extends StatelessWidget {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text('Register Screen'),
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
                          label: Text('Name')),
                      controller: provider.nameController,
                    ),
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
                title: 'Register',
                function: () {
                  provider.registerNewUser();
                },
              ),
              SizedBox(
                height: 10,
              ),
              TextButton(
                  onPressed: () {
                    RouterHelper.routerHelper
                        .routingToSpecificWidget(LoginScreen());
                  },
                  child: Text('Have already account'))
            ],
          ),
        );
      }),
    );
  }
}

import 'package:admin/Helpers/constants.dart';
import 'package:admin/controllers/login/login_controller.dart';
import 'package:admin/screens/dashboard/dashboard_screen.dart';
import 'package:admin/screens/main/main_screen.dart';
import 'package:admin/screens/signup/signup_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../constants.dart';

void signupClicked() {
  Get.to(SignupPage());
}

class LoginGuts extends StatelessWidget {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  final controller = Get.put(LoginController());

  void loginClicked() {
    controller.login(emailController.text, passwordController.text);
  }

  @override
  Widget build(BuildContext context) {
    controller.loginStatus.listen((loggedInStatus) {
      if (loggedInStatus == LoginStatus.authenticated) {
        Get.toNamed('/dashboard');
      }
    });

    return GetX<LoginController>(builder: (controller) {
      return SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(defaultPadding),
          child: Column(
            children: [
              SizedBox(height: defaultPadding),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    flex: 5,
                    child: Column(
                      children: [
                        SingleChildScrollView(
                          child: Column(
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.only(top: 10.0),
                                child: Center(
                                  child: Container(
                                      width: 200,
                                      height: 150,
                                      /*decoration: BoxDecoration(
                          color: Colors.red,
                          borderRadius: BorderRadius.circular(50.0)),*/
                                      child: Image.asset(
                                          'assets/images/flat_circle.png')),
                                ),
                              ),
                              Padding(
                                //padding: const EdgeInsets.only(left:15.0,right: 15.0,top:0,bottom: 0),
                                padding: EdgeInsets.symmetric(
                                    horizontal: 15, vertical: 10),

                                child: SizedBox(
                                  width: 500,
                                  child: TextField(
                                    controller: emailController,
                                    decoration: InputDecoration(
                                        fillColor: Colors.white,
                                        hoverColor: Colors.white,
                                        border: OutlineInputBorder(),
                                        labelText: 'Email',
                                        hintText:
                                            'Enter valid email id as abc@gmail.com'),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 15, vertical: 10),
                                child: SizedBox(
                                  width: 500,
                                  child: TextField(
                                    controller: passwordController,
                                    obscureText: true,
                                    decoration: InputDecoration(
                                        border: OutlineInputBorder(),
                                        labelText: 'Password',
                                        hintText: 'Enter secure password'),
                                  ),
                                ),
                              ),
                              TextButton(
                                onPressed: () {
                                  //TODO FORGOT PASSWORD SCREEN GOES HERE
                                },
                                child: Text(
                                  'Forgot Password',
                                  style: TextStyle(
                                      color: Colors.orange, fontSize: 15),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(10),
                                child: SizedBox(
                                    height: 50, //height of button
                                    width: 500,
                                    //width of button
                                    child: ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                        primary: Colors.orange, // background
                                        onPrimary: Colors.orange, // foreground
                                      ),
                                      onPressed: loginClicked,
                                      child: Text('Sign In',
                                          style: TextStyle(
                                              fontSize: 15.0,
                                              color: Colors.white)),
                                    )),
                              ),
                              if (controller.loginStatus.value ==
                                  LoginStatus.loading)
                                Padding(
                                  padding: const EdgeInsets.all(30.0),
                                  child: spinkit,
                                ),
                              SizedBox(
                                height: 10,
                              ),
                              TextButton(
                                  onPressed: signupClicked,
                                  child: Text('Dont have an account? Signup',
                                      style: TextStyle(
                                          fontSize: 15.0,
                                          color: Colors.orange)))
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      );
    });
  }
}

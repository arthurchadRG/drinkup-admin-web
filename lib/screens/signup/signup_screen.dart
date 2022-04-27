import 'package:admin/Helpers/constants.dart';
import 'package:admin/controllers/signup/signup_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SignupPage extends StatelessWidget {
  SignupPage({Key? key}) : super(key: key);

  final identifierController = TextEditingController();
  final secretController = TextEditingController();
  final businessNameController = TextEditingController();

  final controller = Get.put(SignupController());

  void _loginUser() {}

  void _signupPressed() {
    controller.signup(identifierController.text, secretController.text,
        businessNameController.text);
    // print(FlutterGooglePlacesWeb.value['streetAddress']);
  }

  @override
  Widget build(BuildContext context) {
    controller.signupStatus.listen((signupStatus) {
      if (signupStatus == SignupStatus.success) {
        Get.back();
      }
    });
    return GetX<SignupController>(builder: (controller) {
      return Scaffold(
          body: Stack(
        children: <Widget>[
          Container(
              // ignore: prefer_const_constructors

              ),
          SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: 250,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const <Widget>[
                      Image(
                          width: 120,
                          image: AssetImage("assets/images/flat_circle.png")),
                    ],
                  ),
                ),
                Container(
                    width: MediaQuery.of(context).size.width,
                    height: 2,
                    color: Colors.orange),
                SizedBox(
                  width: 500,
                  child: Container(
                    padding: const EdgeInsets.all(20),
                    child: TextField(
                        controller: businessNameController,
                        style: const TextStyle(color: Colors.white),
                        decoration: InputDecoration(
                          errorBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.white),
                          ),
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.white),
                          ),
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.white),
                          ),
                          hintStyle: TextStyle(color: Colors.white),

                          contentPadding: EdgeInsets.only(
                              top: 20,
                              left: 20,
                              right: 20), // add padding to adjust text
                          isDense: true,
                          hintText: "Establishment Name",

                          prefixIcon: Padding(
                            padding: EdgeInsets.only(
                                top: 15), // add padding to adjust icon
                            child: Icon(Icons.person, color: Colors.white),
                          ),
                        )),
                  ),
                ),
                SizedBox(
                  width: 500,
                  child: Container(
                    padding: const EdgeInsets.all(20),
                    child: TextField(
                        controller: identifierController,
                        style: const TextStyle(color: Colors.white),
                        decoration: InputDecoration(
                          errorBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.white),
                          ),
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.white),
                          ),
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.white),
                          ),
                          hintStyle: TextStyle(color: Colors.white),

                          contentPadding: EdgeInsets.only(
                              top: 20,
                              left: 20,
                              right: 20), // add padding to adjust text
                          isDense: true,
                          hintText: "Email",
                          prefixIcon: Padding(
                            padding: EdgeInsets.only(
                                top: 15), // add padding to adjust icon
                            child: Icon(Icons.email, color: Colors.white),
                          ),
                        )),
                  ),
                ),
                SizedBox(
                  width: 500,
                  child: Container(
                    padding: const EdgeInsets.all(20),
                    child: TextField(
                        controller: secretController,
                        obscureText: true,
                        enableSuggestions: false,
                        autocorrect: false,
                        style: const TextStyle(color: Colors.white),
                        decoration: InputDecoration(
                          errorBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.white),
                          ),
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.white),
                          ),
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.white),
                          ),
                          hintStyle: TextStyle(color: Colors.white),

                          contentPadding: EdgeInsets.only(
                              top: 20,
                              left: 20,
                              right: 20), // add padding to adjust text
                          isDense: true,
                          hintText: "Password",
                          prefixIcon: Padding(
                            padding: EdgeInsets.only(
                                top: 15), // add padding to adjust icon
                            child: Icon(Icons.password, color: Colors.white),
                          ),
                        )),
                  ),
                ),
                /*SizedBox(
                width: 500,
                child: Container(
                  padding: const EdgeInsets.all(20),
                  child: FlutterGooglePlacesWeb(
                    decoration: const InputDecoration(
                        focusColor: Colors.white,
                        filled: true,
                        hintText: "Address",
                        fillColor: Colors.white,
                        enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.white)),
                        border: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.white))),
                    apiKey: "AIzaSyDQ1iMEkqR12pOPikUbVs5HGB6Vao8zb0M",
                    proxyURL: "https://bartender.leocorno.purefusion.com/",
                    components: 'country:ca',
                    required: true,
                  ),
                ),
              ),*/
                Padding(padding: EdgeInsets.only(top: 40)),
                SizedBox(
                    height: 50, //height of button
                    width: MediaQuery.of(context).size.width /
                        1.2, //width of button
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: Colors.orange, // background
                        onPrimary: Colors.orange, // foreground
                      ),
                      onPressed: _signupPressed,
                      child: Text('Sign Up',
                          style:
                              TextStyle(fontSize: 15.0, color: Colors.white)),
                    )),
                if (controller.signupStatus.value == SignupStatus.loading)
                  Padding(
                    padding: const EdgeInsets.all(30.0),
                    child: spinkit,
                  ),
                TextButton(
                    onPressed: () {
                      Get.back();
                    },
                    child: Text('Login',
                        style:
                            TextStyle(fontSize: 15.0, color: Colors.orange))),
              ],
            ),
          )
        ],
      ));
    });
  }
}

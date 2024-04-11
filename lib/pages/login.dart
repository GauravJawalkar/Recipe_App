// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:recepie_app/services/auth_service.dart';
import 'package:status_alert/status_alert.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  GlobalKey<FormState> loginFormKey = GlobalKey();
  bool hidden = true;

  String? username, password;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 26.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Icon(
                Icons.flutter_dash_outlined,
                size: 100,
              ),
              const SizedBox(
                height: 20,
              ),
              Center(
                child: Text(
                  "Please Login Here",
                  style: TextStyle(
                    fontSize: 35,
                    fontFamily: GoogleFonts.lato().fontFamily,
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Form(
                key: loginFormKey,
                child: Column(
                  children: [
                    TextFormField(
                      initialValue: "kminchelle",
                      onSaved: (value) {
                        setState(() {
                          username = value;
                        });
                      },
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Enter Username";
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        prefixIcon: const Icon(
                          Icons.person_2_outlined,
                          size: 30,
                        ),
                        floatingLabelStyle: TextStyle(color: Colors.brown[400]),
                        label: const Text(
                          "Enter Username",
                          style: TextStyle(
                            fontSize: 18,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      initialValue: "0lelplR",
                      onSaved: (value) {
                        setState(() {
                          password = value;
                        });
                      },
                      validator: (value) {
                        if (value == null || value.length < 5) {
                          return "Enter a valid Password";
                        }
                        return null;
                      },
                      obscureText: hidden,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        prefixIcon: GestureDetector(
                          onTap: () {
                            setState(() {
                              hidden = !hidden;
                            });
                          },
                          child: const Icon(
                            Icons.remove_red_eye_outlined,
                            size: 30,
                          ),
                        ),
                        floatingLabelStyle: TextStyle(color: Colors.brown[400]),
                        label: const Text(
                          "Enter Password",
                          style: TextStyle(
                            fontSize: 18,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 25,
              ),
              ElevatedButton.icon(
                style: ButtonStyle(
                  backgroundColor: const MaterialStatePropertyAll(Colors.black),
                  shape: MaterialStatePropertyAll(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ),
                onPressed: () async {
                  if (loginFormKey.currentState?.validate() ?? false) {
                    loginFormKey.currentState?.save();
                    bool result = await AuthService().login(
                      username!,
                      password!,
                    );
                    if (result) {
                      Navigator.pushReplacementNamed(context, "/mainhome");
                    } else {
                      StatusAlert.show(context,
                          duration: const Duration(seconds: 3),
                          title: "Login Failed",
                          subtitle: "Please try Again",
                          configuration:
                              const IconConfiguration(icon: Icons.error),
                          maxWidth: 260);
                    }
                  }
                },
                label: const Padding(
                  padding: EdgeInsets.symmetric(vertical: 12.0),
                  child: Text(
                    "  Login Here",
                    style: TextStyle(fontSize: 18, color: Colors.white),
                  ),
                ),
                icon: const Icon(
                  Icons.login_outlined,
                  color: Colors.white,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

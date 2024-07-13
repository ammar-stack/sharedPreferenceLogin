import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'mainscreen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool login = false;
 @override
  void initState() {
    // TODO: implement initState
    super.initState();
    checkLoginStatus();
  }

  Future<void> checkLoginStatus()async{
    final prefs = await SharedPreferences.getInstance();
    bool isSignup = prefs.getBool("isSignup")?? false;
    setState(() {
      login = isSignup;
    });
    if(login){
      moveNewScreen();
    }
    else{
      print("User is not signed up yet");
    }
  }

  Widget build(BuildContext context) {
    String userName = "";
    String email = "";
    String password = "";
    var controllerEmail = TextEditingController();
    var controllerPassword = TextEditingController();
    var controlleruserName = TextEditingController();
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Sign Up",
              style: GoogleFonts.alef(
                  textStyle: const TextStyle(
                      color: Colors.amber,
                      fontSize: 40,
                      fontWeight: FontWeight.bold)),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
              child: TextField(
                style: const TextStyle(color: Colors.grey),
                controller: controlleruserName,
                decoration: InputDecoration(
                    hintText: "Enter Your UserName",
                    fillColor: Colors.grey,
                    hintStyle: const TextStyle(
                        color: Colors.white60, letterSpacing: 2),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30))),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 30, right: 30, bottom: 20),
              child: TextField(
                style: const TextStyle(color: Colors.grey),
                controller: controllerEmail,
                decoration: InputDecoration(
                    hintText: "Enter Your Email",
                    fillColor: Colors.grey,
                    hintStyle: const TextStyle(
                        color: Colors.white60, letterSpacing: 2),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30))),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 30, right: 30, bottom: 30),
              child: TextField(
                style: const TextStyle(color: Colors.grey),
                controller: controllerPassword,
                decoration: InputDecoration(
                    hintText: "Enter Your Password",
                    hintStyle: const TextStyle(
                        color: Colors.white60, letterSpacing: 2),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30))),
              ),
            ),
            ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: Colors.amber),
                onPressed: () async {
                  email = controllerEmail.text.toString();
                  password = controllerPassword.text.toString();
                  userName = controlleruserName.text.toString();
                  SharedPreferences prefs =
                      await SharedPreferences.getInstance();
                  await prefs.setBool("isSignup", true);
                  await prefs.setString("Email", email);
                  await prefs.setString("Password", password);
                  await prefs.setString("Username", userName);
                  moveNewScreen();
                  print(userName);
                },
                child: Text(
                  "Sign Up",
                  style: GoogleFonts.alef(
                      textStyle: const TextStyle(
                          color: Colors.black,
                          fontSize: 25,
                          fontWeight: FontWeight.bold)),
                ))
          ],
        ),
      ),
    );
  }

  void moveNewScreen() {
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => const MainScreen()));
  }
}

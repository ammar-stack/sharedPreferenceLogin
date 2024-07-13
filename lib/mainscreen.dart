import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'home.dart';
class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  String name = "Name";
  Future<void> getData() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      name = prefs.getString("Username") ?? "no user found";
    });
    print(name);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Welcome",
              style: GoogleFonts.abel(
                  textStyle: const TextStyle(
                      color: Colors.amber,
                      fontWeight: FontWeight.bold,
                      fontSize: 70)),
            ),
            Center(
              child: Text(
                name,
                style: GoogleFonts.abel(
                    textStyle:
                        const TextStyle(color: Colors.amber, fontSize: 30)),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 75),
              child: ElevatedButton(
                  style:
                      ElevatedButton.styleFrom(backgroundColor: Colors.amber),
                  onPressed: () async{
                    final prefs =await SharedPreferences.getInstance();
                    prefs.setBool("isSignup", false);
                    movetohome();
                  },
                  child: const Text(
                    "Logout",
                    style: TextStyle(color: Colors.black, fontSize: 25),
                  )),
            )
          ],
        ),
      ),
    );
  }
  void movetohome(){
    Navigator.pushReplacement(context, MaterialPageRoute(builder: ((context) => const HomeScreen())));
  }
}

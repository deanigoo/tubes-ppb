import 'package:flutter/material.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: 15.0,
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 10.0),
              child: Image.asset(
                "assets/Pre-Medicine.png",
                height: 100,
              ),
            ),
            Container(
              margin: EdgeInsets.only(bottom: 10.0),
              child: Text(
                "DOCTORS CARE",
                style: TextStyle(fontFamily: "Inter",
                  color: const Color.fromARGB(255, 121, 114, 114),
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Image.asset(
              "assets/splashscreen.png",
              height: 300,
            ),
            SizedBox(height: 20),
            Container(
              margin: EdgeInsets.only(top: 20),
              child: Text(
                "Consult Specialist Doctor\nSecurely and Privately",
                style: TextStyle(fontFamily: "Inter",
                  color: Colors.black,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            SizedBox(height: 50),
            InkWell(
              onTap: () {
                Navigator.pushReplacementNamed(context, "/welcome");
              },
              child: Ink(
                padding: EdgeInsets.symmetric(horizontal: 100, vertical: 16),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(25),
                  color: Color.fromARGB(255, 1, 94, 216),
                ),
                child: Text(
                  "Get Started",
                  style: TextStyle(fontFamily: "Inter",
                    color: Colors.white,
                    fontSize: 27,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

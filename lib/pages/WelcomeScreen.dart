// ignore_for_file: file_names, library_private_types_in_public_api

import 'package:consultant_app/pages_patient/LoginPatient_view.dart';
import 'package:flutter/material.dart';
import 'package:consultant_app/pages/LoginScreen.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  String? groupValue;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            Positioned(
              left: 0,
              right: 0,
              child: Container(
                width: double.maxFinite,
                height: 350,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image: AssetImage("assets/welcome.png"),
                  ),
                ),
              ),
            ),
            Positioned(
              top: 330,
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: 700,
                decoration: const BoxDecoration(
                  color: Color.fromARGB(255, 1, 94, 216),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Padding(
                      padding: EdgeInsets.all(45.0),
                      child: Text(
                        'Welcome!',
                        style: TextStyle(
                          fontFamily: "Inter",
                          fontSize: 27,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.fromLTRB(
                        45.0,
                        0.0,
                        10.0,
                        10.0,
                      ),
                      child: Text(
                        'Now it is easier for patients who want to consult with a doctor without having to leave home.',
                        style: TextStyle(
                          fontFamily: "Inter",
                          fontSize: 18,
                          color: Colors.white,
                        ),
                        textDirection: TextDirection.ltr,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 40),
                      child: Row(
                        children: [
                          Radio(
                            value: "Doctor",
                            groupValue: groupValue,
                            onChanged: (value) {
                              setState(() {
                                groupValue = value.toString();
                              });
                            },
                            activeColor: Colors.white,
                          ),
                          const Text(
                            'Doctor',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontFamily: "Inter"),
                          ),
                          Radio(
                            value: "Patient",
                            groupValue: groupValue,
                            onChanged: (value) {
                              setState(() {
                                groupValue = value.toString();
                              });
                            },
                            activeColor: Colors.white,
                          ),
                          const Text(
                            'Patient',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontFamily: "Inter",
                            ),
                          ),
                        ],
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        if (groupValue == 'Doctor') {
                          // Jika dipilih sebagai dokter
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const LoginScreen(),
                            ),
                          );
                        } else if (groupValue == 'Patient') {
                          // Jika dipilih sebagai pasien
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const LoginPatientView(),
                            ),
                          );
                        }
                      },
                      child: Center(
                        child: Container(
                          margin: const EdgeInsets.all(20),
                          padding: const EdgeInsets.symmetric(
                            horizontal: 20,
                            vertical: 10,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: const Text(
                            'Continue',
                            style: TextStyle(
                              color: Colors.blue,
                              fontSize: 18,
                              fontFamily: "Inter",
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

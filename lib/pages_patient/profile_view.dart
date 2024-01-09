// ignore_for_file: use_build_context_synchronously

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:consultant_app/auth/auth_service.dart';
import 'package:consultant_app/pages/WelcomeScreen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    String? userUid;

    FirebaseAuth auth = FirebaseAuth.instance;
    if (auth.currentUser != null) {
      userUid = auth.currentUser?.uid;
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Profile",
          style: TextStyle(
            color: Colors.black,
            fontSize: 20,
            fontWeight: FontWeight.bold,
            fontFamily: "Inter",
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        automaticallyImplyLeading: false,
      ),
      body: Stack(
        children: [
          // CircleAvatar with AssetImage
          Positioned(
            top: 70,
            left: MediaQuery.of(context).size.width / 2 -
                75, // Center horizontally
            child: const CircleAvatar(
              radius: 70,
              backgroundImage: AssetImage('assets/pasien1.png'),
            ),
          ),

          // Container below CircleAvatar
          Positioned(
            top:
                250, // Adjust this value to position it as desired (adding space below CircleAvatar)
            left: 20, // Adjust left value as needed
            right: 20, // Adjust right value as needed
            child: StreamBuilder(
              stream: FirebaseFirestore.instance
                  .collection('patient')
                  .doc(userUid)
                  .snapshots(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  final user = snapshot.data!;
                  return Container(
                    height: 200,
                    decoration: BoxDecoration(
                      color: Colors.blue,
                      borderRadius:
                          BorderRadius.circular(15), // Set the border radius
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 16.0),
                          child: Text(
                            'Nama: ${user['name']}',
                            style: const TextStyle(
                              fontFamily: "Inter",
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        const SizedBox(height: 10),
                        Padding(
                          padding: const EdgeInsets.only(left: 16.0),
                          child: Text(
                            'Email: ${user['email']}',
                            style: const TextStyle(
                              fontFamily: "Inter",
                              fontSize: 18,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        const SizedBox(height: 10),
                        Padding(
                          padding: const EdgeInsets.only(left: 16.0),
                          child: Text(
                            'No Telpon: ${user['phone']}',
                            style: const TextStyle(
                              fontFamily: "Inter",
                              fontSize: 18,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        const SizedBox(height: 10),
                        Padding(
                          padding: const EdgeInsets.only(left: 16.0),
                          child: Text(
                            'Alamat: ${user['address']}',
                            style: const TextStyle(
                              fontFamily: "Inter",
                              fontSize: 18,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                } else {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
              },
            ),
          ),

          // Logout Button
          Positioned(
            bottom: 200,
            left: 20,
            right: 20,
            child: ElevatedButton(
              onPressed: () async {
                final result = await AuthService().logout();

                if (result == 'Logout Success') {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const WelcomeScreen(),
                    ),
                  );
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(result ?? 'An error occurred'),
                    ),
                  );
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color.fromARGB(255, 240, 27, 27),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                minimumSize: const Size(50, 70),
                padding: const EdgeInsets.symmetric(horizontal: 50),
              ),
              child: const Text(
                'Logout',
                style: TextStyle(
                  fontFamily: "Inter",
                  fontSize: 18,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

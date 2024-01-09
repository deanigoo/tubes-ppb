// ignore_for_file: file_names

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:consultant_app/pages/ConsultSchedule_Screen.dart';
import 'package:consultant_app/pages/List_Pasien.dart';
import 'package:consultant_app/pages/List_Queue.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  FirebaseAuth auth = FirebaseAuth.instance;
  String name = '';

  @override
  void initState() {
    super.initState();
    getNameUser();
  }

  void getNameUser() async {
    FirebaseAuth auth = FirebaseAuth.instance;

    final user = FirebaseFirestore.instance
        .collection('doctor')
        .doc(auth.currentUser?.uid);
    final data = await user.get();

    if (data.exists) {
      setState(() {
        name = data['name'];
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              // Appbar
              Container(
                padding: const EdgeInsets.only(top: 20, left: 20, right: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Icon(
                      Icons.menu,
                      size: 30,
                      color: Colors.black54,
                    ),
                    Row(
                      children: [
                        Text(
                          " Hello, $name",
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            fontFamily: "Inter",
                          ),
                        ),
                        const SizedBox(width: 8),
                        CircleAvatar(
                          radius: 30,
                          backgroundColor: Colors.grey.withOpacity(0.5),
                          child: Image.asset(
                            'assets/profile_doctor.png',
                            width: MediaQuery.of(context).size.width - 40,
                            height: 60,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),

              const SizedBox(height: 30),

              // Queue Today Text
              Container(
                margin: const EdgeInsets.only(left: 20),
                child: const Row(
                  children: [
                    Text(
                      "Queue Today",
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        fontFamily: "Inter",
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 10),

              // Queue Today
              Container(
                margin: const EdgeInsets.only(left: 20),
                child: StreamBuilder(
                  stream: FirebaseFirestore.instance
                      .collection('doctor')
                      .doc(auth.currentUser?.uid)
                      .collection('booked')
                      .snapshots(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                    if (snapshot.hasError) {
                      return const Center(
                        child: Text("Error"),
                      );
                    }
                    var data = snapshot.data!.docs;
                    return SizedBox(
                      height: 200,
                      child: ListView.builder(
                        itemCount: data.length,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) {
                          if (data[index]['day'] == "Senin") {
                            return Container(
                              width: 350,
                              padding: const EdgeInsets.all(40),
                              margin: const EdgeInsets.only(right: 25),
                              decoration: BoxDecoration(
                                color: const Color.fromARGB(255, 197, 224, 247),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Row(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(
                                      right: 20,
                                    ),
                                    child: CircleAvatar(
                                      radius: 40,
                                      backgroundColor:
                                          Colors.grey.withOpacity(0.5),
                                      child: Image.asset(
                                        'assets/pasien1.png',
                                        width: 80,
                                        height: 80,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        data[index]['patientName'],
                                        style: const TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                          fontFamily: "Inter",
                                        ),
                                      ),
                                      Text(
                                        data[index]['price'],
                                        style: const TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                          fontFamily: "Inter",
                                        ),
                                      ),
                                      Container(
                                        margin: const EdgeInsets.only(top: 5),
                                        padding: const EdgeInsets.all(8),
                                        decoration: BoxDecoration(
                                          color: Colors.green,
                                          borderRadius:
                                              BorderRadius.circular(5),
                                        ),
                                        child: Text(
                                          data[index]['time'],
                                          style: const TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold,
                                            fontFamily: "Inter",
                                          ),
                                        ),
                                      ),
                                      InkWell(
                                        onTap: () {
                                          // Aksi yang ingin dilakukan ketika kotak diklik
                                        },
                                        child: Container(
                                          margin: const EdgeInsets.only(top: 5),
                                          padding: const EdgeInsets.all(8),
                                          decoration: BoxDecoration(
                                            color: Colors.blue,
                                            borderRadius:
                                                BorderRadius.circular(5),
                                          ),
                                          child: const Text(
                                            "Start Consultation",
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold,
                                              fontFamily: "Inter",
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            );
                          } else {
                            return const SizedBox();
                          }
                        },
                      ),
                    );
                  },
                ),
              ),

              const SizedBox(height: 45),

              // List Patient Text
              Container(
                margin: const EdgeInsets.only(left: 20),
                child: const Row(
                  children: [
                    Text(
                      "List Patient",
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        fontFamily: "Inter",
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 10),

              // List Patient
              Container(
                margin: const EdgeInsets.only(left: 20, right: 20),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: StreamBuilder(
                    stream: FirebaseFirestore.instance
                        .collection('doctor')
                        .doc(auth.currentUser?.uid)
                        .collection('booked')
                        .snapshots(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                      if (snapshot.hasError) {
                        return const Center(
                          child: Text("Error"),
                        );
                      }
                      var data = snapshot.data!.docs;
                      return SizedBox(
                        height: 150,
                        child: ListView.builder(
                          itemCount: data.length,
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (context, index) {
                            return Container(
                              width: 300,
                              padding: const EdgeInsets.all(20),
                              margin: const EdgeInsets.only(right: 15),
                              decoration: BoxDecoration(
                                color: const Color.fromARGB(255, 197, 224, 247),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Row(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(
                                      right: 20,
                                    ),
                                    child: CircleAvatar(
                                      radius: 40,
                                      backgroundColor:
                                          Colors.grey.withOpacity(0.5),
                                      child: Image.asset(
                                        'assets/pasien1.png',
                                        width: 80,
                                        height: 80,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      InkWell(
                                        onTap: () {
                                          // Tambahkan navigasi ke halaman baru di sini
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  const ListPasien(),
                                            ),
                                          );
                                        },
                                        child: Text(
                                          data[index]['patientName'],
                                          style: const TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold,
                                            fontFamily: "Inter",
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                      );
                    },
                  ),
                ),
              ),

              const SizedBox(height: 25),

              // Manage Text
              Container(
                margin: const EdgeInsets.only(left: 20),
                child: const Row(
                  children: [
                    Text(
                      "Manage",
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        fontFamily: "Inter",
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 10),

              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const ConsultScheduleScreen(),
                    ),
                  );
                },
                child: Container(
                  width: MediaQuery.of(context).size.width - 40,
                  height: 70,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.black,
                        offset: Offset(0.0, 1.0),
                        blurRadius: 3.0,
                      ),
                    ],
                  ),
                  margin: const EdgeInsets.only(bottom: 10),
                  child: const Center(
                    child: Text(
                      "List Consultation Schedule",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                        fontFamily: "Inter",
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),

              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const ListPasien(),
                    ),
                  );
                },
                child: Container(
                  width: MediaQuery.of(context).size.width - 40,
                  height: 70,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.black,
                        offset: Offset(0.0, 1.0),
                        blurRadius: 3.0,
                      ),
                    ],
                  ),
                  margin: const EdgeInsets.only(bottom: 10),
                  child: const Center(
                    child: Text(
                      "List Patient",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                        fontFamily: "Inter",
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),

              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const ListQueue(),
                    ),
                  );
                },
                child: Container(
                  width: MediaQuery.of(context).size.width - 40,
                  height: 70,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.black,
                        offset: Offset(0.0, 2.0),
                        blurRadius: 3.0,
                      ),
                    ],
                  ),
                  child: const Center(
                    child: Text(
                      "List Queue",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                        fontFamily: "Inter",
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 25),
            ],
          ),
        ),
      ),
    );
  }
}

// ignore_for_file: file_names, library_private_types_in_public_api

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ListPasien extends StatefulWidget {
  const ListPasien({Key? key}) : super(key: key);

  @override
  _ListPasienState createState() => _ListPasienState();
}

class _ListPasienState extends State<ListPasien> {
  FirebaseAuth auth = FirebaseAuth.instance;

  List color = [
    const Color.fromARGB(255, 1, 94, 216),
    Colors.orange,
    Colors.green,
    Colors.red
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 20, left: 20),
              child: Row(
                children: [
                  IconButton(
                    icon: const Icon(Icons.arrow_back_ios_new_rounded),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                  const Text(
                    'List Patient',
                    style: TextStyle(
                      fontFamily: "Inter",
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 25),
            Expanded(
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
                  return ListView.builder(
                    itemCount: data.length,
                    itemBuilder: (context, index) {
                      return Container(
                        decoration: BoxDecoration(
                          color: color[index],
                          borderRadius: BorderRadius.circular(10),
                        ),
                        height: 100,
                        width: MediaQuery.of(context).size.width - 40,
                        margin: const EdgeInsets.only(
                          bottom: 25,
                          left: 20,
                          right: 20,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            const Padding(
                              padding: EdgeInsets.only(left: 20),
                              child: CircleAvatar(
                                radius: 30,
                                backgroundColor: Colors.white,
                              ),
                            ),
                            const SizedBox(width: 10),
                            Expanded(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    data[index][
                                        'patientName'], // Ganti dengan nama yang sesuai
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      fontFamily: "Inter",
                                    ),
                                  ),
                                  Text(
                                    'Nomor Telepon : ${data[index]['patientPhone']}', // Ganti dengan nomor telepon yang sesuai
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 14,
                                      fontFamily: "Inter",
                                    ),
                                  ),
                                  Text(
                                    'Alamat : ${data[index]['patientAddress']}', // Ganti dengan alamat yang sesuai
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 14,
                                      fontFamily: "Inter",
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

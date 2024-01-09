// ignore_for_file: file_names

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ListDiagnosis extends StatefulWidget {
  const ListDiagnosis({super.key});

  @override
  State<ListDiagnosis> createState() => _ListDiagnosisState();
}

class _ListDiagnosisState extends State<ListDiagnosis> {
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
                    'List Diagnosis',
                    style: TextStyle(
                      fontFamily: "Inter",
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 5),
            StreamBuilder(
              stream: FirebaseFirestore.instance
                  .collection('diagnosis')
                  .doc(FirebaseAuth.instance.currentUser?.uid)
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
                var data = snapshot.data!;
                if (data.exists) {
                  return Container(
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 1, 94, 216),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    height: 100,
                    width: MediaQuery.of(context).size.width - 40,
                    margin: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 15),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        const SizedBox(width: 20),
                        Expanded(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Doctor : ${data['doctorName']}', // Ganti dengan nama yang sesuai
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: "Inter",
                                ),
                              ),
                              Text(
                                'Specialist : ${data['doctorSpecialist']}',
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 14,
                                  fontFamily: "Inter",
                                ),
                              ),
                              Text(
                                'Consultation Time : ${data['time']}',
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 14,
                                  fontFamily: "Inter",
                                ),
                              ),
                              Text(
                                'Diagnosis : ${data['diagnosis']}',
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
                } else {
                  return const Center(child: Text("Empty"));
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}

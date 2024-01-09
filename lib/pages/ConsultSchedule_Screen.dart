// ignore_for_file: file_names

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:consultant_app/pages/DetailSchedule_Screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ConsultScheduleScreen extends StatefulWidget {
  const ConsultScheduleScreen({Key? key}) : super(key: key);

  @override
  State<ConsultScheduleScreen> createState() => _ConsultScheduleScreenState();
}

class _ConsultScheduleScreenState extends State<ConsultScheduleScreen> {
  FirebaseAuth auth = FirebaseAuth.instance;

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
                    'Consultation Schedule',
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
              child: Column(
                children: [
                  StreamBuilder(
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
                      return Expanded(
                        child: ListView.builder(
                          itemCount: data.length,
                          itemBuilder: (context, index) {
                            return InkWell(
                              onTap: () {
                                // Navigate to detail page
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        DetailScheduleScreen(data: data[index]),
                                  ),
                                );
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                  color: const Color.fromARGB(255, 1, 94, 216),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                height: 100,
                                margin: const EdgeInsets.symmetric(
                                    horizontal: 25, vertical: 25),
                                width: MediaQuery.of(context).size.width - 40,
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    const Padding(
                                      padding: EdgeInsets.only(left: 20),
                                      child: Icon(
                                        Icons.access_time,
                                        color: Colors.white,
                                      ),
                                    ),
                                    Align(
                                      alignment: Alignment.centerLeft,
                                      child: Text(
                                        "${data[index]['day']}\nTime : ${data[index]['time']}\nPrice : ${data[index]['price']}",
                                        style: const TextStyle(
                                          color: Colors.white,
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                          fontFamily: "Inter",
                                        ),
                                      ),
                                    ),
                                    const Padding(
                                      padding: EdgeInsets.only(right: 10),
                                      child: Icon(
                                        Icons.arrow_forward,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                      );
                    },
                  ),
                  // InkWell(
                  //   onTap: () {
                  //     // Navigate to detail page
                  //     Navigator.push(
                  //       context,
                  //       MaterialPageRoute(
                  //         builder: (context) => const DetailScheduleScreen(),
                  //       ),
                  //     );
                  //   },
                  //   child: Container(
                  //     decoration: BoxDecoration(
                  //       color: const Color.fromARGB(255, 1, 94, 216),
                  //       borderRadius: BorderRadius.circular(10),
                  //     ),
                  //     height: 100,
                  //     width: MediaQuery.of(context).size.width - 40,
                  //     child: const Row(
                  //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //       children: [
                  //         Padding(
                  //           padding: EdgeInsets.only(left: 20),
                  //           child: Icon(
                  //             Icons.access_time,
                  //             color: Colors.white,
                  //           ),
                  //         ),
                  //         Expanded(
                  //           child: Align(
                  //             alignment: Alignment.centerLeft,
                  //             child: Padding(
                  //               padding: EdgeInsets.only(left: 10),
                  //               child: Text(
                  //                 'Thursday\n Time : 04:00 PM - 04:30 PM\n Price : 50000',
                  //                 style: TextStyle(
                  //                   color: Colors.white,
                  //                   fontSize: 16,
                  //                   fontWeight: FontWeight.bold,
                  //                   fontFamily: "Inter",
                  //                 ),
                  //               ),
                  //             ),
                  //           ),
                  //         ),
                  //         Padding(
                  //           padding: EdgeInsets.only(right: 10),
                  //           child: Icon(
                  //             Icons.arrow_forward,
                  //             color: Colors.white,
                  //           ),
                  //         ),
                  //       ],
                  //     ),
                  //   ),
                  // ),
                  // const SizedBox(height: 20),
                  // Container(
                  //   decoration: BoxDecoration(
                  //     color: Colors.green,
                  //     borderRadius:
                  //         BorderRadius.circular(10), // Adjust the border radius
                  //   ),
                  //   height: 100,
                  //   width: MediaQuery.of(context).size.width - 40,
                  //   child: const Align(
                  //     alignment: Alignment.centerLeft,
                  //     child: Padding(
                  //       padding: EdgeInsets.only(left: 20),
                  //       child: Text(
                  //         'Column 2',
                  //         style: TextStyle(
                  //           color: Colors.white,
                  //           fontSize: 16,
                  //           fontWeight: FontWeight.bold,
                  //           fontFamily: "Inter",
                  //         ),
                  //       ),
                  //     ),
                  //   ),
                  // ),
                  // const SizedBox(height: 20),
                  // Container(
                  //   decoration: BoxDecoration(
                  //     color: Colors.orange,
                  //     borderRadius:
                  //         BorderRadius.circular(10), // Adjust the border radius
                  //   ),
                  //   height: 100,
                  //   width: MediaQuery.of(context).size.width - 40,
                  //   child: const Align(
                  //     alignment: Alignment.centerLeft,
                  //     child: Padding(
                  //       padding: EdgeInsets.only(left: 20),
                  //       child: Text(
                  //         'Column 3',
                  //         style: TextStyle(
                  //           color: Colors.white,
                  //           fontSize: 16,
                  //           fontWeight: FontWeight.bold,
                  //           fontFamily: "Inter",
                  //         ),
                  //       ),
                  //     ),
                  //   ),
                  // ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

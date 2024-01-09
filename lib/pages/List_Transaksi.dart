import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:consultant_app/pages/DetailTransaction_Doctor.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ListTransaksi extends StatelessWidget {
  const ListTransaksi({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.all(30.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                margin: const EdgeInsets.only(bottom: 8.0),
                child: const Text(
                  'List Transaction',
                  style: TextStyle(
                    fontFamily: "Inter",
                    fontSize: 24.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.all(15),
                padding: const EdgeInsets.symmetric(horizontal: 15),
                height: 50,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: Colors.black),
                  color: Colors.white,
                ),
                child: Row(
                  children: [
                    const Icon(Icons.search),
                    Container(
                      margin: const EdgeInsets.only(left: 10),
                      width: 230,
                      child: TextFormField(
                        decoration: const InputDecoration(
                          hintText: "Search transaction by status",
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                    const Spacer(),
                    const Icon(Icons.filter_list),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              Expanded(
                child: StreamBuilder(
                  stream: FirebaseFirestore.instance
                      .collection('transaction')
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
                        if (data[index]['id'] ==
                            FirebaseAuth.instance.currentUser?.uid) {
                          return Stack(
                            children: [
                              InkWell(
                                onTap: () {
                                  // Navigasi ke halaman detail
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            DetailTransactionDoctor(
                                              data: data[index],
                                            )),
                                  );
                                }, // <-- Add comma here
                                child: Container(
                                  height: 130,
                                  width: double.infinity,
                                  margin: const EdgeInsets.only(bottom: 15),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(8),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.grey.withOpacity(0.5),
                                        spreadRadius: 2,
                                        blurRadius: 5,
                                        offset: const Offset(0, 3),
                                      ),
                                    ],
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        const Text(
                                          'Transaction ID',
                                          style: TextStyle(
                                            fontSize: 18,
                                            fontFamily: "Inter",
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        const SizedBox(height: 4),
                                        Row(
                                          children: [
                                            const Text(
                                              '#',
                                              style: TextStyle(
                                                fontFamily: "Inter",
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            const SizedBox(width: 4),
                                            Text(
                                              data[index]['id'],
                                              style: const TextStyle(
                                                fontFamily: "Inter",
                                                fontSize: 13,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ],
                                        ),
                                        const SizedBox(height: 14),
                                        Text(
                                          'Total: \$${data[index]['price']}',
                                          style: const TextStyle(
                                            color: Colors.grey,
                                            fontFamily: "Inter",
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        const SizedBox(height: 8),
                                        Row(
                                          children: [
                                            const Text(
                                              'Status: ',
                                              style: TextStyle(
                                                color: Colors.grey,
                                                fontFamily: "Inter",
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            Text(
                                              data[index]['paymentStatus'],
                                              style: TextStyle(
                                                color: data[index]
                                                            ['paymentStatus'] ==
                                                        'Success'
                                                    ? Colors.green
                                                    : Colors.blue,
                                                fontFamily: "Inter",
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              Positioned(
                                top: 8,
                                right: 8,
                                child: Align(
                                  alignment: Alignment.topRight,
                                  child: Text(
                                    'Tanggal: ${data[index]['date']}',
                                    style: const TextStyle(
                                      fontFamily: "Inter",
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          );
                        }
                        return const SizedBox();
                      },
                    );
                  },
                ),
              ),
              // Stack(
              //   children: [
              //     Container(
              //       height: 130,
              //       width: double.infinity,
              //       decoration: BoxDecoration(
              //         color: Colors.white,
              //         borderRadius: BorderRadius.circular(8),
              //         boxShadow: [
              //           BoxShadow(
              //             color: Colors.grey.withOpacity(0.5),
              //             spreadRadius: 2,
              //             blurRadius: 5,
              //             offset: const Offset(0, 3),
              //           ),
              //         ],
              //       ),
              //       child: const Padding(
              //         padding: EdgeInsets.all(8.0),
              //         child: Column(
              //           crossAxisAlignment: CrossAxisAlignment.start,
              //           children: [
              //             Text(
              //               'Transaction ID',
              //               style: TextStyle(
              //                 fontSize: 18,
              //                 fontFamily: "Inter",
              //                 fontWeight: FontWeight.bold,
              //               ),
              //             ),
              //             SizedBox(height: 4),
              //             Row(
              //               children: [
              //                 Text(
              //                   '#',
              //                   style: TextStyle(
              //                     fontFamily: "Inter",
              //                     fontSize: 16,
              //                     fontWeight: FontWeight.bold,
              //                   ),
              //                 ),
              //                 SizedBox(width: 4),
              //                 Text(
              //                   'Transaction Number',
              //                   style: TextStyle(
              //                     fontFamily: "Inter",
              //                     fontSize: 16,
              //                     fontWeight: FontWeight.bold,
              //                   ),
              //                 ),
              //               ],
              //             ),
              //             SizedBox(height: 14),
              //             Text(
              //               'Total: \$100.00',
              //               style: TextStyle(
              //                 color: Colors.grey,
              //                 fontFamily: "Inter",
              //                 fontSize: 16,
              //                 fontWeight: FontWeight.bold,
              //               ),
              //             ),
              //             SizedBox(height: 8),
              //             Row(
              //               children: [
              //                 Text(
              //                   'Status: ',
              //                   style: TextStyle(
              //                     color: Colors.grey,
              //                     fontFamily: "Inter",
              //                     fontSize: 16,
              //                     fontWeight: FontWeight.bold,
              //                   ),
              //                 ),
              //                 Text(
              //                   'Success ',
              //                   style: TextStyle(
              //                     color: Colors.green,
              //                     fontFamily: "Inter",
              //                     fontSize: 16,
              //                     fontWeight: FontWeight.bold,
              //                   ),
              //                 ),
              //               ],
              //             ),
              //           ],
              //         ),
              //       ),
              //     ),
              //     const Positioned(
              //       top: 8,
              //       right: 8,
              //       child: Align(
              //         alignment: Alignment.topRight,
              //         child: Text(
              //           'Tanggal: ...',
              //           style: TextStyle(
              //             fontFamily: "Inter",
              //             fontSize: 16,
              //             fontWeight: FontWeight.bold,
              //           ),
              //         ),
              //       ),
              //     ),
              //   ],
              // ),
            ],
          ),
        ),
      ),
    );
  }
}

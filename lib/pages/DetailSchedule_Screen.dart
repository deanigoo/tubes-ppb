// ignore_for_file: file_names, prefer_typing_uninitialized_variables

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class DetailScheduleScreen extends StatefulWidget {
  const DetailScheduleScreen({Key? key, required this.data}) : super(key: key);

  final data;

  @override
  State<DetailScheduleScreen> createState() => _DetailScheduleScreenState();
}

class _DetailScheduleScreenState extends State<DetailScheduleScreen> {
  String? selectedDay;
  TextEditingController priceController = TextEditingController();
  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  @override
  void initState() {
    super.initState();
    selectedDay = widget.data['day'];
    priceController.text = widget.data['price'];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            // Bagian atas dengan tombol kembali
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
                ],
              ),
            ),

            // Container dengan teks "Consultation Schedule Detail"
            Container(
              margin: const EdgeInsets.only(top: 70),
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 5,
                    blurRadius: 7,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: const Text(
                'Consultation Schedule Detail',
                style: TextStyle(
                  fontFamily: "Inter",
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),

            const SizedBox(height: 30),
            Expanded(
              child: SingleChildScrollView(
                child: Container(
                  margin: const EdgeInsets.only(top: 40),
                  height: MediaQuery.of(context).size.height - 324,
                  decoration: const BoxDecoration(
                    color: Color.fromARGB(255, 1, 94, 216),
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30),
                    ),
                  ),
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Teks "Pick Day"
                      const SizedBox(height: 30),
                      const Text(
                        'Pick Day',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(
                          height: 20), // Spasi antara teks dan dropdown button

                      // Dropdown button
                      Container(
                        width: MediaQuery.of(context).size.width,
                        alignment: Alignment.centerLeft,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(15),
                        ),
                        height: 55,
                        child: DropdownButtonFormField<String>(
                          value: selectedDay,
                          isExpanded: true,
                          onChanged: (value) {
                            setState(() {
                              selectedDay = value!;
                            });
                          },
                          items: [
                            'Rabu',
                            'Selasa',
                            'Senin',
                          ].map((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(
                                value,
                                style: const TextStyle(
                                  color: Colors.black87,
                                ),
                              ),
                            );
                          }).toList(),
                          hint: const Text(
                            'Choose Day',
                            style: TextStyle(
                              color: Colors.black87,
                            ),
                          ),
                          // Menghilangkan garis bawah pada DropdownButtonFormField
                          decoration: const InputDecoration(
                            border: InputBorder.none,
                            contentPadding: EdgeInsets.symmetric(
                                horizontal: 16, vertical: 16),
                          ),
                        ),
                      ),

                      // Container baru di bawah DropdownButtonFormField untuk teks "Time"
                      Container(
                        margin: const EdgeInsets.only(top: 20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(height: 20),
                            const Text(
                              "Time",
                              style: TextStyle(
                                fontFamily: "Inter",
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 10),
                            // Kotak dengan radius dan warna hijau di bawah teks "Time"
                            Container(
                              height: 40,
                              width: MediaQuery.of(context).size.width,
                              decoration: BoxDecoration(
                                color: Colors.green,
                                borderRadius: BorderRadius.circular(15),
                              ),
                              child: const Center(
                                child: Text(
                                  "4:00 PM - 4:30 PM",
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontFamily: "Inter",
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              // Tambahkan konten sesuai kebutuhan
                            ),
                          ],
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.only(top: 20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(height: 20),
                            const Text(
                              "Price",
                              style: TextStyle(
                                fontFamily: "Inter",
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 10),
                            // Kotak dengan radius dan warna hijau di bawah teks "Time"
                            Container(
                              height: 55,
                              width: MediaQuery.of(context).size.width,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(15),
                              ),
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 16),
                                child: TextField(
                                  controller: priceController,
                                  style: const TextStyle(
                                    color: Colors.black,
                                    fontFamily: "Inter",
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  decoration: const InputDecoration(
                                    hintText: 'Enter Price',
                                    hintStyle: TextStyle(
                                      color: Colors.black54,
                                      fontFamily: "Inter",
                                      fontSize: 16,
                                    ),
                                    border: InputBorder.none,
                                  ),
                                  onChanged: (value) {
                                    // Handle perubahan nilai
                                  },
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),

                      //  tombol Delete dan Update
                      Container(
                        margin: const EdgeInsets.symmetric(vertical: 20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            ElevatedButton(
                              onPressed: () {
                                // Handle tombol Delete
                                final result = firestore
                                    .collection('doctor')
                                    .doc(auth.currentUser?.uid)
                                    .collection('booked')
                                    .doc(widget.data['userId']);

                                try {
                                  result.delete();
                                  Navigator.pop(context);
                                } on FirebaseAuthException catch (e) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text(
                                        e.message ?? 'An error occurred',
                                      ),
                                    ),
                                  );
                                }
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.red,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                              child: const Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 20, vertical: 15),
                                child: Text(
                                  'Delete',
                                  style: TextStyle(fontSize: 16),
                                ),
                              ),
                            ),
                            ElevatedButton(
                              onPressed: () {
                                // Handle tombol Update
                                final result = firestore
                                    .collection('doctor')
                                    .doc(auth.currentUser?.uid)
                                    .collection('booked')
                                    .doc(widget.data['userId']);

                                result.update({
                                  'day': selectedDay,
                                  'price': priceController.text,
                                });

                                final trans = firestore
                                    .collection('transaction')
                                    .doc(widget.data['userId']);

                                trans.update({
                                  'day': selectedDay,
                                  'price': priceController.text,
                                });

                                Navigator.pop(context);
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.green,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                              child: const Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 20, vertical: 15),
                                child: Text(
                                  'Update',
                                  style: TextStyle(fontSize: 16),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                  // Tambahkan konten sesuai kebutuhan
                ),
              ),
            ),
            // Tambahkan lebih banyak konten seperti yang diperlukan
          ],
        ),
      ),
    );
  }
}

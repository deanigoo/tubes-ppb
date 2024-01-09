// ignore_for_file: file_names, use_build_context_synchronously

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:consultant_app/auth/firestore_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DetailDoctor extends StatefulWidget {
  final QueryDocumentSnapshot<Map<String, dynamic>> data;

  const DetailDoctor({super.key, required this.data});

  @override
  State<DetailDoctor> createState() => _DetailDoctorState();
}

class _DetailDoctorState extends State<DetailDoctor> {
  String? dayValue;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
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
                      'Detail Information',
                      style: TextStyle(
                        fontFamily: "Inter",
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.all(20),
                child: Image.asset("assets/booked.png"),
              ),
              Container(
                padding: const EdgeInsets.all(20),
                child: Column(
                  children: [
                    const SizedBox(
                      height: 10,
                    ),
                    const CircleAvatar(
                      radius: 50,
                      backgroundColor: Colors.grey,
                      backgroundImage: AssetImage("assets/psikolog2.png"),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      "Dr. ${widget.data['name']}",
                      style: const TextStyle(
                        fontFamily: "Inter",
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      widget.data['specialist'],
                      style: const TextStyle(
                        fontFamily: "Inter",
                        fontSize: 18,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.all(20),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 10),
                        Row(
                          children: [
                            const Text(
                              'Available At :',
                              style: TextStyle(
                                fontFamily: "Inter",
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(width: 10),
                            Container(
                              padding: const EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                color: Colors.green,
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: const Text(
                                '4:00 PM - 4:30 PM',
                                style: TextStyle(
                                  fontFamily: "Inter",
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 15),
                        const Text(
                          'Practice Addres : Surabaya',
                          style: TextStyle(
                            fontFamily: "Inter",
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 15),
                        const Text(
                          'Price: \$100',
                          style: TextStyle(
                            fontFamily: "Inter",
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 15),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            const Text(
                              'Day:',
                              style: TextStyle(
                                fontFamily: "Inter",
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(width: 10),
                            SizedBox(
                              width: 300,
                              child: DropdownButtonFormField<String>(
                                decoration: const InputDecoration(
                                  hintText: 'Choose The Day',
                                  filled: true,
                                  fillColor: Colors.blue,
                                ),
                                value: null,
                                onChanged: (String? newValue) {
                                  setState(() {
                                    dayValue = newValue;
                                  });
                                },
                                items: <String>[
                                  'Senin',
                                  'Selasa',
                                  'Rabu',
                                  'Kamis',
                                  'Jumat',
                                ].map<DropdownMenuItem<String>>((String value) {
                                  return DropdownMenuItem<String>(
                                    value: value,
                                    child: Text(value),
                                  );
                                }).toList(),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 30),
                        SizedBox(
                          height: 50,
                          width: MediaQuery.of(context).size.width - 40,
                          child: TextButton(
                            onPressed: () async {
                              var now = DateTime.now();
                              var formatter = DateFormat('yyyy-MM-dd');
                              String formattedDate = formatter.format(now);

                              if (dayValue != null) {
                                FirebaseAuth auth = FirebaseAuth.instance;

                                final user = FirebaseFirestore.instance
                                    .collection('patient')
                                    .doc(auth.currentUser?.uid);
                                final patient = await user.get();

                                await FirestoreService().addTransaction(
                                  docRefDoctor: widget.data['id'],
                                  docRefPatient: auth.currentUser?.uid,
                                  imgName: 'null',
                                  imgUrl: 'null',
                                  doctorName: widget.data['name'],
                                  doctorPhone: widget.data['phone'],
                                  doctorBank: widget.data['bank'],
                                  day: dayValue!,
                                  date: formattedDate.toString(),
                                  time: "4:00 PM - 4:30 PM",
                                  patientName: patient['name'],
                                  patientPhone: patient['phone'],
                                  patientAddress: patient['address'],
                                  price: "100",
                                  paymentStatus: "Waiting for Payment",
                                );

                                final result =
                                    await FirestoreService().addBookedDoctor(
                                  docRefDoctor: widget.data['id'],
                                  docRefPatient: auth.currentUser?.uid,
                                  doctorName: widget.data['name'],
                                  doctorPhone: widget.data['phone'],
                                  doctorBank: widget.data['bank'],
                                  doctorSpecialist: widget.data['specialist'],
                                  day: dayValue!,
                                  date: formattedDate.toString(),
                                  time: "4:00 PM - 4:30 PM",
                                  price: "100",
                                  patientEmail: patient['email'],
                                  patientName: patient['name'],
                                  patientPhone: patient['phone'],
                                  patientAddress: patient['address'],
                                  diagnosis: 'null',
                                );

                                if (result == 'true') {
                                  Navigator.pop(context, true);
                                } else {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text(result ??
                                          'Silahkan Isi Hari dahulu!'),
                                    ),
                                  );
                                }
                              } else {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text('Silahkan Isi Hari dahulu!'),
                                  ),
                                );
                              }
                            },
                            style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all<Color>(
                                const Color.fromARGB(255, 1, 94, 216),
                              ), // Sesuaikan warna sesuai kebutuhan
                            ),
                            child: const Text(
                              'Book Now',
                              style: TextStyle(
                                fontFamily: "Inter",
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

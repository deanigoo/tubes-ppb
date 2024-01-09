// ignore_for_file: file_names, prefer_typing_uninitialized_variables

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class QueueDetail extends StatefulWidget {
  const QueueDetail({Key? key, required this.data}) : super(key: key);

  final data;

  @override
  State<QueueDetail> createState() => _QueueDetailState();
}

class _QueueDetailState extends State<QueueDetail> {
  bool isDone = true;
  TextEditingController diagnosisController = TextEditingController();

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
                    'List Queue Detail',
                    style: TextStyle(
                      fontFamily: "Inter",
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            Container(
              alignment: Alignment.topRight,
              margin: const EdgeInsets.only(right: 20),
              child: Text(
                widget.data['day'],
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  fontFamily: "Inter",
                ),
              ),
            ),
            const SizedBox(height: 20),
            Container(
              margin: const EdgeInsets.only(right: 250),
              padding: const EdgeInsets.all(8),
              decoration: const BoxDecoration(
                color: Colors.green,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(10),
                  topRight: Radius.circular(10),
                  bottomRight: Radius.circular(10),
                ),
              ),
              child: Text(
                widget.data['time'],
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontFamily: "Inter",
                ),
              ),
            ),
            const SizedBox(height: 50),
            Container(
              width: MediaQuery.of(context).size.width - 40,
              height: 200,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 5,
                    blurRadius: 7,
                    offset: const Offset(0, 3),
                  )
                ],
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  CircleAvatar(
                    radius: 40,
                    backgroundColor: Colors.grey.withOpacity(0.5),
                    child: Image.asset(
                      'assets/pasien1.png', // Ganti dengan path gambar sesuai kebutuhan
                      width: 80,
                      height: 80,
                      fit: BoxFit.cover,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    widget.data['patientName'], // Ganti dengan nama yang sesuai
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      fontFamily: "Inter",
                    ),
                    textAlign: TextAlign.justify,
                  ),
                  Text(
                    'Email: ${widget.data['patientEmail']}', // Ganti dengan email yang sesuai
                    style: const TextStyle(
                      fontSize: 14,
                      fontFamily: "Inter",
                    ),
                    textAlign: TextAlign.justify,
                  ),
                  Text(
                    'Phone : ${widget.data['patientPhone']}', // Ganti dengan nomor telepon yang sesuai
                    style: const TextStyle(
                      fontSize: 14,
                      fontFamily: "Inter",
                    ),
                    textAlign: TextAlign.justify,
                  ),
                  Text(
                    'Address : ${widget.data['patientAddress']}', // Ganti dengan alamat yang sesuai
                    style: const TextStyle(
                      fontSize: 14,
                      fontFamily: "Inter",
                    ),
                    textAlign: TextAlign.justify,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            StreamBuilder(
              stream: FirebaseFirestore.instance
                  .collection('diagnosis')
                  .doc(widget.data['userId'])
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
                return (data.exists)
                    ? (data['diagnosis'] == 'null')
                        ? (isDone)
                            ? ElevatedButton(
                                onPressed: () {
                                  // Tambahkan aksi yang ingin Anda lakukan ketika tombol ditekan
                                  showDialog<void>(
                                    context: context,
                                    barrierDismissible:
                                        false, // user must tap button!
                                    builder: (BuildContext context) {
                                      return AlertDialog(
                                        title: const Text(
                                            'Are you sure want to start?'),
                                        content: const Text(
                                          'You will be directed to Whatsapp, to start consulting with patient',
                                        ),
                                        actions: <Widget>[
                                          TextButton(
                                            style: TextButton.styleFrom(
                                                backgroundColor: Colors.blue,
                                                elevation: 1),
                                            child: const Text(
                                              'Yes',
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 16,
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ),
                                            onPressed: () {
                                              setState(() {
                                                isDone = !isDone;
                                              });
                                              Navigator.of(context).pop();
                                            },
                                          ),
                                          TextButton(
                                            style: TextButton.styleFrom(
                                                backgroundColor: Colors.white,
                                                elevation: 5),
                                            child: const Text(
                                              'Cancel',
                                              style: TextStyle(
                                                color: Colors.blue,
                                                fontSize: 16,
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ),
                                            onPressed: () {
                                              Navigator.of(context).pop();
                                            },
                                          ),
                                        ],
                                      );
                                    },
                                  );
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.blue,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                ),
                                child: const Text(
                                  'Start Consultation',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              )
                            : ElevatedButton(
                                onPressed: () {
                                  // Tambahkan aksi yang ingin Anda lakukan ketika tombol ditekan
                                  showDialog<void>(
                                    context: context,
                                    barrierDismissible:
                                        false, // user must tap button!
                                    builder: (BuildContext context) {
                                      return AlertDialog(
                                        title: const Text(
                                            'Are you sure want to finish this consultaition?'),
                                        content: const Text(
                                          "when the consultation is done, you'll asked to report patient diagnosis",
                                        ),
                                        actions: <Widget>[
                                          TextButton(
                                            style: TextButton.styleFrom(
                                                backgroundColor: Colors.blue,
                                                elevation: 1),
                                            child: const Text(
                                              'Yes',
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 16,
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ),
                                            onPressed: () {
                                              Navigator.pop(context);
                                              showDialog<void>(
                                                context: context,
                                                barrierDismissible:
                                                    false, // user must tap button!
                                                builder:
                                                    (BuildContext context) {
                                                  return AlertDialog(
                                                    title: const Text(
                                                        'Diagnosis Patient'),
                                                    content: TextField(
                                                      controller:
                                                          diagnosisController,
                                                      decoration:
                                                          const InputDecoration(
                                                        labelText:
                                                            "Diagnosis Patient",
                                                      ),
                                                    ),
                                                    actions: <Widget>[
                                                      TextButton(
                                                        style: TextButton
                                                            .styleFrom(
                                                                backgroundColor:
                                                                    Colors.blue,
                                                                elevation: 1),
                                                        child: const Text(
                                                          'Finish',
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.white),
                                                        ),
                                                        onPressed: () async {
                                                          final result =
                                                              FirebaseFirestore
                                                                  .instance
                                                                  .collection(
                                                                      'diagnosis')
                                                                  .doc(widget
                                                                          .data[
                                                                      'userId']);

                                                          result.set({
                                                            'doctorName': widget
                                                                    .data[
                                                                'doctorName'],
                                                            'doctorSpecialist':
                                                                widget.data[
                                                                    'doctorSpecialist'],
                                                            'time': widget
                                                                .data['time'],
                                                            'day': widget
                                                                .data['day'],
                                                            'diagnosis':
                                                                diagnosisController
                                                                    .text,
                                                          });

                                                          Navigator.of(context)
                                                              .pop();
                                                          setState(() {
                                                            isDone = !isDone;
                                                          });
                                                        },
                                                      ),
                                                    ],
                                                  );
                                                },
                                              );
                                            },
                                          ),
                                          TextButton(
                                            style: TextButton.styleFrom(
                                                backgroundColor: Colors.white,
                                                elevation: 5),
                                            child: const Text(
                                              'Cancel',
                                              style: TextStyle(
                                                color: Colors.blue,
                                                fontSize: 16,
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ),
                                            onPressed: () {
                                              Navigator.of(context).pop();
                                            },
                                          ),
                                        ],
                                      );
                                    },
                                  );
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.red,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                ),
                                child: const Text(
                                  'Finish Consultation',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              )
                        : Container(
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              color: Colors.red,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: const Text(
                              "Consultation has ended",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600),
                            ),
                          )
                    : (isDone)
                        ? ElevatedButton(
                            onPressed: () {
                              // Tambahkan aksi yang ingin Anda lakukan ketika tombol ditekan
                              showDialog<void>(
                                context: context,
                                barrierDismissible:
                                    false, // user must tap button!
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    title: const Text(
                                        'Are you sure want to start?'),
                                    content: const Text(
                                      'You will be directed to Whatsapp, to start consulting with patient',
                                    ),
                                    actions: <Widget>[
                                      TextButton(
                                        style: TextButton.styleFrom(
                                            backgroundColor: Colors.blue,
                                            elevation: 1),
                                        child: const Text(
                                          'Yes',
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 16,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                        onPressed: () {
                                          setState(() {
                                            isDone = !isDone;
                                          });
                                          Navigator.of(context).pop();
                                        },
                                      ),
                                      TextButton(
                                        style: TextButton.styleFrom(
                                            backgroundColor: Colors.white,
                                            elevation: 5),
                                        child: const Text(
                                          'Cancel',
                                          style: TextStyle(
                                            color: Colors.blue,
                                            fontSize: 16,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                        },
                                      ),
                                    ],
                                  );
                                },
                              );
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.blue,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5),
                              ),
                            ),
                            child: const Text(
                              'Start Consultation',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          )
                        : ElevatedButton(
                            onPressed: () {
                              // Tambahkan aksi yang ingin Anda lakukan ketika tombol ditekan
                              showDialog<void>(
                                context: context,
                                barrierDismissible:
                                    false, // user must tap button!
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    title: const Text(
                                        'Are you sure want to finish this consultaition?'),
                                    content: const Text(
                                      "when the consultation is done, you'll asked to report patient diagnosis",
                                    ),
                                    actions: <Widget>[
                                      TextButton(
                                        style: TextButton.styleFrom(
                                            backgroundColor: Colors.blue,
                                            elevation: 1),
                                        child: const Text(
                                          'Yes',
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 16,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                        onPressed: () {
                                          Navigator.pop(context);
                                          showDialog<void>(
                                            context: context,
                                            barrierDismissible:
                                                false, // user must tap button!
                                            builder: (BuildContext context) {
                                              return AlertDialog(
                                                title: const Text(
                                                    'Diagnosis Patient'),
                                                content: TextField(
                                                  controller:
                                                      diagnosisController,
                                                  decoration:
                                                      const InputDecoration(
                                                    labelText:
                                                        "Diagnosis Patient",
                                                  ),
                                                ),
                                                actions: <Widget>[
                                                  TextButton(
                                                    style: TextButton.styleFrom(
                                                        backgroundColor:
                                                            Colors.blue,
                                                        elevation: 1),
                                                    child: const Text(
                                                      'Finish',
                                                      style: TextStyle(
                                                          color: Colors.white),
                                                    ),
                                                    onPressed: () async {
                                                      final result =
                                                          FirebaseFirestore
                                                              .instance
                                                              .collection(
                                                                  'diagnosis')
                                                              .doc(widget.data[
                                                                  'userId']);

                                                      result.set({
                                                        'doctorName': widget
                                                            .data['doctorName'],
                                                        'doctorSpecialist': widget
                                                                .data[
                                                            'doctorSpecialist'],
                                                        'time':
                                                            widget.data['time'],
                                                        'day':
                                                            widget.data['day'],
                                                        'diagnosis':
                                                            diagnosisController
                                                                .text,
                                                      });

                                                      Navigator.of(context)
                                                          .pop();
                                                      setState(() {
                                                        isDone = !isDone;
                                                      });
                                                    },
                                                  ),
                                                ],
                                              );
                                            },
                                          );
                                        },
                                      ),
                                      TextButton(
                                        style: TextButton.styleFrom(
                                            backgroundColor: Colors.white,
                                            elevation: 5),
                                        child: const Text(
                                          'Cancel',
                                          style: TextStyle(
                                            color: Colors.blue,
                                            fontSize: 16,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                        },
                                      ),
                                    ],
                                  );
                                },
                              );
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.red,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5),
                              ),
                            ),
                            child: const Text(
                              'Finish Consultation',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          );
              },
            ),
          ],
        ),
      ),
    );
  }
}

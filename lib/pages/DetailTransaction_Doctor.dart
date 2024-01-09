import 'package:flutter/material.dart';

class DetailTransactionDoctor extends StatefulWidget {
  const DetailTransactionDoctor({super.key, required this.data});

  final data;

  @override
  State<DetailTransactionDoctor> createState() =>
      _DetailTransactionDoctorState();
}

class _DetailTransactionDoctorState extends State<DetailTransactionDoctor> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Container(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            IconButton(
              icon: const Icon(Icons.arrow_back_ios_new_rounded),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Transaction ID',
                  style: TextStyle(
                    fontFamily: "Inter",
                    fontSize: 24.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  'Hari: ${widget.data['day']}',
                  style: const TextStyle(
                    fontFamily: "Inter",
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Text(
              '# ${widget.data['id']}',
              style: const TextStyle(
                fontFamily: "Inter",
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            Container(
              alignment: Alignment.center,
              child: const Column(
                children: [
                  SizedBox(height: 10),
                  Text(
                    'Transaction Detail',
                    style: TextStyle(
                      fontFamily: "Inter",
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 30),
            Container(
              padding: const EdgeInsets.only(left: 50.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Patient Name : ${widget.data['patientName']}',
                    style: const TextStyle(
                      fontFamily: "Inter",
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Phone Number : ${widget.data['patientPhone']}',
                    style: const TextStyle(
                      fontFamily: "Inter",
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Address : ${widget.data['patientAddress']}',
                    style: const TextStyle(
                      fontFamily: "Inter",
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Total : \$${widget.data['price']}',
                    style: const TextStyle(
                      fontFamily: "Inter",
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'Status : ${widget.data['paymentStatus']}',
                    style: const TextStyle(
                      fontFamily: "Inter",
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 40),
            const SizedBox(height: 8),
            Center(
              child: Container(
                width: 400,
                height: 200,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: NetworkImage(widget.data['imgUrl']),
                    fit: BoxFit.contain,
                  ),
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
              ),
            ),
          ],
        ),
      )),
    );
  }
}

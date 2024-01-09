// ignore_for_file: file_names

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:consultant_app/pages_patient/ListDiagnosis.dart';
import 'package:consultant_app/pages_patient/detailDoctor.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class HomePatientView extends StatefulWidget {
  const HomePatientView({Key? key}) : super(key: key);

  @override
  State<HomePatientView> createState() => _HomePatientViewState();
}

class _HomePatientViewState extends State<HomePatientView> {
  FirebaseAuth auth = FirebaseAuth.instance;

  String name = '';
  String? bookedUserID;

  @override
  void initState() {
    super.initState();
    getNameUser();
    // getIdBooked();
  }

  // void getIdBooked() async {
  //   FirebaseAuth auth = FirebaseAuth.instance;

  //   final user = FirebaseFirestore.instance
  //       .collection('doctor')
  //       .doc('eoSaB3LZwdah9Rkpz1BdnKThNQp1')
  //       .collection('booked')
  //       .doc(auth.currentUser?.uid);
  //   final data = await user.get();

  //   if (data.exists) {
  //     setState(() {
  //       bookedUserID = data['userId'];
  //     });
  //   } else {
  //     bookedUserID = null;
  //   }
  // }

  Future<String?> getIdFromDr(String? docId) {
    FirebaseAuth auth = FirebaseAuth.instance;

    final user = FirebaseFirestore.instance
        .collection('doctor')
        .doc(docId)
        .collection('booked')
        .doc(auth.currentUser?.uid);

    return user.get().then((data) {
      return data['userId'];
    });
  }

  void getNameUser() async {
    FirebaseAuth auth = FirebaseAuth.instance;

    final user = FirebaseFirestore.instance
        .collection('patient')
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
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              // custom app bar
              Container(
                padding: const EdgeInsets.only(right: 20, left: 20, top: 30),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Icon(
                      Icons.menu,
                      color: Colors.black54,
                      size: 30,
                    ),
                    Row(
                      children: [
                        Text(
                          'Hello, $name',
                          style: const TextStyle(
                            fontFamily: "Inter",
                            color: Colors.black,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(width: 10),
                        const CircleAvatar(
                          radius: 30,
                          backgroundColor: Colors.grey,
                          backgroundImage: AssetImage("assets/pasien1.png"),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.only(top: 50, right: 50, left: 50),
                width: double.maxFinite,
                height: 350,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image: AssetImage("assets/homepat.png"),
                  ),
                ),
              ),

              // produk widgets
              Container(
                margin: const EdgeInsets.symmetric(vertical: 30),
                width: MediaQuery.of(context).size.width - 40,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Padding(
                      padding: EdgeInsets.all(20.0),
                      child: Text(
                        "Doctor's Schedule",
                        style: TextStyle(
                          fontFamily: "Inter",
                          color: Colors.black,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),

                    // Wrap the DoctorCard widgets in a SingleChildScrollView for horizontal scrolling
                    StreamBuilder(
                      stream: FirebaseFirestore.instance
                          .collection('doctor')
                          .snapshots(),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
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
                          height: 233,
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: data.length,
                            itemBuilder: (context, index) {
                              return FutureBuilder(
                                future: getIdFromDr(data[index]['id']),
                                builder: (context, snapshot) {
                                  return DoctorCard(
                                    image: "assets/dokter_umum2.png",
                                    name: "Dr. ${data[index]['name']}",
                                    specialization: data[index]['specialist'],
                                    price: "\$100",
                                    onPressed: () {
                                      // Navigate to the detail page when the "Book" button is pressed
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => DetailDoctor(
                                            data: data[index],
                                          ), // Pass necessary data
                                        ),
                                      );
                                    },
                                    isBooked:
                                        auth.currentUser?.uid == snapshot.data,
                                  );
                                },
                              );
                            },
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 5),

              Container(
                margin: const EdgeInsets.symmetric(vertical: 30),
                width: MediaQuery.of(context).size.width - 40,
                alignment: Alignment.centerLeft,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Padding(
                      padding: EdgeInsets.all(20.0),
                      child: Text(
                        "Doctor's Specialist",
                        style: TextStyle(
                          fontFamily: "Inter",
                          color: Colors.black,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const SizedBox(height: 5),
                    StreamBuilder(
                      stream: FirebaseFirestore.instance
                          .collection('doctor')
                          .snapshots(),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
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
                          height: 178,
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: data.length,
                            itemBuilder: (context, index) {
                              return DoctorCard1(
                                image: "assets/dokter_umum2.png",
                                name: "Dr. ${data[index]['name']}",
                                specialization: data[index]['specialist'],
                              );
                            },
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
              GestureDetector(
                onTap: () {
                  // Navigate to the new page here
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const ListDiagnosis()),
                  );
                },
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  height: 60,
                  width: MediaQuery.of(context).size.width - 40,
                  child: const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: Row(
                      children: [
                        Icon(
                          Icons.note,
                          color: Colors.white,
                          size: 30,
                        ),
                        SizedBox(width: 10),
                        Text(
                          'Your Diagnosis',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            fontFamily: "Inter",
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class DoctorCard extends StatelessWidget {
  final String image;
  final String name;
  final String specialization;
  final String price;
  final VoidCallback onPressed;
  final bool isBooked;

  const DoctorCard(
      {super.key,
      required this.image,
      required this.name,
      required this.specialization,
      required this.price,
      required this.onPressed,
      required this.isBooked});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 200, // Set a fixed width for each DoctorCard
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        children: [
          Image.asset(
            image,
            width: 100,
            height: 100,
            fit: BoxFit.cover,
          ),
          const SizedBox(height: 10),
          Text(
            name,
            style: const TextStyle(
              fontFamily: "Inter",
              color: Colors.black,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            specialization,
            style: const TextStyle(
              fontFamily: "Inter",
              color: Colors.black,
              fontSize: 14,
            ),
          ),
          Text(
            price,
            style: const TextStyle(
              fontFamily: "Inter",
              color: Colors.black,
              fontSize: 14,
            ),
          ),
          (isBooked)
              ? Container(
                  padding: const EdgeInsets.all(5),
                  margin: const EdgeInsets.only(top: 10),
                  width: 65,
                  height: 30,
                  decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.circular(5)),
                  child: const Center(
                    child: Text(
                      "Booked",
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ),
                )
              : ElevatedButton(
                  onPressed: onPressed,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                  ),
                  child: const Text("Book"),
                ),
        ],
      ),
    );
  }
}

class DoctorCard1 extends StatelessWidget {
  final String image;
  final String name;
  final String specialization;

  const DoctorCard1({
    super.key,
    required this.image,
    required this.name,
    required this.specialization,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 200, // Set a fixed width for each DoctorCard
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        children: [
          Image.asset(
            image,
            width: 100,
            height: 100,
            fit: BoxFit.cover,
          ),
          const SizedBox(height: 10),
          Text(
            name,
            style: const TextStyle(
              fontFamily: "Inter",
              color: Colors.black,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            specialization,
            style: const TextStyle(
              fontFamily: "Inter",
              color: Colors.black,
              fontSize: 14,
            ),
          ),
          const SizedBox(height: 10),
        ],
      ),
    );
  }
}

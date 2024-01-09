// ignore_for_file: file_names, prefer_typing_uninitialized_variables, no_leading_underscores_for_local_identifiers, non_constant_identifier_names

import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as path;

class DetailTransaction extends StatefulWidget {
  const DetailTransaction({Key? key, required this.data}) : super(key: key);

  final data;

  @override
  State<DetailTransaction> createState() => _DetailTransactionState();
}

class _DetailTransactionState extends State<DetailTransaction> {
  FirebaseStorage storage = FirebaseStorage.instance;

  File? ImgFile;

  Future uploadFile() async {
    if (ImgFile == null) return;

    String fileName = path.basename(ImgFile!.path);
    final paymentRef = storage.ref().child('paymentProff/$fileName');

    try {
      await paymentRef.putFile(ImgFile!);
    } catch (e) {
      print('error occured');
    }
  }

  Future imgFromGallery() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);

    setState(() {
      ImgFile = File(pickedFile!.path);
    });
  }

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
                '#  ${widget.data['id']}',
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
                      'Doctor Name: ${widget.data['doctorName']}',
                      style: const TextStyle(
                        fontFamily: "Inter",
                        fontSize: 16.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Consultation Time: ${widget.data['time']}',
                      style: const TextStyle(
                        fontFamily: "Inter",
                        fontSize: 16.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Phone Number: ${widget.data['doctorPhone']}',
                      style: const TextStyle(
                        fontFamily: "Inter",
                        fontSize: 16.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Bank Account: ${widget.data['doctorBank']}',
                      style: const TextStyle(
                        fontFamily: "Inter",
                        fontSize: 16.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Total: ${widget.data['price']}',
                      style: const TextStyle(
                        fontFamily: "Inter",
                        fontSize: 16.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Status: ${widget.data['paymentStatus']}',
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
                child: InkWell(
                  onTap: () {
                    imgFromGallery();
                  },
                  child: ImgFile != null
                      ? Container(
                          width: 400,
                          height: 200,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              // fit: BoxFit.cover,
                              image: FileImage(File(ImgFile!.path)),
                            ),
                          ),
                        )
                      : Container(
                          width: 400,
                          height: 200,
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
                        ),
                ),
              ),
              const SizedBox(height: 40),
              Center(
                child: InkWell(
                  onTap: () async {
                    FirebaseAuth auth = FirebaseAuth.instance;
                    final result = FirebaseFirestore.instance
                        .collection('transaction')
                        .doc(auth.currentUser?.uid);

                    if (ImgFile == null) return;

                    String fileName = path.basename(ImgFile!.path);
                    final paymentRef =
                        storage.ref().child('paymentProff/$fileName');

                    try {
                      await paymentRef.putFile(ImgFile!);
                      String downloadUrl = await paymentRef.getDownloadURL();
                      result.update({
                        'imgUrl': downloadUrl,
                        'paymentStatus': 'Success',
                      });
                    } catch (e) {
                      print('error occured');
                    }

                    Navigator.pop(context);
                  },
                  child: Container( 
                    width: 200,
                    height: 50,
                    decoration: BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: const Center(
                      child: Text(
                        'Confirm Payment',
                        style: TextStyle(
                          color: Colors.white,
                          fontFamily: "Inter",
                          fontSize: 16.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
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

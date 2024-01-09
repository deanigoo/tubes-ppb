import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreService {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future<String?> addUserDoctor({
    required String docPath,
    required String name,
    required String email,
    required String phone,
    required String address,
    required String gender,
    required String specialist,
    required String bank,
  }) async {
    final docUser = firestore.collection('doctor').doc(docPath);

    await docUser.set({
      'id': docPath,
      'name': name,
      'email': email,
      'phone': phone,
      'address': address,
      'gender': gender,
      'specialist': specialist,
      'bank': bank,
    });

    return 'true';
  }

  Future<String?> addUserPatient({
    required String docPath,
    required String name,
    required String email,
    required String phone,
    required String address,
  }) async {
    final docUser = firestore.collection('patient').doc(docPath);

    await docUser.set({
      'name': name,
      'email': email,
      'phone': phone,
      'address': address,
    });

    return 'true';
  }

  Future<String?> addBookedDoctor({
    required String? docRefDoctor,
    required String? docRefPatient,
    required String doctorName,
    required String doctorPhone,
    required String doctorBank,
    required String doctorSpecialist,
    required String day,
    required String date,
    required String time,
    required String price,
    required String patientEmail,
    required String patientName,
    required String patientPhone,
    required String patientAddress,
    required String diagnosis,
  }) async {
    final docUser = firestore
        .collection('doctor')
        .doc(docRefDoctor)
        .collection('booked')
        .doc(docRefPatient);

    await docUser.set({
      'idDoctor': docRefDoctor,
      'userId': docRefPatient,
      'doctorName': doctorName,
      'doctorPhone': doctorPhone,
      'doctorBank': doctorBank,
      'doctorSpecialist': doctorSpecialist,
      'day': day,
      'date': date,
      'time': time,
      'price': price,
      'patientEmail': patientEmail,
      'patientName': patientName,
      'patientPhone': patientPhone,
      'patientAddress': patientAddress,
      'diagnosis': diagnosis,
    });

    return 'true';
  }

  Future<String?> addTransaction({
    required String? docRefDoctor,
    required String? docRefPatient,
    required String imgUrl,
    required String imgName,
    required String doctorName,
    required String doctorPhone,
    required String doctorBank,
    required String day,
    required String date,
    required String time,
    required String patientName,
    required String patientPhone,
    required String patientAddress,
    required String price,
    required String paymentStatus,
  }) async {
    final docUser = firestore.collection('transaction').doc(docRefPatient);

    await docUser.set({
      'id': docRefDoctor,
      'idPatient': docRefPatient,
      'imgUrl': imgUrl,
      'imgName': imgName,
      'doctorName': doctorName,
      'doctorPhone': doctorPhone,
      'doctorBank': doctorBank,
      'day': day,
      'date': date,
      'time': time,
      'patientName': patientName,
      'patientPhone': patientPhone,
      'patientAddress': patientAddress,
      'price': price,
      'paymentStatus': paymentStatus,
    });

    return 'true';
  }
}

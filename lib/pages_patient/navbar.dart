import 'package:consultant_app/pages_patient/HomePatient_view.dart';
import 'package:consultant_app/pages_patient/ListTransaction.dart';
import 'package:consultant_app/pages_patient/profile_view.dart';
import 'package:flutter/material.dart';

class Navbar extends StatefulWidget {
  const Navbar({super.key});

  @override
  State<Navbar> createState() => _HomeState();
}

class _HomeState extends State<Navbar> {

  int selectedIndex =0;
  List screenList = [
    HomePatientView(),
    ListTransaction(),
    ProfileView(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: screenList.elementAt(selectedIndex),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: selectedIndex,
        onTap: (value) {
          setState(() {
            selectedIndex = value;
          });
        },
        items: const [
        BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
        BottomNavigationBarItem(icon: Icon(Icons.shopping_cart_checkout), label: "Transaksi"),
        BottomNavigationBarItem(icon: Icon(Icons.person), label: "Profile"),
      ]),
    );
  }
}
class DoctorInfo {
  final String image;
  final String name;
  final String specialist;
  final String price;

  DoctorInfo({
    required this.image,
    required this.name,
    required this.specialist,
    required this.price,
  });
}

List<DoctorInfo> listDoctorInfo = <DoctorInfo>[
  DoctorInfo(
    image: "assets/dokter_umum2.png",
    name: "Dr. John Doe",
    specialist: "General Practitioner",
    price: "100000",
  ),

  DoctorInfo(
    image: "assets/dentist1.png",
    name: "Dr. Dian Ayu",
    specialist: "Dentist",
    price: "120000",
  ),

  DoctorInfo(
    image: "assets/psikolog2.png",
    name: "Test Patient",
    specialist: "Physicology",
    price: "200000",
  ),
];

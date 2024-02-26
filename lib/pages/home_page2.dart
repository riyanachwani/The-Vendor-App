import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_vendor/utils/routes.dart';

class HomePage2 extends StatefulWidget {
  const HomePage2({Key? key}) : super(key: key);

  @override
  State<HomePage2> createState() => _HomePage2State();
}

class _HomePage2State extends State<HomePage2> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'Pencil Vendor For Stationery',
            style: TextStyle(
              color: Colors.white,
              fontSize: 24,
            ),
          ),
          centerTitle: true,
          backgroundColor: Colors.blueAccent,
          elevation: 0.0,
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 40, right: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(
                      'Particulars',
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(width: 80),
                    Text(
                      'Inventory in\nSubhash\'s\nStationery',
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20),
              StreamBuilder<DocumentSnapshot>(
                stream: FirebaseFirestore.instance
                    .collection('vendors')
                    .doc('1')
                    .snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.hasError) {
                    return Text('Error: ${snapshot.error}');
                  }

                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return CircularProgressIndicator();
                  }

                  // Handle potential null data

                  // Assuming 'data' is a Map<String, dynamic>
                  final Map<String, dynamic>? data =
                      snapshot.data?.data() as Map<String, dynamic>;

                  if (data == null) {
                    return Text('Document with ID "1" not found.');
                  }
                  final pencilValue = data['Pencil'] ?? 'Pencil data not found';

                  return Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      buildText('Pencil'),
                      SizedBox(width: 180),
                      buildText(pencilValue),
                    ],
                  );
                },
              ),
              SizedBox(height: 50),
              Material(
                color: Colors.blueAccent,
                borderRadius: BorderRadius.circular(8),
                child: InkWell(
                  onTap: () => Navigator.of(context)
                      .pushReplacementNamed(MyRoutes.loginRoute2),
                  child: AnimatedContainer(
                    duration: const Duration(seconds: 1),
                    width: 150,
                    height: 50,
                    alignment: Alignment.center,
                    child: const Text(
                      "Logout",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        fontSize: 18,
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

  Widget buildText(String text) => Text(
        text,
        style: TextStyle(
          fontSize: 18,
        ),
      );
}

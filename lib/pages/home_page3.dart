import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_vendor/utils/routes.dart';

class HomePage3 extends StatefulWidget {
  const HomePage3({Key? key}) : super(key: key);

  @override
  State<HomePage3> createState() => _HomePage3State();
}

class _HomePage3State extends State<HomePage3> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'Books Vendor For Stationery',
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
                  final booksValue = data['Books'] ?? 'Books data not found';

                  return Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      buildText('Books'),
                      SizedBox(width: 180),
                      buildText(booksValue),
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
                      .pushReplacementNamed(MyRoutes.loginRoute3),
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

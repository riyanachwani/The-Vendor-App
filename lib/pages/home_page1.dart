import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_vendor/utils/routes.dart';
import 'package:flutter_vendor/utils/notifications.dart';
import 'package:flutter_vendor/utils/firestore_service.dart';


class HomePage1 extends StatefulWidget {
  const HomePage1({Key? key}) : super(key: key);

  @override
  State<HomePage1> createState() => _HomePage1State();
}

class _HomePage1State extends State<HomePage1> {
  final FirestoreService _firestoreService = FirestoreService();

  @override
  void initState() {
    super.initState();
    _checkInventory(); // Check inventory on app start
  }

  Future<void> _checkInventory() async {
    if (_firestoreService
        .hasLowInventory(await _firestoreService.getInventoryData())) {
      showLowInventoryNotification(); // Show notification if inventory is low
    }
  }

  void showLowInventoryNotification() {
    NotificationService.showNotification(
      title: 'Low Inventory Alert!',
      body: 'Pen, Pencil, or Books are running low!',
    ); // Call the showNotification function from notification.dart
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'Pen Vendor For Stationery',
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
                  final penValue = data['Pen'] ?? 'Pen data not found';

                  return Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      buildText('Pen'),
                      SizedBox(width: 180),
                      buildText(penValue),
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

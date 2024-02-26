import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<DocumentSnapshot<Map<String, dynamic>>> getInventoryData() async {
    return await _firestore.collection('vendors').doc('1').get();
  }

  bool hasLowInventory(DocumentSnapshot snapshot) {
    if (snapshot.exists) {
      final data = snapshot.data() as Map<String, dynamic>;
      final penLevel = data['Pen'];
      final pencilLevel = data['Pencil'];
      final bookLevel = data['Books'];

      return (penLevel == 'Low' || pencilLevel == 'Low' || bookLevel == 'Low');
    } else {
      // Handle document not found scenario
      return false;
    }
  }
}

import 'package:cloud_firestore/cloud_firestore.dart';

getUserDataStream(FirebaseFirestore firestore) {
  return firestore.collection("Users").snapshots();
}
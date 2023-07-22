import 'package:cloud_firestore/cloud_firestore.dart';

getUserDataStream(FirebaseFirestore firestore) {
  return firestore.collection("Users").snapshots();
}

getVolunteerDataStream(FirebaseFirestore firestore) {
  return firestore
      .collection("Users")
      .where("accessStatus", isEqualTo: "allowed")
      .snapshots();
}

getPendingUserDataStream(FirebaseFirestore firestore) {
  return firestore
      .collection("Users")
      .where("accessStatus", isEqualTo: "pending")
      .snapshots();
}
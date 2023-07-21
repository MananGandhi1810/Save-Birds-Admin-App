import 'package:cloud_firestore/cloud_firestore.dart';

getCaseDataStream(FirebaseFirestore firestore){
  return firestore.collection("Cases").snapshots();
}

getLastMonthCaseDataStream(FirebaseFirestore firestore){
  return firestore.collection("Cases").where("date", isGreaterThan: DateTime.now().subtract(const Duration(days: 30))).snapshots();
}
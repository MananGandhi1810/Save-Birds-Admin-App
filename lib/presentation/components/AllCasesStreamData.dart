import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:save_birds_admin/repository/CasesRepository.dart';

import 'BirdCaseCard.dart';

class AllCasesStreamData extends StatefulWidget {
  const AllCasesStreamData({super.key});

  @override
  State<AllCasesStreamData> createState() => _AllCasesStreamDataState();
}

class _AllCasesStreamDataState extends State<AllCasesStreamData> {
  FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: getCaseDataStream(_firestore),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        var caseData = snapshot.data!.docs;
        return ListView.builder(
          itemCount: caseData.length,
          itemBuilder: (context, index) {
            return BirdCaseCard(
              birdCase: caseData[index].data() as Map<String, dynamic>,
              firestore: _firestore,
              id: caseData[index].id,
            );
          },
        );
      },
    );
  }
}

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../../repository/UserRepository.dart';
import 'UserCard.dart';

class PendingUsersStreamBuilderWidget extends StatelessWidget {
  const PendingUsersStreamBuilderWidget({
    super.key,
    required FirebaseFirestore firestore,
  }) : _firestore = firestore;

  final FirebaseFirestore _firestore;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: getPendingUserDataStream(_firestore),
      builder: (context, snapshot) {
        List pendingUsers = [];
        List<Widget> pendingUserWidgets = [];
        if (!snapshot.hasData) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        var userData = snapshot.data!.docs;

        for (var doc in userData) {
          var user = doc.data() as Map<String, dynamic>;
          pendingUsers.add(user);
          pendingUserWidgets.add(
            UserCard(userData: user, firestore: _firestore, id: doc.id),
          );
        }

        return SingleChildScrollView(
          child: Center(
            child: Column(
              mainAxisAlignment: pendingUserWidgets.isEmpty
                  ? MainAxisAlignment.center
                  : MainAxisAlignment.start,
              children: pendingUserWidgets.isEmpty
                  ? [
                      const Center(
                        child: Text(
                          "No Pending Users",
                          style: TextStyle(
                            fontSize: 20.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      )
                    ]
                  : pendingUserWidgets,
            ),
          ),
        );
      },
    );
  }
}

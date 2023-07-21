import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:save_birds_admin/presentation/components/AppDrawer.dart';

import 'components/PendingUsersStreamBuilderWidget.dart';

class PendingUsersScreen extends StatefulWidget {
  const PendingUsersScreen({super.key});

  @override
  State<PendingUsersScreen> createState() => _PendingUsersScreenState();
}

class _PendingUsersScreenState extends State<PendingUsersScreen> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.lightBlue,
      appBar: AppBar(
        title: const Text("Pending Users"),
      ),
      drawer: const AppDrawer(),
      body: SafeArea(
        child: PendingUsersStreamBuilderWidget(firestore: _firestore),
      ),
    );
  }
}

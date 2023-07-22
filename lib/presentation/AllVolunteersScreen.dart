import 'package:flutter/material.dart';

import 'components/AllVolunteerData.dart';
import 'components/AppDrawer.dart';

class AllVolunteersScreen extends StatefulWidget {
  const AllVolunteersScreen({super.key});

  @override
  State<AllVolunteersScreen> createState() => _AllVolunteersScreenState();
}

class _AllVolunteersScreenState extends State<AllVolunteersScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.lightBlue,
      appBar: AppBar(
        title: const Text("All Volunteers"),
        backgroundColor: const Color(0xEEF2F8FF)
      ),
      drawer: const AppDrawer(currentScreen: "All Volunteers"),
      body: const AllVolunteerData(),
    );
  }
}

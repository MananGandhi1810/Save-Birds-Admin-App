import 'package:flutter/material.dart';

import 'components/AllCasesStreamData.dart';
import 'components/AppDrawer.dart';

class AllCasesScreen extends StatefulWidget {
  const AllCasesScreen({super.key});

  @override
  State<AllCasesScreen> createState() => _AllCasesScreenState();
}

class _AllCasesScreenState extends State<AllCasesScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.lightBlue,
      appBar: AppBar(
        title: const Text("All Cases"),
        backgroundColor: const Color(0xEEF2F8FF),
      ),
      drawer: const AppDrawer(currentScreen: "All Cases"),
      body: const AllCasesStreamData(),
    );
  }
}

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:save_birds_admin/presentation/components/AppDrawer.dart';
import 'package:save_birds_admin/repository/CasesRepository.dart';

class LeaderboardScreen extends StatefulWidget {
  const LeaderboardScreen({super.key});

  @override
  State<LeaderboardScreen> createState() => _LeaderboardScreenState();
}

class _LeaderboardScreenState extends State<LeaderboardScreen> {
  FirebaseFirestore _firestore = FirebaseFirestore.instance;
  var allVolunteers = [];

  getAllVolunteers() async {
    var _volunteers = await _firestore.collection("Users").get();
    for (var volunteer in _volunteers.docs) {
      setState(() {
        allVolunteers.add(volunteer.data());
      });
    }
    debugPrint("all volunteers: ${allVolunteers.toString()}");
  }

  @override
  void initState() {
    super.initState();
    getAllVolunteers();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.lightBlue,
      appBar: AppBar(
        title: const Text("Leaderboard"),
      ),
      drawer: const AppDrawer(),
      body: StreamBuilder<QuerySnapshot>(
        stream: getCaseDataStream(_firestore),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          var caseData = snapshot.data!.docs;
          Map volunteers = {};
          List<Map> cases = [];
          for (var doc in caseData) {
            var birdCase = doc.data() as Map<String, dynamic>;
            cases.add(birdCase);
            if (birdCase["birdDropped"] != null) {
              if (birdCase["volunteer1"] != null) {
                if (volunteers[birdCase["volunteer1"]["email"]] == null) {
                  volunteers[birdCase["volunteer1"]["email"]] = 1;
                } else {
                  volunteers[birdCase["volunteer1"]["email"]] += 1;
                }
              }
              if (birdCase["volunteer2"] != null) {
                if (volunteers[birdCase["volunteer2"]["email"]] == null) {
                  volunteers[birdCase["volunteer2"]["email"]] = 1;
                } else {
                  volunteers[birdCase["volunteer2"]["email"]] += 1;
                }
              }
            }
          }
          volunteers = Map.fromEntries(
            volunteers.entries.toList()..sort((a, b) => b.value - a.value),
          );
          debugPrint(volunteers.toString());
          return allVolunteers.isEmpty
              ? const CircularProgressIndicator()
              : ListView.builder(
                  itemCount: volunteers.length,
                  itemBuilder: (context, index) {
                    return Card(
                      child: ListTile(
                        title: Text(allVolunteers
                            .where((element) =>
                                element["email"] ==
                                volunteers.keys.toList()[index])
                            .first["name"]),
                        subtitle:
                            Text(volunteers.values.toList()[index].toString()),
                      ),
                    );
                  },
                );
        },
      ),
    );
  }
}

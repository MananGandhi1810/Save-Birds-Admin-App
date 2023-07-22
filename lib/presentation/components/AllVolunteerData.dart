import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:save_birds_admin/repository/UserRepository.dart';

class AllVolunteerData extends StatefulWidget {
  const AllVolunteerData({super.key});

  @override
  State<AllVolunteerData> createState() => _AllVolunteerDataState();
}

class _AllVolunteerDataState extends State<AllVolunteerData> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: getVolunteerDataStream(_firestore),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        var userData = snapshot.data!.docs;
        return ListView.builder(
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.all(4.0),
              child: ListTile(
                tileColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                title: Text(userData[index]["name"]),
                subtitle: Text(userData[index]["email"]),
                leading: CircleAvatar(
                  backgroundImage: userData[index]["photoUrl"] != null
                      ? NetworkImage(userData[index]["photoUrl"])
                      : const AssetImage("assets/images/user.png")
                          as ImageProvider,
                ),
                trailing: IconButton(
                  icon: const Icon(Icons.remove_circle),
                  onPressed: () async {
                    showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          title: const Text("Remove User"),
                          content: const Text(
                              "Are you sure you want to remove this user?"),
                          actions: [
                            TextButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                child: const Text("Cancel")),
                            TextButton(
                                onPressed: () async {
                                  var user = await _firestore
                                      .collection("Users")
                                      .where("email",
                                          isEqualTo: userData[index]["email"])
                                      .get();
                                  user.docs.first.reference.update({
                                    "accessStatus": "rejected",
                                  });
                                  Fluttertoast.showToast(
                                    msg: "Rejected User from volunteer status",
                                  );
                                  Navigator.of(context).pop();
                                },
                                child: const Text(
                                  "Remove",
                                  style: TextStyle(color: Colors.red),
                                )),
                          ],
                        );
                      },
                    );
                  },
                ),
              ),
            );
          },
          itemCount: userData.length,
        );
      },
    );
  }
}

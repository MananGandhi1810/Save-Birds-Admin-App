import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:getwidget/getwidget.dart';

class UserCard extends StatefulWidget {
  const UserCard(
      {super.key,
      required this.userData,
      required this.firestore,
      required this.id});

  final Map userData;
  final FirebaseFirestore firestore;
  final String id;

  @override
  State<UserCard> createState() => _UserCardState();
}

class _UserCardState extends State<UserCard> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      child: Card(
        child: Column(
          children: [
            Text(
              widget.userData["name"],
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(widget.userData["accessStatus"]),
            Text(widget.userData["email"]),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                GFButton(
                  onPressed: () {
                    if (kDebugMode) {
                      print(widget.userData);
                    }
                    widget.firestore
                        .collection("Users")
                        .doc(widget.id)
                        .update({"accessStatus": "allowed"});
                    Fluttertoast.showToast(msg: "Volunteer Access Granted");
                  },
                  color: Colors.green,
                  shape: GFButtonShape.pills,
                  child: const Text(
                    "Allow",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                GFButton(
                    onPressed: () {
                      if (kDebugMode) {
                        print(widget.userData);
                      }
                      widget.firestore
                          .collection("Users")
                          .doc(widget.id)
                          .update({"accessStatus": "rejected"});
                      Fluttertoast.showToast(msg: "Volunteer Access Rejected");
                    },
                    color: Colors.red,
                    shape: GFButtonShape.pills,
                    child: const Text(
                      "Reject",
                      style: TextStyle(color: Colors.white),
                    )),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

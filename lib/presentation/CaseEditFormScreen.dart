import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:getwidget/getwidget.dart';

class CaseEditFormScreen extends StatefulWidget {
  final String id;
  final Map<String, dynamic> birdCase;
  final FirebaseFirestore firestore;

  const CaseEditFormScreen(
      {super.key,
      required this.firestore,
      required this.id,
      required this.birdCase});

  @override
  State<CaseEditFormScreen> createState() => _CaseEditFormScreenState();
}

class _CaseEditFormScreenState extends State<CaseEditFormScreen> {
  Map birdCase = {};

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Edit Case"),
        backgroundColor: const Color(0xEEF2F8FF),
      ),
      backgroundColor: Colors.lightBlue,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Card(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Form(
                child: Column(
                  children: [
                    const Text(
                      "Bird Type: ",
                      style: TextStyle(
                          fontSize: 16.0, fontWeight: FontWeight.w600),
                    ),
                    TextFormField(
                      initialValue: widget.birdCase["birdName"],
                      decoration: const InputDecoration(
                        hintText: "Bird Type",
                      ),
                      onChanged: (value) {
                        setState(() {
                          if (value.isNotEmpty) {
                            birdCase["birdName"] = value;
                          }
                        });
                      },
                    ),
                    const Padding(padding: EdgeInsets.all(10)),
                    const Text(
                      "Pickup Address: ",
                      style: TextStyle(
                          fontSize: 16.0, fontWeight: FontWeight.w600),
                    ),
                    TextFormField(
                      initialValue: widget.birdCase["pickupAddress"],
                      decoration: const InputDecoration(
                        hintText: "Pickup Address",
                      ),
                      onChanged: (value) {
                        setState(() {
                          if (value.isNotEmpty) {
                            birdCase["pickupAddress"] = value;
                          }
                        });
                      },
                    ),
                    const Padding(padding: EdgeInsets.all(10)),
                    const Text(
                      "Case Type: ",
                      style: TextStyle(
                          fontSize: 16.0, fontWeight: FontWeight.w600),
                    ),
                    DropdownButtonFormField(
                      items: const [
                        DropdownMenuItem(
                          value: "Collect",
                          child: Text("Collect"),
                        ),
                        DropdownMenuItem(
                          value: "Rescue",
                          child: Text("Rescue"),
                        ),
                      ],
                      onChanged: (value) {
                        setState(
                          () {
                            birdCase["caseType"] = value;
                          },
                        );
                      },
                      value:
                          birdCase["caseType"] ?? widget.birdCase["caseType"],
                    ),
                    const Padding(padding: EdgeInsets.all(10)),
                    const Text(
                      "Case Notes: ",
                      style: TextStyle(
                          fontSize: 16.0, fontWeight: FontWeight.w600),
                    ),
                    TextFormField(
                      initialValue: widget.birdCase["caseNotes"],
                      decoration: const InputDecoration(
                        hintText: "Case Notes",
                      ),
                      onChanged: (value) {
                        setState(() {
                          birdCase["caseNotes"] = value;
                        });
                      },
                    ),
                    Padding(padding: const EdgeInsets.all(10)),
                    const Text(
                      "Caller Number: ",
                      style: TextStyle(
                          fontSize: 16.0, fontWeight: FontWeight.w600),
                    ),
                    TextFormField(
                      initialValue: widget.birdCase["callerPhone"],
                      decoration: const InputDecoration(
                        hintText: "Caller Number",
                      ),
                      keyboardType: TextInputType.phone,
                      onChanged: (value) {
                        setState(
                          () {
                            value =
                                value.replaceAll(" ", "").replaceAll("+91", "");
                            if (value.isNotEmpty &&
                                value.length == 10 &&
                                int.tryParse(value) != null &&
                                RegExp(
                                  r"^((\+){0,1}91(\s){0,1}(\-){0,1}(\s){0,1}){0,1}9[0-9](\s){0,1}(\-){0,1}(\s){0,1}[1-9]{1}[0-9]{7}$",
                                ).hasMatch(value)) {
                              birdCase["callerPhone"] = value.toString();
                              debugPrint(birdCase["callerPhone"]);
                            }
                          },
                        );
                      },
                    ),
                    const Padding(padding: EdgeInsets.all(10)),
                    Center(
                      child: GFButton(
                        shape: GFButtonShape.pills,
                        color: Colors.green,
                        onPressed: () {
                          widget.firestore
                              .collection("Cases")
                              .doc(widget.id)
                              .update(Map<Object, dynamic>.from(birdCase));
                          Navigator.of(context).pop();
                        },
                        child: const Text("Update"),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

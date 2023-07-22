import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:getwidget/getwidget.dart';
import 'package:save_birds_admin/presentation/AllCasesScreen.dart';
import 'package:save_birds_admin/presentation/LoginScreen.dart';
import 'package:save_birds_admin/presentation/PendingUsersScreen.dart';

import '../AllVolunteersScreen.dart';
import '../LeaderboardScreen.dart';

class AppDrawer extends StatefulWidget {
  final String currentScreen;

  const AppDrawer({super.key, this.currentScreen = "Leaderboard"});

  @override
  State<AppDrawer> createState() => _AppDrawerState();
}

class _AppDrawerState extends State<AppDrawer> {
  final _auth = FirebaseAuth.instance;
  final GlobalKey _drawerKey = GlobalKey();
  final _firestore = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    return GFDrawer(
      key: _drawerKey,
      child: Column(
        children: [
          GFDrawerHeader(
              decoration: const BoxDecoration(
                color: Colors.lightBlue,
              ),
              currentAccountPicture: GFAvatar(
                maxRadius: 50,
                backgroundImage: _auth.currentUser?.photoURL != null
                    ? ResizeImage(
                        NetworkImage(_auth.currentUser!.photoURL!),
                        width: 50,
                        height: 50,
                      )
                    : const ResizeImage(
                        AssetImage("assets/images/user.png"),
                        width: 50,
                        height: 50,
                      ) as ImageProvider,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    _auth.currentUser?.displayName ?? "User",
                    style: const TextStyle(
                      fontSize: 20.0,
                    ),
                  ),
                  Text(
                    _auth.currentUser?.email ?? "Email",
                    style: const TextStyle(
                      fontSize: 15.0,
                    ),
                  ),
                ],
              )),
          ListTile(
            title: const Text("Leaderboard"),
            onTap: () {
              print(widget.currentScreen);
              if (widget.currentScreen == "Leaderboard") {
                Navigator.of(context).pop();
              } else {
                Navigator.of(context).pop();
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const LeaderboardScreen(),
                  ),
                );
              }
            },
          ),
          ListTile(
            title: const Text("Pending Users"),
            onTap: () {
              if (widget.currentScreen == "Pending Users") {
                Navigator.of(context).pop();
              } else {
                Navigator.of(context).pop();
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const PendingUsersScreen(),
                  ),
                );
              }
            },
          ),
          ListTile(
            title: const Text("All Volunteers"),
            onTap: () {
              if (widget.currentScreen == "All Volunteers") {
                Navigator.of(context).pop();
              } else {
                Navigator.of(context).pop();
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const AllVolunteersScreen(),
                  ),
                );
              }
            },
          ),
          ListTile(
            title: const Text("All Cases"),
            onTap: () {
              if (widget.currentScreen == "All Cases") {
                Navigator.of(context).pop();
              } else {
                Navigator.of(context).pop();
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const AllCasesScreen(),
                  ),
                );
              }
            },
          ),
          ListTile(
            title: const Text("Logout"),
            onTap: () {
              _auth.signOut();
              Navigator.of(context).pop();
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => const LoginScreen(),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}

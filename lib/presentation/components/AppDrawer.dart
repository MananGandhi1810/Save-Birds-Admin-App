import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:save_birds_admin/presentation/PendingUsersScreen.dart';

import '../LeaderboardScreen.dart';

class AppDrawer extends StatefulWidget {
  const AppDrawer({super.key});

  @override
  State<AppDrawer> createState() => _AppDrawerState();
}

class _AppDrawerState extends State<AppDrawer> {
  final _auth = FirebaseAuth.instance;
  final GlobalKey _drawerKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Drawer(
      key: _drawerKey,
      child: Column(
        children: [
          DrawerHeader(
            child: CircleAvatar(
              backgroundImage: _auth.currentUser?.photoURL != null
                  ? NetworkImage(_auth.currentUser!.photoURL!)
                  : const NetworkImage(
                      "https://www.google.com/url?sa=i&url=https%3A%2F%2Fwww.vecteezy.com%2Ffree-vector%2Fuser-icon&psig=AOvVaw2sNvsICKbCfelx7a0e7-5v&ust=1689963471360000&source=images&cd=vfe&opi=89978449&ved=0CA0QjRxqFwoTCOiH1dTynYADFQAAAAAdAAAAABAI"),
            ),
          ),
          ListTile(
            title: const Text("Leaderboard"),
            onTap: () {
              Navigator.of(context).pop();
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const LeaderboardScreen(),
                ),
              );
            },
          ),
          ListTile(
            title: const Text("Pending Users"),
            onTap: () {
              Navigator.of(context).pop();
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const PendingUsersScreen(),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}

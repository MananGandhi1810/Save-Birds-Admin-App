// import 'dart:async';
//
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:fluttertoast/fluttertoast.dart';
//
// import 'PendingUsersScreen.dart';
// import 'LoginScreen.dart';
//
// class SplashScreen extends StatefulWidget {
//   const SplashScreen({super.key});
//
//   @override
//   State<SplashScreen> createState() => _SplashScreenState();
// }
//
// class _SplashScreenState extends State<SplashScreen> {
//   final FirebaseAuth _auth = FirebaseAuth.instance;
//   final FirebaseFirestore _firestore = FirebaseFirestore.instance;
//
//   var pendingUsers = [];
//   var allowedUsers = [];
//   var rejectedUsers = [];
//
//   getAllUsers() async {
//     var allowedUsersSnapshot = await _firestore.collection("Users").get();
//     for (var doc in allowedUsersSnapshot.docs) {
//       var user = doc.data();
//       if (user["accessStatus"] == "allowed") {
//         allowedUsers.add(user["email"]);
//       }
//       if (user["accessStatus"] == "pending") {
//         pendingUsers.add(user["email"]);
//       }
//       if (user["accessStatus"] == "rejected") {
//         rejectedUsers.add(user["email"]);
//       }
//     }
//   }
//
//   redirect() async {
//     debugPrint("Redirecting...");
//     debugPrint(_auth.currentUser.toString());
//     if (_auth.currentUser == null) {
//       Navigator.pushReplacement(
//           context, MaterialPageRoute(builder: (context) => const Login()));
//     } else {
//       await getAllUsers();
//       if (_auth.currentUser != null) {
//         _auth.currentUser?.getIdTokenResult(true).then(
//           (userIdToken) {
//             debugPrint(userIdToken.claims.toString());
//             if (userIdToken.claims!['admin']) {
//               Navigator.pushReplacement(context,
//                   MaterialPageRoute(builder: (context) => const Dashboard()));
//             } else {
//               _auth.signOut();
//               // Navigator.pushReplacement(context,
//               //     MaterialPageRoute(builder: (context) => const Login()));
//               Fluttertoast.showToast(
//                   msg: "You are not an admin",
//                   toastLength: Toast.LENGTH_SHORT,
//                   gravity: ToastGravity.BOTTOM,
//                   timeInSecForIosWeb: 1,
//                   backgroundColor: Colors.lightBlue,
//                   textColor: Colors.white,
//                   fontSize: 16.0);
//             }
//           },
//         );
//       }
//     }
//   }
//
//   @override
//   void initState() {
//     Timer(const Duration(seconds: 0), () {
//       redirect();
//     });
//     super.initState();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.lightBlue,
//       body: Placeholder(),
//     );
//   }
// }

import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:save_birds_admin/presentation/LeaderboardScreen.dart';

import 'NotAllowedScreen.dart';
import 'PendingUsersScreen.dart';
import 'LoginScreen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  redirect() async {
    if (_auth.currentUser == null) {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => const Login()));
    } else {
      debugPrint("checking if admin...");
      if (_auth.currentUser != null) {
        _auth.currentUser?.getIdTokenResult(true).then(
          (userIdToken) {
            debugPrint(userIdToken.toString());
            debugPrint(userIdToken.claims.toString());
            if (userIdToken.claims?['admin'] != null &&
                userIdToken.claims?['admin']) {
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) => const LeaderboardScreen()));
            }
            else{
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) => const NotAllowedScreen()));
            }
          },
        );
      }
    }
  }

  @override
  void initState() {
    Timer(const Duration(seconds: 0), () {
      redirect();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.lightBlue,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            // We take the image from the assets
            SizedBox(
              height: 10,
            ),
            Image.asset(
              'assets/images/save-birds.png',
              height: 250,
            ),
            const SizedBox(
              height: 20,
            ),
            //Texts and Styling of them
            const Text(
              'Welcome to Save Birds volunteer App !',
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.white, fontSize: 28),
            ),
            const SizedBox(height: 20),
            const Text(
              'A one-stop portal for Save birds volunteers ',
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.white, fontSize: 16),
            ),
            const SizedBox(
              height: 30,
            ),
            const SizedBox(
              height: 50,
            )
          ],
        ),
      ),
    );
  }
}

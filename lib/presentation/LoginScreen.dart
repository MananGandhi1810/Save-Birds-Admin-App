import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

import 'SplashScreen.dart';


class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  signingWithGoogle() async {
    if (kDebugMode) {
      print("Called Sign in with Google");
    }
    FirebaseAuth auth = FirebaseAuth.instance;

    // Trigger the authentication flow
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    // Obtain the auth details from the request
    final GoogleSignInAuthentication? googleAuth = await googleUser?.authentication;

    // Create a new credential
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );

    // Once signed in, return the UserCredential
    UserCredential result = await auth.signInWithCredential(credential);
    User? user = result.user;
    print(_auth.currentUser);
    var currentUserDetails = _auth.currentUser;
    try{
      var userExist = await _firestore.collection("Users").doc(_auth.currentUser?.uid).get().then((doc) async => {
        if(!(doc.exists)){
          await _firestore.collection("Users").doc(_auth.currentUser?.uid).set({
            "name": _auth.currentUser?.displayName,
            "email": _auth.currentUser?.email,
            "photoUrl": _auth.currentUser?.photoURL,
            "phoneNumber": _auth.currentUser?.phoneNumber,
            "accessStatus": "pending",
          }).then((value){
            print("***** User details added to firebase *****".toUpperCase());
          })
        }
      });
    }catch(e){
      print("FIRESTORE AUTH CREATE USER ERROR ${e}");
    }
    return user;
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
            SizedBox(height: 10,),
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
            MaterialButton(
              elevation: 0,
              height: 50,
              onPressed: () async{
                var user = await signingWithGoogle();
                print("Printing User ${user}");
                if(user != null){
                  Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: (context) => const SplashScreen()));
                }
              },
              textColor: Colors.white,
              color: Colors.green,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const <Widget>[
                  Text('Get Started',
                      style: TextStyle(color: Colors.white, fontSize: 20)),
                  Icon(Icons.arrow_forward_ios)
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

// CupertinoSlidingSegmentedControl(
//   children: const <OrderDay, Widget>{
//     OrderDay.today: Padding(
//       padding: EdgeInsets.symmetric(horizontal: 20.0),
//       child: Text("Today"),
//     ),
//     OrderDay.tomorrow: Padding(
//       padding: EdgeInsets.symmetric(horizontal: 20.0),
//       child: Text("Tomorrow"),
//     ),
//     OrderDay.later: Padding(
//       padding: EdgeInsets.symmetric(horizontal: 20.0),
//       child: Text("Later"),
//     ),
//   },
//   groupValue: _currentValue,
//   onValueChanged: (OrderDay? currentVal) {
//     if (currentVal != null) {
//       setState(() {
//         _currentValue = currentVal;
//       });
//     }
//   },
// ),
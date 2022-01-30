import 'package:ecommerce/constants.dart';
import 'package:ecommerce/screens/home.dart';
import 'package:ecommerce/screens/login.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';

class LandingPage extends StatelessWidget {
  final Future<FirebaseApp> _initialization = Firebase.initializeApp();
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _initialization,
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Scaffold(
            body: Center(
              child: Text("Error: ${snapshot.error}"),
            ),
          );
        }
        if (snapshot.connectionState == ConnectionState.done) {
          return StreamBuilder(
            stream: FirebaseAuth.instance.authStateChanges(),
            builder: (context, streamsnapshot) {
              if (snapshot.hasError) {
                return Scaffold(
                  body: Center(
                    child: Text("Error: ${streamsnapshot.error}"),
                  ),
                );
              }

              if (streamsnapshot.connectionState == ConnectionState.active) {
                User _user = streamsnapshot.data;

                if (_user == null) {
                  return Login();
                } else {
                  return Home();
                }
              }

              return Scaffold(
                body: Center(
                  child: Text(
                    "Checking authenthication ",
                    style: Constants.regularHeading,
                  ),
                ),
              );
            },
          );
        }

        return Scaffold(
          body: Center(
            child: Text(
              "Intialization App...",
              style: Constants.regularHeading,
            ),
          ),
        );
      },
    );
  }
}

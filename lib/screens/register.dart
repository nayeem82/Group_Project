import 'package:ecommerce/widgets.dart/button.dart';
import 'package:ecommerce/widgets.dart/input.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../constants.dart';

class Register extends StatefulWidget {
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  //alert for an error
  Future<void> _alertDialog(String error) async {
    return showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) {
          return AlertDialog(
              title: Text("Error"),
              content: Container(
                child: Text(error),
              ),
              actions: [
                FlatButton(
                  child: Text("Close Dialog"),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                )
              ]);
        });
  }

  Future<String> _createAccount() async {
    //Create new account
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: _registeremail, password: _registerpass);
      return null;
    } on FirebaseAuthException catch (e) {
      if (e.code == "weak-password") {
        return "Please enter a stronger password";
      } else if (e.code == 'email-already-in-use') {
        return "Account already exists";
      }
      return e.message;
    } catch (e) {
      return e.toString();
    }
  }

  void _Submit() async {
    //Set form to loading
    setState(() {
      _registerLoading = true;
    });
    String _createAccountFeedback = await _createAccount();
    if (_createAccountFeedback != null) {
      _alertDialog(_createAccountFeedback);
      setState(() {
        _registerLoading = false;
      });
    } else {
      Navigator.pop(context);
    }
  }

  bool _registerLoading = false;

  String _registeremail = "";
  String _registerpass = "";

  FocusNode _passwordFocusNode;

  void initState() {
    _passwordFocusNode = FocusNode();
    super.initState();
  }

  void dispose() {
    _passwordFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          width: double.infinity,
          child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  padding: EdgeInsets.only(top: 24.0),
                  child: Text(
                    "Create A New Account",
                    textAlign: TextAlign.center,
                    style: Constants.boldHeading,
                  ),
                ),
                Column(
                  children: [
                    Input(
                      hintText: "Email",
                      onChanged: (value) {
                        _registeremail = value;
                      },
                      onSubmitted: (value) {
                        _passwordFocusNode.requestFocus();
                      },
                      textInputAction: TextInputAction.next,
                    ),
                    Input(
                      hintText: "Password",
                      onChanged: (value) {
                        _registerpass = value;
                      },
                      focusNode: _passwordFocusNode,
                      isPasswordField: true,
                      onSubmitted: (value) {
                        _Submit();
                      },
                    ),
                    Button(
                      text: "Create New Account",
                      onPressed: () {
                        _Submit();
                      },
                      isLoading: _registerLoading,
                    )
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    bottom: 16.0,
                  ),
                  child: Button(
                    text: "Login",
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    outlineBtn: true,
                  ),
                ),
              ]),
        ),
      ),
    );
  }
}

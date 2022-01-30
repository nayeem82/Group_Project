import 'package:ecommerce/screens/register.dart';
import 'package:ecommerce/widgets.dart/button.dart';
import 'package:ecommerce/widgets.dart/input.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../constants.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
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

  Future<String> _login() async {
    //Create new account
    try {
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: _loginemail, password: _loginpass);
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
      _loginLoading = true;
    });
    String _loginFeedback = await _login();
    if (_loginFeedback != null) {
      _alertDialog(_loginFeedback);
      setState(() {
        _loginLoading = false;
      });
    }
  }

  bool _loginLoading = false;

  String _loginemail = "";
  String _loginpass = "";

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
                    "Login to your account",
                    textAlign: TextAlign.center,
                    style: Constants.boldHeading,
                  ),
                ),
                Column(
                  children: [
                    Input(
                      hintText: "Email",
                      onChanged: (value) {
                        _loginemail = value;
                      },
                      onSubmitted: (value) {
                        _passwordFocusNode.requestFocus();
                      },
                    ),
                    Input(
                      hintText: "Password",
                      onChanged: (value) {
                        _loginpass = value;
                      },
                      focusNode: _passwordFocusNode,
                      isPasswordField: true,
                      onSubmitted: (value) {
                        _Submit();
                      },
                    ),
                    Button(
                      text: "Login",
                      onPressed: () {
                        _Submit();
                      },
                      isLoading: _loginLoading,
                    )
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    bottom: 16.0,
                  ),
                  child: Button(
                    text: "Create Account",
                    onPressed: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => Register()));
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

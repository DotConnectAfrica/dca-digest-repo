import 'package:dca_digital_digests/auth/sign_up_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../screens/news_page.dart';
import '../widgets/rounded_button.dart';

const kTextFieldDecoration = InputDecoration(
    hintText: 'Enter a value',
    hintStyle: TextStyle(color: Colors.black),
    contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(32.0)),
    ),
    enabledBorder: OutlineInputBorder(
      borderSide: BorderSide(color: Colors.pinkAccent, width: 1.0),
      borderRadius: BorderRadius.all(Radius.circular(32.0)),
    ),
    focusedBorder: OutlineInputBorder(
      borderSide: BorderSide(color: Colors.pinkAccent, width: 2.0),
      borderRadius: BorderRadius.all(Radius.circular(32.0)),
    ));

class LoginScreen extends StatefulWidget {

  @override
  _LoginScreenState createState() => _LoginScreenState();

}

final _auth = FirebaseAuth.instance;

class _LoginScreenState extends State<LoginScreen> {
  late String email;
  late String password;
  bool showSpinner = false;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        // inAsyncCall: showSpinner,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.0, vertical: 100.0),
          child: SingleChildScrollView(
              child: Container(
                height: 600.0,
                decoration: BoxDecoration(
                  color: Colors.white54,
                  borderRadius: BorderRadius.all(Radius.circular(32.0)),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    Text(
                      'Sign In',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 45.0,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                    // SizedBox(
                    //   height: 20.0,
                    // ),
                    TextField(
                        keyboardType: TextInputType.emailAddress,
                        textAlign: TextAlign.center,
                        onChanged: (value) {
                          email = value;
                          //Do something with the user input.
                        },
                        decoration: kTextFieldDecoration.copyWith(
                          hintText: 'Enter your email',
                        )),
                    // SizedBox(
                    //   height: 10.0,
                    // ),
                    TextField(
                        obscureText: true,
                        textAlign: TextAlign.center,
                        onChanged: (value) {
                          password = value;
                          //Do something with the user input.
                        },
                        decoration: kTextFieldDecoration.copyWith(
                            hintText: 'Enter your password.')),
                    // SizedBox(
                    //   height: 15.0,
                    // ),
                    RoundedButton(
                        colour: Colors.pinkAccent,
                        title: 'Log In',
                        onPressed: () async {
                          setState(() {
                            showSpinner = true;
                          });

                          final FirebaseAuth _auth = FirebaseAuth.instance;

                          try {
                            final UserCredential userCredential = await _auth.signInWithEmailAndPassword(
                                email: email, password: password);

                            Navigator.of(context).pushReplacement(
                              MaterialPageRoute(
                                builder: (BuildContext context) => NewsPageScreen(),
                              ),
                            );

                            SharedPreferences prefs = await SharedPreferences.getInstance();
                            prefs.setBool('isLoggedIn', true);

                          } on FirebaseAuthException catch (e){
                            if (e.code == 'user-not-found'){
                              ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(content: Text('No user found for that email.'),
                                    backgroundColor: Colors.red, duration: Duration(seconds: 4),));

                            } else if (e.code == 'wrong-password'){
                              ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(content: Text('Wrong password provided for that user.'),
                                    backgroundColor: Colors.red, duration: Duration(seconds: 4),
                                  ));
                            }
                          }

                          catch (e) {
                            print(e);
                          }

                          setState(() {
                            showSpinner = false;
                          });
                        }),

                    RichText(
                      textAlign: TextAlign.center,
                      text: TextSpan(
                        text: 'Don\'t have an account? ',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 20,
                          fontStyle: FontStyle.normal,
                        ),
                        children: <TextSpan>[
                          TextSpan(
                            text: 'Register',
                            style: TextStyle(
                              color: Colors.blue,
                              decoration: TextDecoration.underline,
                            ),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                Navigator.of(context).pushReplacement(
                                  MaterialPageRoute(builder: (context) => RegistrationScreen()),
                                );
                              },
                          ),
                        ],
                      ),
                    )

                  ],
                ),
              )
          ),
        ),
      ),
    );
  }
}
import 'package:dca_digital_digests/auth/sign_up_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../screens/news_page.dart';
import '../widgets/rounded_button.dart';
import 'forgot_password.dart';

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


class _LoginScreenState extends State<LoginScreen> {

  final _formkey = GlobalKey<FormState>();
  bool _obscureText = true;
  final TextEditingController emailController = TextEditingController();

  late String email;
  late String password;
  bool showSpinner = false;

  void _toggle() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(right: 16.0),
              child: Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                  child: const Text(
                    'Sign Up',
                    style: TextStyle(fontSize: 17.5),
                  ),
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) {
                        return RegistrationScreen();
                      },
                    ));
                  },
                ),
              ),
            ),
            const Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: EdgeInsets.fromLTRB(30.0, 50.0, 0.0, 0.0),
                child: Text("Log In",
                    style: TextStyle(
                      fontSize: 35.0,
                    )),
              ),
            ),
            Padding(
              padding:
              const EdgeInsets.only(top: 55.0, left: 30.0, right: 30.0),
              child: Form(
                key: _formkey,
                child: Column(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(top: 20.0),
                      child: TextFormField(
                        onSaved: (String? value) {},
                        onChanged: (value) {
                          email = value;
                          //Do something with the user input.
                        },
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Email is required';
                          } else {
                            return null;
                          }
                        },
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5.0),
                            borderSide: const BorderSide(
                              color: Color.fromARGB(255, 202, 202, 202),
                            ),
                          ),
                          labelText: 'Email',
                          // errorText: _error ? null : "Check Password",
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 20.0),
                      child: TextFormField(
                        onSaved: (String? value) {},
                        onChanged: (value) {
                          password = value;
                          //Do something with the user input.
                        },
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Password is required';
                          } else {
                            return null;
                          }
                        },
                        obscureText: _obscureText,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5.0),
                            borderSide: const BorderSide(
                              color: Color.fromARGB(255, 202, 202, 202),
                            ),
                          ),
                          suffixIcon: IconButton(
                            icon: Icon(
                              _obscureText == true
                                  ? Icons.visibility_off_outlined
                                  : Icons.visibility_outlined,
                              color: Colors.pinkAccent,
                            ),
                            onPressed: _toggle,
                          ),
                          labelText: 'Password',
                          // errorText: _error ? null : "Check Password",
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20.0,
                    ),
                    Align(
                      alignment: Alignment.centerRight,
                      child: InkWell(
                        child: const Text(
                          'Forgot Password?',
                          textAlign: TextAlign.end,
                          style: TextStyle(
                              color: Colors.pinkAccent, fontSize: 16),
                        ),
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) {
                              return ForgotPassword();
                            },
                          ));
                        },
                      ),
                    ),
                    Padding(
                        padding: const EdgeInsets.only(top: 20.0),
                        child: Row(
                          children: [
                            Expanded(
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                        BorderRadius.circular(5.0)),
                                   primary: Colors.pinkAccent, ),
                                onPressed: () async {

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
                                    // showLoaderDialog(context, "Logging In ");

                                  } on FirebaseAuthException catch (e){
                                    if (e.code == 'user-not-found'){
                                      ScaffoldMessenger.of(context).showSnackBar(
                                          SnackBar(content: Text('No user found for that email.'),
                                            backgroundColor: Colors.red, duration: Duration(seconds: 4),));

                                    } else if (e.code == 'wrong-password'){
                                      // ScaffoldMessenger.of(context).showSnackBar(
                                      //     SnackBar(content: Text('Wrong password provided for that user.'),
                                      //       backgroundColor: Colors.red, duration: Duration(seconds: 4),
                                      //     ));
                                    }
                                  }
                                  catch (e) {
                                    print(e);
                                  }
                                  setState(() {
                                    showSpinner = false;
                                  });
                                },
                                child: const Padding(
                                  padding: EdgeInsets.symmetric(vertical: 18.0),
                                  child: Text(
                                    'Log In',
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 16),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        )),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(40.0, 25.0, 40.0, 0.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          const Text(
                            'Don\'t Have an Account? ',
                            style: TextStyle(fontSize: 16),
                          ),
                          InkWell(
                            child: const Text(
                              'Sign Up',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.pinkAccent,
                                  fontSize: 16),
                            ),
                            onTap: () async {
                              setState(() async {
                                Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) {
                                    return RegistrationScreen();
                                  },
                                ));
                              }
                              );
                            },
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          ]),
        ),
      ),
    );
  }
  // showLoaderDialog(BuildContext context, String message) {
  //   AlertDialog alert = AlertDialog(
  //     content: Row(
  //       children: [
  //         const CircularProgressIndicator(),
  //         Container(
  //             margin: const EdgeInsets.only(left: 7),
  //             child: Text("${message}...")),
  //       ],
  //     ),
  //   );
  //   showDialog(
  //     barrierDismissible: false,
  //     context: context,
  //     builder: (BuildContext context) {
  //       return alert;
  //     },
  //   );
  // }
}
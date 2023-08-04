import 'package:dca_digital_digests/auth/terms_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../screens/news_page.dart';
import '../widgets/rounded_button.dart';
import 'login.dart';

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
  ),
);

class RegistrationScreen extends StatefulWidget {
  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}


class _RegistrationScreenState extends State<RegistrationScreen> {

  final _formkey = GlobalKey<FormState>();
  bool _obscureText = true;
  final TextEditingController emailController = TextEditingController();

  late String email;
  late String password;
  late String username;
  late String phoneNumber;
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
                    'Login',
                    style: TextStyle(fontSize: 17.5),
                  ),
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) {
                        return LoginScreen();
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
                child: Text("Sign Up",
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
                          username = value;
                          //Do something with the user input.
                        },
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Username is required';
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
                          labelText: 'Username',
                          // errorText: _error ? null : "Check Password",
                        ),
                      ),
                    ),
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
                          phoneNumber = value;
                          //Do something with the user input.
                        },
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Phone is required';
                          } else {
                            return null;
                          }
                        },
                        inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5.0),
                            borderSide: const BorderSide(
                              color: Color.fromARGB(255, 202, 202, 202),
                            ),
                          ),
                          labelText: 'Phone Number',
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
                          labelText: 'Confirm Password',
                          // errorText: _error ? null : "Check Password",
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20.0,
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
                                    backgroundColor: Colors.pinkAccent),
                                onPressed: () async {
                                  setState(() {
                                    showSpinner = true;
                                  });
                                  try {
                                    final FirebaseAuth _auth = FirebaseAuth.instance;
                                    final newUser =
                                    await _auth.createUserWithEmailAndPassword(
                                        email: email, password: password);

                                    String userId = newUser.user!.uid;

                                    DatabaseReference dbRef =
                                    FirebaseDatabase.instance.reference().child('ModelUser').child(userId);
                                    dbRef.set({'userName': username, 'email': email, 'phoneNumber': phoneNumber, 'userId': userId});

                                    Navigator.of(context).pushReplacement(
                                      MaterialPageRoute(
                                        builder: (BuildContext context) => LoginScreen(),
                                      ),
                                    );
                                    if (newUser != null) {
                                      Navigator.of(context).pushReplacement(
                                        MaterialPageRoute(
                                          builder: (BuildContext context) => TermsPage(),
                                        ),
                                      );
                                    }
                                  } catch (e) {
                                    print(e);
                                  }
                                  setState(() {
                                    showSpinner = false;
                                  });
                                },
                                child: const Padding(
                                  padding: EdgeInsets.symmetric(vertical: 18.0),
                                  child: Text(
                                    'Sign Up',
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
                            'Already Have an Account? ',
                            style: TextStyle(fontSize: 16),
                          ),
                          InkWell(
                            child: const Text(
                              'Sign In',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.pinkAccent,
                                  fontSize: 16),
                            ),
                            onTap: () async {
                              setState(() async {
                                Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) {
                                    return LoginScreen();
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
}

//
// class _RegistrationScreenState extends State<RegistrationScreen> {
//   final _auth = FirebaseAuth.instance;
//   late String email;
//   late String password;
//   late String phoneNumber;
//   late String username;
//
//   bool showSpinner = false;
//
//   GestureTapCallback _handleLoginTap() {
//     return () {
//       Navigator.of(context).push(
//         MaterialPageRoute(builder: (context) => LoginScreen()),
//       );
//     };
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       resizeToAvoidBottomInset: false,
//       backgroundColor: Colors.white,
//       body: Container(
//         // inAsyncCall: showSpinner,
//         child: Padding(
//           padding: EdgeInsets.symmetric(horizontal: 24.0, vertical: 100.0),
//           child: SingleChildScrollView(
//             child: Container(
//               height: 600.0,
//               decoration: BoxDecoration(
//                 color: Colors.white54,
//                 borderRadius: BorderRadius.all(Radius.circular(32.0)),
//               ),
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 crossAxisAlignment: CrossAxisAlignment.stretch,
//                 children: <Widget>[
//                   Text(
//                     'Create Account',
//                     textAlign: TextAlign.center,
//                     style: TextStyle(
//                       fontSize: 40.0,
//                       fontWeight: FontWeight.w900,
//                     ),
//                   ),
//                   SizedBox(
//                     height: 20.0,
//                   ),
//                   TextField(
//                       keyboardType: TextInputType.text,
//                       textAlign: TextAlign.center,
//                       onChanged: (value) {
//                         username = value;
//                         //Do something with the user input.
//                       },
//                       decoration: kTextFieldDecoration.copyWith(
//                         hintText: 'Enter Username',
//                       )),
//                   SizedBox(
//                     height: 20.0,
//                   ),
//                   TextField(
//                       keyboardType: TextInputType.emailAddress,
//                       textAlign: TextAlign.center,
//                       onChanged: (value) {
//                         email = value;
//                       },
//                       decoration: kTextFieldDecoration.copyWith(
//                           hintText: 'Enter Your Email')),
//                   SizedBox(
//                     height: 20.0,
//                   ),
//                   TextField(
//                       obscureText: true,
//                       textAlign: TextAlign.center,
//                       onChanged: (value) {
//                         password = value;
//                       },
//                       decoration: kTextFieldDecoration.copyWith(
//                           hintText: 'Enter your Password')),
//                   SizedBox(
//                     height: 20.0,
//                   ),
//                   TextField(
//                       obscureText: true,
//                       textAlign: TextAlign.center,
//                       onChanged: (value) {
//                         password = value;
//                       },
//                       decoration: kTextFieldDecoration.copyWith(
//                           hintText: 'Re-Enter your Password')),
//                   SizedBox(
//                     height: 20.0,
//                   ),
//                   TextField(
//                       obscureText: true,
//                       textAlign: TextAlign.center,
//                       onChanged: (value) {
//                         phoneNumber = value;
//                       },
//                       decoration: kTextFieldDecoration.copyWith(
//                           hintText: 'Enter your Phone Number')),
//                   SizedBox(
//                     height: 20.0,
//                   ),
//                   RoundedButton(
//                       colour: Colors.pinkAccent,
//                       title: 'Register',
//                       onPressed: () async {
//                         setState(() {
//                           showSpinner = true;
//                         });
//                         try {
//                           final newUser =
//                           await _auth.createUserWithEmailAndPassword(
//                               email: email, password: password);
//
//                           String userId = newUser.user!.uid;
//
//                           DatabaseReference dbRef =
//                           FirebaseDatabase.instance.reference().child('ModelUser').child(userId);
//                           dbRef.set({'userName': username, 'email': email, 'phoneNumber': phoneNumber, 'userId': userId});
//
//                           Navigator.of(context).pushReplacement(
//                             MaterialPageRoute(
//                               builder: (BuildContext context) => LoginScreen(),
//                             ),
//                           );
//                           if (newUser != null) {
//                             Navigator.of(context).pushReplacement(
//                               MaterialPageRoute(
//                                 builder: (BuildContext context) => NewsPageScreen(),
//                               ),
//                             );
//                           }
//                         } catch (e) {
//                           print(e);
//                         }
//                         setState(() {
//                           showSpinner = false;
//                         });
//                       }),
//                   SizedBox(height: 20),
//                   RichText(
//                     textAlign: TextAlign.center,
//                     text: TextSpan(
//                       text: 'Already have an account? ',
//                       style: TextStyle(
//                         color: Colors.black,
//                         fontSize: 20,
//                         fontStyle: FontStyle.normal,
//                       ),
//                       children: <TextSpan>[
//                         TextSpan(
//                           text: 'Login',
//                           style: TextStyle(
//                             color: Colors.blue,
//                             decoration: TextDecoration.underline,
//                           ),
//                           recognizer: TapGestureRecognizer()
//                             ..onTap = () {
//                               Navigator.of(context).push(
//                                 MaterialPageRoute(builder: (context) => LoginScreen()),
//                               );
//                             },
//                         ),
//                       ],
//                     ),
//                   )
//                 ],
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
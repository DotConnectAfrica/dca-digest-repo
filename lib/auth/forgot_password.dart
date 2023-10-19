import 'package:dca_digital_digests/auth/sign_up_screen.dart';
import 'package:flutter/cupertino.dart';

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';



class ForgotPassword extends StatefulWidget {
  const ForgotPassword({super.key});

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  bool emailChosen = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Align(
              alignment: Alignment.centerLeft,
              child: IconButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  icon: const Icon(
                    Icons.chevron_left_rounded,
                    size: 55,
                  )),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30.0),
              child: Column(
                children: [
                  const SizedBox(
                    height: 27.5,
                  ),
                  const Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Forgot password?',
                      style: TextStyle(
                          fontSize: 32.5, fontWeight: FontWeight.w500),
                    ),
                  ),
                  const SizedBox(
                    height: 27.5,
                  ),
                  const Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Enter email or phone number to retrieve password',
                      style: TextStyle(
                          fontSize: 16.5, fontWeight: FontWeight.w400),
                    ),
                  ),
                  const SizedBox(
                    height: 27.5,
                  ),
                  Container(
                    height: 55,
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.pinkAccent,
                        style: BorderStyle.solid,
                        width: 1.5,
                      ),
                      color: Colors.transparent,
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                    child: Row(
                      children: [
                        Expanded(
                            child: InkWell(
                              onTap: () {
                                if (emailChosen == false) {
                                  setState(() {
                                    emailChosen = !emailChosen;
                                  });
                                }
                              },
                              child: Container(
                                height: 55,
                                decoration: BoxDecoration(
                                  color: emailChosen
                                      ? Colors.pinkAccent
                                      : Colors.transparent,
                                  borderRadius: BorderRadius.circular(4.0),
                                ),
                                child: Center(
                                  child: Text(
                                    'Email',
                                    style: TextStyle(
                                        fontSize: 16.5,
                                        fontWeight: FontWeight.w400,
                                        color: emailChosen
                                            ? Colors.white
                                            : Colors.grey),
                                  ),
                                ),
                              ),
                            )),
                        Expanded(
                            child: InkWell(
                              onTap: () {
                                if (emailChosen == true) {
                                  setState(() {
                                    emailChosen = !emailChosen;
                                  });
                                }
                              },
                              child: Container(
                                height: 55,
                                decoration: BoxDecoration(
                                  color: !emailChosen
                                      ? Colors.pinkAccent
                                      : Colors.transparent,
                                  borderRadius: BorderRadius.circular(4.0),
                                ),
                                child: Center(
                                  child: Text(
                                    'Phone number',
                                    style: TextStyle(
                                        fontSize: 16.5,
                                        fontWeight: FontWeight.w400,
                                        color: !emailChosen
                                            ? Colors.white
                                            : Colors.grey),
                                  ),
                                ),
                              ),
                            ))
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 27.5,
                  ),
                  !emailChosen
                      ? TextFormField(
                    onSaved: (String? value) {},

                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Phone number is required';
                      } else {
                        return null;
                      }
                    },
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5.0),
                        borderSide: const BorderSide(
                          color: Color.fromARGB(255, 202, 202, 202),
                        ),
                      ),
                      prefixText: '+254 ',
                      prefixStyle: const TextStyle(
                        color: Colors.black,
                      ),
                      labelText: 'Phone Number',
                    ),
                    // inputFormatters: <TextInputFormatter>[
                    //   WhitelistingTextInputFormatter.digitsOnly
                    // ],
                  )
                      : TextFormField(
                    onSaved: (String? value) {},
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
                      // suffixIcon: IconButton(
                      //   onPressed: () {
                      //     emailController.clear();
                      //   },
                      //   icon: const Icon(Icons.clear),
                      // ),
                      labelText: 'Email',
                      // errorText: _error ? null : "Invalid Input",
                    ),
                  ),
                  const SizedBox(
                    height: 27.5,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(5.0)),
                              primary: Colors.pinkAccent),
                          onPressed: () {
                            // Navigator.of(context).push(MaterialPageRoute(
                            //   builder: (context) {
                            //     return const Otp();
                            //   },
                            // ));
                          },
                          child: const Padding(
                            padding: EdgeInsets.symmetric(vertical: 18.0),
                            child: Text(
                              'Request OTP',
                              style:
                              TextStyle(color: Colors.white, fontSize: 16),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 27.5,
                  ),
                  const Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'By providing your phone number, I hereby agree to the terms and conditions of this app in use.',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: 16.5,
                          fontWeight: FontWeight.w400,
                          color: Colors.grey),
                    ),
                  ),
                  const SizedBox(
                    height: 27.5,
                  ),
                  Row(
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
                        onTap: () {
                          Navigator.of(context)
                              .pushReplacement(MaterialPageRoute(
                            builder: (context) {
                              return RegistrationScreen();
                            },
                          ));
                        },
                      )
                    ],
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

//
// class ForgotPassword extends StatelessWidget {
//   final TextEditingController _emailController = TextEditingController();
//
//   void _resetPassword(BuildContext context) async {
//     try {
//       var auth;
//       await FirebaseAuth.instance.sendPasswordResetEmail(
//         email: _emailController.text,
//         // Add this line to include reCAPTCHA token.
//         actionCodeSettings: auth.ActionCodeSettings(
//           // Set the URL users will be redirected to after password reset.
//           url: 'https://www.example.com/?email=${_emailController.text}',
//           // Your app dynamic link domain (optional).
//           dynamicLinkDomain: "example.page.link",
//         ),
//       );
//       // Show a success message or navigate to the login page.
//     } catch (e) {
//       // Show an error message.
//       print("Error sending password reset email: $e");
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Forgot Password'),
//       ),
//       body: Padding(
//         padding: EdgeInsets.all(16.0),
//         child: Column(
//           children: [
//             TextFormField(
//               controller: _emailController,
//               decoration: InputDecoration(labelText: 'Email'),
//             ),
//             SizedBox(height: 16.0),
//             ElevatedButton(
//               onPressed: () => _resetPassword(context),
//               child: Text('Reset Password'),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

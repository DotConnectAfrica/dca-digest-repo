import 'package:dca_digital_digests/screens/terms.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:share/share.dart';

import '../auth/login.dart';
import 'email_sender.dart';
import 'help_center.dart';


class ScreenMyAccount extends StatefulWidget {
  const ScreenMyAccount({Key? key}) : super(key: key);

  @override
  State<ScreenMyAccount> createState() => _ScreenMyAccountState();
}

class _ScreenMyAccountState extends State<ScreenMyAccount> {
  @override
  Widget build(BuildContext context) {



    return Scaffold(
      body: NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return <Widget>[
            CupertinoSliverNavigationBar(
              leading: Material(
                child: InkWell(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Icon(
                    Icons.arrow_back,
                    color: Colors.black,
                  ),
                ),
              ),
              largeTitle: Text('My Account'),
            ),
          ];
        },
        body: Container(
          margin: EdgeInsets.only(top: 16, right: 16, left: 16),
          child: SingleChildScrollView(
            child: Column(
              children: [
                first_tile(),
                SizedBox(
                  height: 32,
                ),
                SizedBox(
                  height: 24,
                ),
                Card(
                  child: Padding(
                    padding: const EdgeInsets.only(
                        top: 16.0, bottom: 16, right: 8, left: 8),
                    child: Column(
                      children: [
                        Container(
                          margin: EdgeInsets.only(top: 8, bottom: 8),
                          child: InkWell(
                            onTap: () {
                              Navigator.push(
                                context,
                                CupertinoPageRoute(
                                  builder: (context) => EmailSender(),
                                ),
                              );
                            },
                            child: Row(
                              children: [
                                SizedBox(
                                  width: 8,
                                ),
                                Icon(
                                  Icons.shield_outlined,
                                  size: 14,
                                ),
                                SizedBox(
                                  width: 16,
                                ),
                                Expanded(
                                    child: Text('Send Feedback',
                                        style: TextStyle(fontSize: 13))),
                                Icon(
                                  Icons.arrow_forward,
                                  size: 16,
                                  color: Colors.grey,
                                ),
                              ],
                            ),
                          ),
                        ),
                        Divider(),
                        Container(
                          margin: EdgeInsets.only(top: 8, bottom: 8),
                          child: InkWell(
                            onTap: () {
                              final RenderBox box = context.findRenderObject() as RenderBox;
                              Share.share('Check out Digital Digest App at: https://play.google.com/store/apps/details?id=com.digitaldigest',
                                  subject: 'Digital Digest App',
                                  sharePositionOrigin: box.localToGlobal(Offset.zero) & box.size);
                            },
                            child: Row(
                              children: [
                                SizedBox(
                                  width: 8,
                                ),
                                Icon(
                                  Icons.person_add_alt_outlined,
                                  size: 14,
                                ),
                                SizedBox(
                                  width: 16,
                                ),
                                Expanded(
                                    child: Text('Refer a Friend',
                                        style: TextStyle(fontSize: 13))),
                                Icon(
                                  Icons.arrow_forward,
                                  size: 16,
                                  color: Colors.grey,
                                ),
                              ],
                            ),
                          ),
                        ),
                        Divider(),
                        Container(
                          margin: EdgeInsets.only(top: 8, bottom: 8),
                          child: InkWell(
                            onTap: (){
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (BuildContext context) => HelpCenter(),
                                ),
                              );

                            },

                            child: Row(
                              children: [
                                SizedBox(
                                  width: 8,
                                ),
                                Icon(
                                  Icons.question_mark_outlined,
                                  size: 14,
                                ),
                                SizedBox(
                                  width: 16,
                                ),
                                Expanded(
                                    child: Text('Learn More About Us',
                                        style: TextStyle(fontSize: 13))),
                                Icon(
                                  Icons.arrow_forward,
                                  size: 16,
                                  color: Colors.grey,
                                ),
                              ],
                            ),
                          ),
                        ),
                        Divider(),
                        Container(
                          margin: EdgeInsets.only(top: 8, bottom: 8),
                          child: InkWell(
                            onTap: (){
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (BuildContext context) => Terms(1),
                                ),
                              );

                            },
                            child: Row(
                              children: [
                                SizedBox(
                                  width: 8,
                                ),
                                Icon(
                                  Icons.info_outline,
                                  size: 14,
                                ),
                                SizedBox(
                                  width: 8,
                                ),
                                Expanded(
                                    child: Text('Terms and Conditons',
                                        style: TextStyle(fontSize: 13))),
                                Icon(
                                  Icons.arrow_forward,
                                  size: 16,
                                  color: Colors.grey,
                                ),
                              ],
                            ),
                          ),
                        ),
                        Divider(),
                        Container(
                          margin: EdgeInsets.only(top: 8, bottom: 8),
                          child: InkWell(
                            onTap: (){
                              // _showLogoutConfirmationDialog(context);

                              //log out of firebase
                              FirebaseAuth.instance.signOut();
                              Navigator.of(context).pushReplacement(
                                MaterialPageRoute(
                                  builder: (BuildContext context) => LoginScreen(),
                                ),
                              );

                            },

                            child: Row(
                              children: [
                                SizedBox(
                                  width: 8,
                                ),
                                Icon(
                                  Icons.logout,
                                  size: 14,
                                ),
                                SizedBox(
                                  width: 16,
                                ),
                                Expanded(
                                    child: Text('Log Out',
                                        style: TextStyle(fontSize: 13))),
                                Icon(
                                  Icons.arrow_forward,
                                  size: 16,
                                  color: Colors.grey,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _showLogoutConfirmationDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Confirm Logout'),
          content: Text('Are you sure you want to logout?'),
          actions: <Widget>[
            TextButton(
              child: Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
            ),
            TextButton(
              child: Text('Logout'),
              onPressed: () async {
                // Log out of Firebase
                await FirebaseAuth.instance.signOut();

                // Navigate to the login screen
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(
                    builder: (BuildContext context) => LoginScreen(),
                  ),
                );
              },
            ),
          ],
        );
      },
    );
  }

  Widget first_tile() {

    final user = FirebaseAuth.instance.currentUser;
    final email = user?.email;
    final name = user?.displayName;
    final phoneNumber = user?.phoneNumber.toString();

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          // margin: EdgeInsets.only(left: 16),
          child: Column(
            children: [
              SizedBox(
                height: 8,
              ),
              InkWell(
                onTap: () {},
                child: Container(
                  child: Row(
                    children: [
                      Image.asset(
                        'assets/images/default_avatar.png',
                        height: 50,
                        width: 50,
                        color: Colors.pink,
                      ),
                      SizedBox(
                        width: 8,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '',
                            style: TextStyle(
                                fontSize: 15, fontWeight: FontWeight.w400),
                          ),
                          Text(
                            '$email',
                            style: TextStyle(
                              fontSize: 13,
                              color: Colors.grey[600],
                            ),
                          ),
                          Text(
                            '',
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.grey[600],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }


}

Future<void> _log_out(context) async {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  await _auth.signOut();
  Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(builder: (context) => LoginScreen()),
          (Route<dynamic> route) => false);
}
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import 'learn_more_webview.dart';


class HelpCenter extends StatefulWidget {
  const HelpCenter({Key? key}) : super(key: key);

  @override
  State<HelpCenter> createState() => _HelpCenterState();
}

class _HelpCenterState extends State<HelpCenter> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          iconTheme: IconThemeData(color: Colors.black),
          title: Text("Learn More",style: TextStyle(color: Colors.black),),
          leading: IconButton(
            icon: Icon(Icons.arrow_back_ios),
            onPressed: () => Navigator.of(context).pop(),
          ),
          centerTitle: true,
        ),
        body: ListView(
          children: <Widget>[
            SizedBox(
              height: 20.0,
            ),
            GestureDetector(
              onTap: () {
                final link = 'https://dotconnectafrica.com/vision-and-mission/';
                final title = "Vision and Mission";

                Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => LearnWebView(title,link)));
              },
              child: Container(
                margin: EdgeInsets.only(top: 8, bottom: 8, left: 16, right: 16),
                decoration: BoxDecoration(
                  color: Colors.purpleAccent,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  'Vision and Mission',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                  ),

                ),
                padding: EdgeInsets.all(16),
                alignment: Alignment.center,
              ),
            ),
            SizedBox(
              height: 20.0,
            ),
            GestureDetector(
              onTap: () {
                final link = 'https://dotconnectafrica.com/about/key-pillars/';
                final title = "Key pillars";

                Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => LearnWebView(title,link)));
              },
              child: Container(// Open the website li
                margin: EdgeInsets.only(top: 8, bottom: 8, left: 16, right: 16),
                decoration: BoxDecoration(
                  color: Colors.purpleAccent,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  'Key pillars',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                  ),

                ),
                padding: EdgeInsets.all(16),
                alignment: Alignment.center,
              ),
            ),
            SizedBox(
              height: 20.0,
            ),
            GestureDetector(
              onTap: () {
                final link = 'https://dotconnectafrica.org/global-advisory-leadership-board/';
                final title = "Global Advisory Leadership Board";

                Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => LearnWebView(title,link)));
              },
              child: Container(// Open the website li
                margin: EdgeInsets.only(top: 8, bottom: 8, left: 16, right: 16),
                decoration: BoxDecoration(
                  color: Colors.purpleAccent,
                  borderRadius: BorderRadius.circular(20),
                ),  // Replace with your desired background color
                child: Text(
                  'Global Advisory Leadership Board',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                  ),

                ),
                padding: EdgeInsets.all(16),
                alignment: Alignment.center,
              ),
            ),
            SizedBox(
              height: 20.0,
            ),
            GestureDetector(
              onTap: () {
                final link = 'https://dotconnectafrica.org/about/founder-profile/';
                final title = "Founder Profiles";

                Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => LearnWebView(title,link)));
              },
              child: Container(//
                padding: EdgeInsets.all(16),
                margin: EdgeInsets.only(top: 8, bottom: 8, left: 16, right: 16),
                decoration: BoxDecoration(
                  color: Colors.purpleAccent,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  'Founder Profiles',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                  ),

                ),
                alignment: Alignment.center,
              ),
            ),

            SizedBox(
              height: 20.0,
            ),
            GestureDetector(
              onTap: () {
                final link = "https://dotconnectafrica.com/contact/initiatives/";
                final title = "Our Initiatives";

                Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => LearnWebView(title,link)));
                // launch('https://dotconnectafrica.com/contact/initiatives/');
              },
              child: Container(// Open the website li
                margin: EdgeInsets.only(top: 8, bottom: 8, left: 16, right: 16),
                decoration: BoxDecoration(
                  color: Colors.purpleAccent,
                  borderRadius: BorderRadius.circular(20),
                ),  // Replace with your desired background color
                child: Text(
                  'Our Initiatives',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                  ),

                ),
                padding: EdgeInsets.all(16),
                alignment: Alignment.center,
              ),
            ),
            SizedBox(
              height: 20.0,
            ),
            GestureDetector(
              onTap: () {
                final link = 'https://dotconnectafrica.com/about/privacy-policy/';
                final title = "Privacy Policy";

                Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => LearnWebView(title,link)));
              },
              child: Container(// Open the website li
                margin: EdgeInsets.only(top: 8, bottom: 8, left: 16, right: 16),
                decoration: BoxDecoration(
                  color: Colors.purpleAccent,
                  borderRadius: BorderRadius.circular(20),
                ), // Replace with your desired background color
                child: Text(
                  'Privacy Policy',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                  ),

                ),
                padding: EdgeInsets.all(16),
                alignment: Alignment.center,
              ),
            )
          ],
        ),
      ),
    );
  }
}

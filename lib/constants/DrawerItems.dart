import 'package:flutter/material.dart';

//this is the drawer items
class DrawerItems{
  static List drawerItems = [
    {
      "icon": Icons.person,
      "name": "My Profile",
      "description": "My account information summary",
      'type': 1,
    },
    {
      "icon": Icons.assignment_outlined,
      "name": "Learn More",
      "description": "Get to know more about DCA Digest",
      'type': 1,
    },
    {
      "icon": Icons.assignment_outlined,
      "name": "Terms and Conditions",
      "description": "A list of all available facilitators",
      'type': 1,
    },
    {
      "icon": Icons.assignment_outlined,
      "name": "About DCA DIGEST",
      "description": "A dca digital digest news",
      'type': 1,
    },
    {
      "icon": Icons.logout,
      "name": "LogOut",
      "description": "Sign out of the App",
      'type': 1,
    },
  ];
}
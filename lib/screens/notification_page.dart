import 'package:flutter/material.dart';

class NotificationPage extends StatelessWidget {
  final List<String> notifications = []; // Replace with your actual list of notifications

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Notifications'),
      ),
      body: Container(
        padding: EdgeInsets.all(16.0),
        child: notifications.isNotEmpty
            ? ListView.builder(
          itemCount: notifications.length,
          itemBuilder: (context, index) {
            return ListTile(
              title: Text(
                notifications[index],
                style: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              subtitle: Text(
                'Notification details here',
                style: TextStyle(
                  fontSize: 14.0,
                  color: Colors.grey[600],
                ),
              ),
              leading: Icon(
                Icons.notifications,
                color: Colors.pinkAccent,
              ),
              // Add more notification details as needed
            );
          },
        )
            : Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.notifications_off,
                size: 80.0,
                color: Colors.grey,
              ),
              SizedBox(height: 16.0),
              Text(
                'No notifications available',
                style: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

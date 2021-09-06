import 'package:flutter/material.dart';
import 'package:flutter_app103/models/notification.dart';

class NotificationScreen extends StatefulWidget {
  NotificationScreen({Key? key}) : super(key: key);

  @override
  _NotificationScreenState createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  final List<Notifications> notificationList = [
    Notifications(
      text: 'Use promocode "new2021" to get 20 % off',
    ),
    Notifications(
      text: 'Limited time sale on all bakery items1',
    ),
    Notifications(
      text: 'Limited time sale on all bakery items1',
    ),
    Notifications(
      text: 'Limited time sale on all bakery items1',
    ),
    Notifications(
      text: 'Limited time sale on all bakery items1',
    ),
    Notifications(
      text: 'Limited time sale on all bakery items1',
    ),
    Notifications(
      text: 'Limited time sale on all bakery items1',
    ),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.indigo[100],
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          "Notifications",
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
      ),
      body: ListView.builder(
          itemCount: notificationList.length,
          itemBuilder: (context, index) {
            return Container(
              height: 100,
              padding: EdgeInsets.all(30),
              margin: EdgeInsets.all(10),
              decoration: BoxDecoration(
                  color: Colors.white24,
                  borderRadius: BorderRadius.circular(20)),
              child: Text(notificationList[index].text!),
            );
          }),
    );
  }
}

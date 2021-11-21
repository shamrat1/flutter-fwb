import 'package:flutter/material.dart';
import 'package:flutter_app103/models/NotificationMessage.dart';
import 'package:flutter_app103/models/common/notification.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class NotificationScreen extends StatefulWidget {
  NotificationScreen({Key? key}) : super(key: key);

  @override
  _NotificationScreenState createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  
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
      body: Consumer(
        builder: (context, watch, child) {
          var notificationList = watch(messageListProvider);
          if(notificationList.length == 0) return Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            color: Colors.white,
            child: Center(
              child: Text("No Notifications"),
            ),
          );
          return ListView.builder(
              itemCount: notificationList.length,
              itemBuilder: (context, index) {
                return Container(
                  height: 100,
                  padding: EdgeInsets.all(30),
                  margin: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      color: Colors.white24,
                      borderRadius: BorderRadius.circular(20)),
                  child: Text(notificationList[index].body),
                );
              });
        }
      ),
    );
  }
}

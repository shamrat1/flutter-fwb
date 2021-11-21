import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
//import 'package:flutter_app103/screens/search_page.dart';
import 'package:flutter_app103/Authentication/signup_page.dart';
import 'package:flutter_app103/models/NotificationMessage.dart';
import 'package:flutter_app103/screens/home_page.dart';
import 'package:flutter_app103/state/AuthenticatedUserState.dart';
import 'package:flutter_app103/state/FavoriteProductsState.dart';
import 'package:flutter_app103/state/FollowingUsersState.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:geolocator/geolocator.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  FirebaseMessaging.onBackgroundMessage(messageHandler);

  runApp(
    ProviderScope(
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: MyAppHome(),
      ),
    ),
  );

    
}
Future<void> messageHandler(RemoteMessage message) async {
  final providerContainer = ProviderContainer();
  final storage = new FlutterSecureStorage();

  providerContainer.read(messageListProvider.notifier).add(NotificationMessage(
          title: message.notification!.title!,
          body: message.notification!.body!,
          id: DateTime.now().toString()));
      var string = json.encode(providerContainer.read(messageListProvider));
      await storage.write(key: "notifications", value: string);
}
class MyAppHome extends StatefulWidget {
  @override
  State<MyAppHome> createState() => _MyAppHomeState();
}

class _MyAppHomeState extends State<MyAppHome> {
  bool _loading = true;
  bool _authenticated = false;
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;

  @override
  void initState() {
    super.initState();
    _firebaseMessaging.getToken();
    _setupAuthenticatedUser();
    _initFirebaseMessingConfigs();
    FirebaseMessaging.onMessage.listen((event) async {
       
          context.read(messageListProvider.notifier).add(
            NotificationMessage(
              title: event.notification!.title!,
              body: event.notification!.body!,
              id: DateTime.now().toString(),
            ),
          );
          var string = json.encode(context.read(messageListProvider));
          await FlutterSecureStorage().write(key: "notifications", value: string);

      });

      FirebaseMessaging.onMessageOpenedApp.listen((event) async {
        
          context.read(messageListProvider.notifier).add(
            NotificationMessage(
              title: event.notification!.title!,
              body: event.notification!.body!,
              id: DateTime.now().toString(),
            ),
          );
          var string = json.encode(context.read(messageListProvider));
          await FlutterSecureStorage().write(key: "notifications", value: string);

      });
  }

    void _initFirebaseMessingConfigs() async {
    NotificationSettings settings = await _firebaseMessaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );

    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      print('User granted permission');
    } else if (settings.authorizationStatus == AuthorizationStatus.provisional) {
      print('User granted provisional permission');
    } else {
      print('User declined or has not accepted permission');
    }
  }

  void _setupAuthenticatedUser() async {
    Geolocator.requestPermission();

    // -------------
    // to auto login uncomment the following line
    // -------------
    // await FlutterSecureStorage().write(key: "user_id",value : "6klhQ8IK9PPtfRXZXWHt");

    var userDocId = await FlutterSecureStorage().read(key: "user_id");
    // Logger().d("userdocid: $userDocId");
    if (userDocId != null) {
      var user = await FirebaseFirestore.instance
          .collection("/users")
          .doc(userDocId)
          .get();

      // Logger().wtf(user.exists);
      var users = await FirebaseFirestore.instance
          .collection("/users")
          .where("phone", isEqualTo: user.get("phone"))
          .limit(1)
          .get();
      if (users.size > 0) {
        // Logger().w(users.docs.first.data());
        var followingUsers = await FirebaseFirestore.instance
            .collection("follows")
            .where("user_id", isEqualTo: userDocId)
            .get();
        if (followingUsers.size > 0) {
          List<String> following = [];
          followingUsers.docs.forEach((element) {
            following.add((element.data() as dynamic)["following_id"]);
          });
          context.read(FollowingUsersProvider.notifier).change(following);
          // Logger().wtf(following);
        }
        context.read(authenticatedUserProvider.notifier).change(UserModel(
              documentId: user.id,
              user: users.docs.first,
            ));
        context.read(favoriteProductsProvider.notifier).fetch();
        setState(() {
          _authenticated = true;
        });
      }
    }
    setState(() {
      _loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return _loading
        ? Center(
            child: CircularProgressIndicator(),
          )
        : (_authenticated ? HomePage() : SignupPage());
  }
}

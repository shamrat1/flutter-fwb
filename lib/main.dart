import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app103/Authentication/sign_in.dart';
import 'package:flutter_app103/models/message/message.dart';
import 'package:flutter_app103/screens/address.dart';
import 'package:flutter_app103/screens/checkout_101.dart';
import 'package:flutter_app103/screens/checkout_Payment.dart';
import 'package:flutter_app103/screens/checkout_address.dart';
import 'package:flutter_app103/screens/checkout_items.dart';
import 'package:flutter_app103/screens/delivery_details_screen.dart';
import 'package:flutter_app103/screens/edit_profile.dart';
import 'package:flutter_app103/Authentication/register_email.dart';
import 'package:flutter_app103/screens/empty_cart.dart';
import 'package:flutter_app103/screens/home_page.dart';
import 'package:flutter_app103/screens/map_screen.dart';
import 'package:flutter_app103/screens/message_list_screen.dart';
import 'package:flutter_app103/screens/notification_screen.dart';
import 'package:flutter_app103/screens/order_placed.dart';
import 'package:flutter_app103/screens/otp.dart';
import 'package:flutter_app103/screens/personal_information.dart';
//import 'package:flutter_app103/screens/search_page.dart';
import 'package:flutter_app103/Authentication/signup_page.dart';
import 'package:flutter_app103/screens/transaction.dart';
import 'package:flutter_app103/screens/upload_content.dart';
import 'package:flutter_app103/screens/verify_mobile_number.dart';
import 'package:flutter_app103/screens/wishlist_screen.dart';
import 'package:flutter_app103/state/AuthenticatedUserState.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:geolocator/geolocator.dart';
import 'package:logger/logger.dart';

import 'screens/profile_layout.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(
    ProviderScope(
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: MyAppHome(),
      ),
    ),
  );
}

class MyAppHome extends StatefulWidget {
  
  @override
  State<MyAppHome> createState() => _MyAppHomeState();
}

class _MyAppHomeState extends State<MyAppHome> {
  bool _loading = true;
  bool _authenticated = false;

  @override
  void initState() { 
    super.initState();
    _setupAuthenticatedUser();
  }

  void _setupAuthenticatedUser() async {
    Geolocator.requestPermission();
    await FlutterSecureStorage().deleteAll();
    // await FlutterSecureStorage().write(key: "user_id", value: "6klhQ8IK9PPtfRXZXWHt");
    var userDocId = await FlutterSecureStorage().read(key: "user_id");
    if(userDocId != null){
      var user = await FirebaseFirestore.instance.collection("/users").doc(userDocId).get();
      
      Logger().wtf(user.exists);
      var users = await FirebaseFirestore.instance.collection("/users").where("phone",isEqualTo: user.get("phone")).limit(1).get();
      if(users.size > 0){
        Logger().w(users.docs.first.data());
        context.read(authenticatedUserProvider.notifier).change(UserModel(
          documentId: user.id,
          user: users.docs.first,
        ));
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
    return _loading ? Center(child: CircularProgressIndicator(),) 
      : (_authenticated ? HomePage() : SignupPage());
  }
}

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

import 'screens/profile_layout.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ProfileLayout();
  }
}

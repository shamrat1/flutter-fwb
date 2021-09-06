import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SignupPage extends StatefulWidget {
  SignupPage({Key? key}) : super(key: key);

  @override
  _SignupPageState createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailIdController = TextEditingController();
  final TextEditingController phoneNumberController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.indigo[100],
      body: SafeArea(
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 30),
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                  height: 30,
                ),
                Text(
                  "FEMALEPRENEUR BAZAAR",
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.w700),
                ),
                SizedBox(
                  height: 50,
                ),
                Icon(
                  CupertinoIcons.person_crop_circle_fill,
                  size: 70,
                  color: Colors.black38,
                ),
                SizedBox(
                  height: 70,
                ),
                TextField(
                  controller: nameController,
                  decoration: InputDecoration(
                      prefixIcon: Icon(CupertinoIcons.person_crop_circle_fill),
                      hintText: "Name"),
                ),
                TextField(
                  controller: emailIdController,
                  decoration: InputDecoration(
                      prefixIcon: Icon(CupertinoIcons.envelope),
                      hintText: "Email Id"),
                ),
                TextField(
                  controller: phoneNumberController,
                  decoration: InputDecoration(
                      prefixIcon: Icon(CupertinoIcons.phone),
                      hintText: "Phone Number"),
                ),
                TextField(
                  controller: passwordController,
                  obscureText: true,
                  decoration: InputDecoration(
                      prefixIcon: Icon(CupertinoIcons.lock),
                      hintText: "Password"),
                ),
                ElevatedButton(
                  onPressed: () {},
                  child: Text("Sign In"),
                ),
                TextButton(
                    onPressed: () {},
                    child: Text(
                      "Not Registered yet?\nClick here to signup",
                      style: TextStyle(decoration: TextDecoration.underline),
                    )),
              ],
            ),
          ),
        ),
      ),
    );
  }

  onPressed() {}
}

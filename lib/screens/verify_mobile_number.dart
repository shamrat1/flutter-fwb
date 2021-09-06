import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class VerifyMobileNumber extends StatefulWidget {
  VerifyMobileNumber({Key? key}) : super(key: key);

  @override
  _VerifyMobileNumberState createState() => _VerifyMobileNumberState();
}

class _VerifyMobileNumberState extends State<VerifyMobileNumber> {
  final TextEditingController phoneNumberController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: Container(
        child: Column(
          children: [
            Text(
              "FEMALEPRENEUR BAZAAR",
              style: TextStyle(fontSize: 25, fontWeight: FontWeight.w700),
            ),
            SizedBox(
              height: 50,
            ),
            Text("Verify your mobile number"),
            SizedBox(
              height: 30,
            ),
            TextField(
              controller: phoneNumberController,
              decoration: InputDecoration(
                  prefixIcon: Icon(CupertinoIcons.phone_circle_fill),
                  hintText: "Phone number"),
            ),
            ElevatedButton(
              onPressed: () {},
              child: Text("Next"),
            ),
            Text("We will send you an OTP on this \n mobile number to verify.")
          ],
        ),
      ),
    ));
  }
}

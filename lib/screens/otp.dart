import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Otp extends StatefulWidget {
  Otp({Key? key}) : super(key: key);

  @override
  _OtpState createState() => _OtpState();
}

class _OtpState extends State<Otp> {
  final TextEditingController otpController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.indigo[100],
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
                Text("Enter OTP sent via sms"),
                SizedBox(
                  height: 30,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 100),
                  child: TextField(
                    style: TextStyle(decoration: TextDecoration.underline),
                    textAlign: TextAlign.center,
                    keyboardType: TextInputType.number,
                    controller: otpController,
                    decoration: InputDecoration(
                        hintText: "Enter your code:",
                        border: OutlineInputBorder(
                            borderSide: BorderSide(),
                            borderRadius: BorderRadius.circular(30))),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 50),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Icon(Icons.message),
                          Text(
                            "Resend OTP",
                          ),
                        ],
                      ),
                      Text("2.00"),
                    ],
                  ),
                ),
                ElevatedButton(
                  onPressed: () {},
                  child: Text("Next"),
                ),
                Text(
                    "We will send you an OTP on this \n mobile number to verify.")
              ],
            ),
          ),
        ));
  }
}

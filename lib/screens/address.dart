import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Address extends StatefulWidget {
  Address({Key? key}) : super(key: key);

  @override
  _AddressState createState() => _AddressState();
}

class _AddressState extends State<Address> {
  final TextEditingController addressController = TextEditingController();
  final TextEditingController landMarkController = TextEditingController();
  final TextEditingController pinCodeController = TextEditingController();

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
                Text(
                  "Address",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w300),
                ),
                TextField(
                  controller: addressController,
                  decoration: InputDecoration(hintText: "Address"),
                ),
                TextField(
                  controller: landMarkController,
                  decoration: InputDecoration(hintText: "Landmark"),
                ),
                TextField(
                  controller: pinCodeController,
                  decoration: InputDecoration(hintText: "pinCode"),
                ),
                Row(
                  children: [
                    Text("Home"),
                    Text("Office"),
                    Text("Others"),
                  ],
                ),
                Text("Set as default address"),
                ElevatedButton(
                  onPressed: () {},
                  child: Text("Update Using Location"),
                ),
                ElevatedButton(
                  onPressed: () {},
                  child: Text("confirm Address"),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

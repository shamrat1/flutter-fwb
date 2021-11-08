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
  late String valueChoose;
  List listItem = ["Item 1", "Item 2", "Item 3", "Item 4", "Item 5"];
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
                // Padding(
                //   padding: const EdgeInsets.only(left: 16, right: 16),
                //   decoration: BoxDecoration(
                //       border: Border.all(color: Colors.grey, width: 1),
                //       borderRadius: BorderRadius.circular(15)),
                //   child: DropdownButton(
                //     hint: Text("select Items: "),
                //     dropdownColor: Colors.grey,
                //     icon: Icon(Icons.arrow_drop_down),
                //     iconSize: 36,
                //     isExpanded: true,
                //     style: TextStyle(
                //       color: Colors.black,
                //       fontSize: 22,
                //     ),
                //     value: valueChoose,
                //     onChanged: (newValue) {
                //       setState(() {
                //         valueChoose = newValue;
                //       });
                //     },
                //   ),
                // ),
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

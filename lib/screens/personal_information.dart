import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PersonalInformation extends StatefulWidget {
  PersonalInformation({Key? key}) : super(key: key);

  @override
  _PersonalInformationState createState() => _PersonalInformationState();
}

class _PersonalInformationState extends State<PersonalInformation> {
  bool selected = false;
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailIdController = TextEditingController();
  final TextEditingController phoneNumberController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();
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
                  "Personal information",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w300),
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
                  keyboardType: TextInputType.number,
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
                TextField(
                  controller: confirmPasswordController,
                  obscureText: true,
                  decoration: InputDecoration(
                      prefixIcon: Icon(CupertinoIcons.lock),
                      hintText: "Confirm password"),
                ),
                Row(
                  children: [
                    Checkbox(
                        value: selected,
                        onChanged: (bool? value) {
                          setState(() {
                            selected = value!;
                          });
                        }),
                    Text("I have agreed to the terms & conditions."),
                  ],
                ),
                ElevatedButton(
                  onPressed: () {},
                  child: Text("Next"),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

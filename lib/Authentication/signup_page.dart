
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_app103/screens/home_page.dart';
import 'package:flutter_app103/state/AuthenticatedUserState.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SignupPage extends StatefulWidget {
  SignupPage({Key? key}) : super(key: key);

  @override
  _SignupPageState createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final TextEditingController nameController = TextEditingController();
  // final TextEditingController emailIdController = TextEditingController();
  final TextEditingController phoneNumberController = TextEditingController();
  // final TextEditingController passwordController = TextEditingController();
  final TextEditingController otpController = TextEditingController();
  bool _codeSent = false;
  String _verificationId = "";

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
                // TextField(
                //   controller: emailIdController,
                //   decoration: InputDecoration(
                //       prefixIcon: Icon(CupertinoIcons.envelope),
                //       hintText: "Email Id"),
                // ),
                TextField(
                  controller: phoneNumberController,
                  decoration: InputDecoration(
                      prefixIcon: Icon(CupertinoIcons.phone),
                      hintText: "Phone Number",
                      prefix: Text("+880 "),
                      enabled: _codeSent ? false : true,
                  ),
                  keyboardType: TextInputType.phone,
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  
                ),
                if(_codeSent)
                TextField(
                  controller: otpController,
                  decoration: InputDecoration(
                      prefixIcon: Icon(CupertinoIcons.lock),
                      hintText: "OTP"),
                      keyboardType: TextInputType.number,
                ),
                if(_codeSent == false)
                ElevatedButton(
                  onPressed: () async {
                    if(phoneNumberController.text.length == 10){
                    FirebaseFirestore.instance.collection("/users").where("phone",isEqualTo: "+880"+phoneNumberController.text).limit(1).get().then((value){
                      if(value.size > 0){
                        setState(() {
                          nameController.text = value.docs.first.data()["name"] ?? "";
                        });
                      }
                    });
                    _verify();
                    }else{
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Phone Number invalid.")));
                    }
                    
                  },
                  child: Text("Sign In"),
                ),

                if(_codeSent)
                ElevatedButton(
                  onPressed: () async {
                    if(nameController.text != null){
                      final AuthCredential credential = PhoneAuthProvider.credential(
                        verificationId: _verificationId,
                        smsCode: otpController.text,
                      );
                      UserCredential userCredential = await FirebaseAuth.instance.signInWithCredential(credential);
                      _setUser(userCredential);
                    }
                  },
                  child: Text("Verify & Login"),
                ),
                // TextButton(
                //     onPressed: () {},
                //     child: Text(
                //       "Not Registered yet?\nClick here to signup",
                //       style: TextStyle(decoration: TextDecoration.underline),
                //     )),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _verify(){
    FirebaseAuth.instance.verifyPhoneNumber(
      phoneNumber: "+880"+phoneNumberController.text,
      verificationCompleted: (PhoneAuthCredential credential) async {
        UserCredential userCredential = await FirebaseAuth.instance.signInWithCredential(credential);
        // PhoneAuthCredential()
      _setUser(userCredential);
      },
      verificationFailed: (FirebaseAuthException exception){
        print(exception.message);
        setState(() {
          _codeSent = false;
        });
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(exception.message!)));
      },
      codeSent: (String verificationID, int? resendToken){
        print("here");
        setState(() {
          _codeSent = true;
          _verificationId = verificationID;
        });
      },
      codeAutoRetrievalTimeout:(String verificationID){
        if(mounted){
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Code Auto Retrieval Timeout")));
          setState(() {
            // _codeSent = false;
            _verificationId = verificationID;
          });
        }
      },
    );
  }

  void _setUser(UserCredential userCredential) async {
    
    var users = await FirebaseFirestore.instance.collection("/users").where("phone",isEqualTo: userCredential.user?.phoneNumber).limit(1).get();
    
    print(userCredential.user);
    print(userCredential.user?.phoneNumber);
    print(users.size);
    // print(users.docs.first.data());

    if(users.docs.length > 0){
      // set as authenticated user
      _setAuthenticatedUser(users.docs.first);
    }else{
      // create new user entry
      await FirebaseFirestore.instance.collection("/users").add({
        "name" : nameController.text,
        "phone" : userCredential.user?.phoneNumber,
        "verified" : true,
        "created_at" : DateTime.now().toString(),
      });
      var userDoc = await FirebaseFirestore.instance.collection("/users").where("phone", isEqualTo: userCredential.user?.phoneNumber).limit(1).get();
      if(userDoc.size > 0) _setAuthenticatedUser(userDoc.docs.first);
      // than set authenticated user
    }
    Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (ctx) => HomePage()), (route) => false);
  }

  void _setAuthenticatedUser(QueryDocumentSnapshot<Map<String, dynamic>> user){
      context.read(authenticatedUserProvider.notifier).change(UserModel(
        documentId: user.id,
        user: user,
      ));
      FlutterSecureStorage().write(key: "user_id", value: user.id);
  }
}

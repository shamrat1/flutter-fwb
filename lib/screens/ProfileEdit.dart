

import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app103/screens/upload_content.dart';
import 'package:flutter_app103/state/AuthenticatedUserState.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logger/logger.dart';

class ProfileEdit extends StatefulWidget {
  const ProfileEdit({ Key? key }) : super(key: key);

  @override
  _ProfileEditState createState() => _ProfileEditState();
}

class _ProfileEditState extends State<ProfileEdit> {
  XFile? image;
  TextEditingController nameController = TextEditingController();
  TextEditingController categoryController = TextEditingController();
  TextEditingController bioController = TextEditingController();
  TextEditingController locationController = TextEditingController();
  bool _loading = false;

  @override
  void initState() {
    super.initState();
    var user = context.read(authenticatedUserProvider).user!.data();
    nameController.text = user["name"] != null ? user["name"] : "";
    categoryController.text = user["category"] != null ? user["category"] : "";
    bioController.text = user["bio"] != null ? user["bio"] : "";
    locationController.text = user["location"] != null ? user["location"] : "";
  }

  @override
  Widget build(BuildContext context) {
    var user = context.read(authenticatedUserProvider).user;

    return Scaffold(
      appBar: AppBar(
               backgroundColor: Colors.white,
        leading: Icon(
          CupertinoIcons.arrow_left,
          color: Colors.black,
        ),
        title: Text(
          "Edit Profile",
          style: TextStyle(color: Colors.black38),
        ),
      ),
      body: Container(
        height: MediaQuery.of(context).size.height - 56,
        padding: EdgeInsets.all(8),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                margin: EdgeInsets.symmetric(vertical: 25),
                width: 180,
                height: 180,
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(
                        fit: BoxFit.cover,
                        alignment: Alignment.topCenter,
                        image: user!.data()["image"] != null ?
                        NetworkImage(user.data()["image"]) 
                        : NetworkImage(
                          'https://images.unsplash.com/photo-1515886657613-9f3515b0c78f?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=1562&q=80'
                        ),
                      ),
                    ),
              ),
              Container(
                margin: EdgeInsets.symmetric(vertical: 8),
                child: TextFormField(
                  controller: nameController,
                  decoration: InputDecoration(
                    label: Text("Profile Name"),
                                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10))

                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(vertical: 8),
                child: TextFormField(
                  controller: categoryController,
                  decoration: InputDecoration(
                    label: Text("Category"),
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(10))
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(vertical: 8),
                child: TextFormField(
                  controller: bioController,
                  decoration: InputDecoration(
                    label: Text("Bio"),
                                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10))

                  ),
                  maxLines: 5,
                  
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(vertical: 8),
                child: TextFormField(
                  controller: locationController,
                  decoration: InputDecoration(
                    label: Text("Location"),
                                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10))

                  ),
                  
                ),
              ),
              Container(
              height: 200,
              decoration: BoxDecoration(
                  color: image == null ? Colors.black38 : null,
                  image: image != null
                      ? DecorationImage(
                          fit: BoxFit.cover,
                          alignment: Alignment.topCenter,
                          image: FileImage(File(image!.path)))
                      : null),
              alignment: Alignment.center,
              child: image == null
                  ? GestureDetector(
                      onTap: () async {
                        final ImagePicker _picker = ImagePicker();
                        final XFile? _image = await _picker.pickImage(
                            source: ImageSource.gallery);
                        setState(() {
                          image = _image;
                        });
                      },
                      child: Icon(Icons.add_a_photo_outlined),
                    )
                  : SizedBox.shrink(),
              ),
              Container(
                margin: EdgeInsets.symmetric(vertical: 25, horizontal: 30),
                child: ElevatedButton(
              style: ElevatedButton.styleFrom(primary: Colors.indigo[50]),
              onPressed: () async {
                setState(() {
                  _loading = true;
                });
                var userId = context.read(authenticatedUserProvider).documentId;
                var data = {
                  "name" : nameController.text,
                  "category" : categoryController.text,
                  "bio" : bioController.text,
                  "location" : locationController.text,
                };
                if(image != null){
                  var imagePath = await uploadImage(File(image!.path), "users");
            
                  data.addAll({
                    "image" : imagePath
                  });
                }
                  await FirebaseFirestore.instance
                   .collection("/users").doc(userId).update(data);
                   var user = await FirebaseFirestore.instance.collection("/users").where("phone", isEqualTo: (context.read(authenticatedUserProvider).user!.data() as dynamic)["phone"]).limit(1).get();

                   context.read(authenticatedUserProvider.notifier).change(
                     UserModel(
                       documentId: userId,
                       user: user.docs.first
                     )
                   );
                   ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Profile Updated.")));

                Logger().d(data);
                
                setState(() {
                  _loading = false;
                });
                Navigator.of(context).pop();
              },
              child: _loading ? CircularProgressIndicator() : Text(
                'Update Profile',
                style: TextStyle(color: Colors.indigo[900]),
              ),
            ),
              )
            ],
          ),
        ),
      ),
    );
  }


  Future<String> uploadImage(File _image,String collection) async {
    try {
      
      var uploadTask = await FirebaseStorage.instance
          .ref()
          .child('$collection/${context.read(authenticatedUserProvider).documentId}_${DateTime.now()}')
          .putFile(_image);

      print('File Uploaded');

      var returnURL = "";
      returnURL = await (uploadTask).ref.getDownloadURL();
      return returnURL;
    } catch (e) {
      Logger().e(e.toString());
      setState(() {
        _loading = false;
      });

      throw Exception(e);
    }
  }
}
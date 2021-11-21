

import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app103/screens/MapScreen.dart';
import 'package:flutter_app103/screens/upload_content.dart';
import 'package:flutter_app103/state/AuthenticatedUserState.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
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
  double? lat;
  double? long;

  CameraPosition cameraPosition = CameraPosition(
    target: LatLng(23.6850,90.3563),
    zoom: 8
  );
  Set<Marker> markers = const <Marker>{};


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
        actions: [
          IconButton(
            onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (ctx) => MapScreen())),
            icon: Icon(Icons.location_on_rounded, color: Colors.black,),
          ),
        ],
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
                margin: EdgeInsets.symmetric(vertical: 8),
                child: TextButton(
                  onPressed: (){
                    showDialog(context: context, builder: (context){
                      return StatefulBuilder(
                        builder: (context,setState) {
                          return Material(
                            child: Stack(
                              children: [
                                Container(
                                height: MediaQuery.of(context).size.height * 80,
                                child: GoogleMap(
                                  initialCameraPosition: cameraPosition,
                                  markers: markers,
                                  mapType: MapType.hybrid,
                                  onTap: (position){
                                    var marker = Marker(
                                      markerId: MarkerId(DateTime.now().toString()),
                                      position: position
                                      
                                    );
                                    setState(() {
                                      lat = position.latitude;
                                      long = position.longitude;
                                      markers = {};
                                      markers.add(marker);
                                    });
                                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Location is set.")));
                                  },
                                ),
                                              ),
                                              Positioned(
                                                bottom: 50,
                                                child: Container(
                                                  width: MediaQuery.of(context).size.width,
                                                  alignment: Alignment.center,
                                                  child: GestureDetector(
                                                    onTap: () => Navigator.pop(context),
                                                    child: Container(
                                                      padding: EdgeInsets.all(15),
                                                      decoration: BoxDecoration(
                                                        borderRadius: BorderRadius.circular(10),
                                                        color: Colors.white,
                                                        boxShadow: [
                                                          BoxShadow(
                                                            blurRadius:3,
                                                            offset: Offset(0,1),
                                                            color: markers.length > 0 ? Color(0xff7e7e7e) : Colors.white10,
                                                          )
                                                        ]
                                                      ),
                                                      child: Text("Select Location", style: TextStyle(color:  markers.length > 0 ? Color(0xff000000) : Color(0xff7e7e7e),),)),
                                                  ),
                                                ),
                                              ),
                              ],
                            ),
                          );
                        }
                      );
                    });
                  },
                  child: Text("Select Location")),
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
                var oldData = context.read(authenticatedUserProvider).user!.data() as dynamic;
                var data = {
                  "name" : nameController.text,
                  "category" : categoryController.text,
                  "bio" : bioController.text,
                  "location" : locationController.text,
                  "latitude" : lat ?? oldData["latitude"],
                  "longitude" : long  ?? oldData["longitude"],
                };
                Logger().d(data);
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
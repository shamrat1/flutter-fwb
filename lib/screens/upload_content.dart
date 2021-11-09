import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app103/state/AuthenticatedUserState.dart';
import 'package:image_picker/image_picker.dart';
import 'package:logger/logger.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

class UploadContent extends StatefulWidget {
  UploadContent({Key? key}) : super(key: key);

  @override
  _UploadContentState createState() => _UploadContentState();
}

class _UploadContentState extends State<UploadContent> {
  XFile? image;
  String? imageUrl;
  TextEditingController _productDescriptionController = TextEditingController();
  TextEditingController _priceController = TextEditingController();
  TextEditingController _nameController = TextEditingController();
  var categories;
  Map<String,dynamic>? selectedCategory;
  String categoryLabel = "Select A Product Category.";
  bool _loading = false;
  firebase_storage.FirebaseStorage fireStorage = firebase_storage.FirebaseStorage.instance;

  @override
  void initState() { 
    super.initState();
    categories = FirebaseFirestore.instance.collection("categories").get();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.indigo[100],
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: GestureDetector(
          onTap: () {
            Navigator.of(context).pop();
          },
          child: Icon(
            CupertinoIcons.arrow_left,
            color: Colors.black,
          ),
        ),
        title: Text(
          "FEMALEPRENEURE BAZAAR",
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Colors.black38,
          ),
        ),
        actions: [
          Icon(
            CupertinoIcons.cart,
            color: Colors.black,
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(8.0),
        child: ListView(
          // crossAxisAlignment: CrossAxisAlignment.stretch,
          // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Container(
              height: 200,
              width: 250,
              decoration: BoxDecoration(
                  color: image == null ? Colors.blue : null,
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
            SizedBox(height: 20,),
            Container(
              padding: EdgeInsets.all(10),
              margin: EdgeInsets.all(0),
              decoration: BoxDecoration(
                  color: Colors.indigo[50],
                  borderRadius: BorderRadius.circular(10)),
              child: TextField(
                controller: _nameController,
                  decoration: InputDecoration(
                hintText: 'Product Name',
              )),
            ),
            SizedBox(height: 20,),
            Container(
              padding: EdgeInsets.all(10),
              margin: EdgeInsets.all(0),
              decoration: BoxDecoration(
                  color: Colors.indigo[50],
                  borderRadius: BorderRadius.circular(10)),
              child: TextField(
                controller: _productDescriptionController,
                  decoration: InputDecoration(
                    focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Theme.of(context).accentColor)),
                  hintText: 'Description of Product',
                ),
                maxLines: 5,
                keyboardType: TextInputType.multiline,
              ),
            ),
            SizedBox(height: 20,),
            Container(
              padding: EdgeInsets.all(10),
              // margin: EdgeInsets.all(5),
              decoration: BoxDecoration(
                  color: Colors.indigo[50],
                  borderRadius: BorderRadius.circular(10)),
              child: InkWell(
                onTap: (){
                  showModalBottomSheet(
                    
                    context: context,
                    builder: (context){
                      return Container(
                        height: MediaQuery.of(context).size.height * .50,
                        child: FutureBuilder<QuerySnapshot>(
                          future: categories,
                          builder: (context, snapshot){
                            if(snapshot.connectionState == ConnectionState.waiting) return Container(
                              height: 250,
                              child: Center(
                                child: CircularProgressIndicator(),
                              ),
                            );

                            return ListView.builder(
                              itemBuilder: (context, index){
                                var cat = snapshot.data?.docs[index];
                                return ListTile(
                                  title: Text(cat?["name"] ?? "No Category Name"),
                                  onTap: (){
                                    setState(() {
                                      selectedCategory = cat?.data() as Map<String, dynamic>;
                                      selectedCategory?.addAll({"id" : cat!.id});
                                      categoryLabel = cat?["name"] ?? "No Category Name";
                                    });
                                    Navigator.pop(context);
                                  },
                                );
                              },
                              itemCount: snapshot.data?.size,
                            );
                          },
                        ),
                      );
                    }
                  );
                },
                child: Container(
                  alignment: Alignment.centerLeft,
                  height: 50,
                  child: Text(categoryLabel)),
              ),
            ),
            SizedBox(height: 20,),
            Container(
              padding: EdgeInsets.all(10),
              margin: EdgeInsets.all(0),
              decoration: BoxDecoration(
                  color: Colors.indigo[50],
                  borderRadius: BorderRadius.circular(10)),
              child: TextField(
                controller: _priceController,
                  decoration: InputDecoration(
                hintText: 'Add Price',
              )),
            ),
            SizedBox(height: 20,),
            if(_loading == false)
            ElevatedButton(
              style: ElevatedButton.styleFrom(primary: Colors.indigo[50]),
              onPressed: () async {
                setState(() {
                  _loading = true;
                });
                if(_validate()){

                }
                var url = await uploadImage(File(image!.path));
                var data = {
                  "name" : _nameController.text,
                  "description" : _productDescriptionController.text,
                  "category" : selectedCategory,
                  "price" : _priceController.text,
                  "image" : url,
                  "owner" : context.read(authenticatedUserProvider).documentId,
                  "rating" : 0,
                  "created_at" : DateTime.now()
                };
                FirebaseFirestore.instance.collection("products").add(data).whenComplete((){
                  Navigator.of(context).pop();
                });

              },
              child: Text(
                'Save',
                style: TextStyle(color: Colors.indigo[900]),
              ),
            ),

            if(_loading)
            ElevatedButton(
              style: ElevatedButton.styleFrom(primary: Colors.indigo[50]),
              onPressed: () async {},
              child: Center(
                child: CircularProgressIndicator(),
              ),
            )
          ],
        ),
      ),
    );
  }

  bool _validate(){
    var msg = "";
    
    if(image == null){
      msg += "Product Image is Required.";
    }else if(_nameController.text.length == 0){
      msg += " Product Name is Required.";
    }else if(_productDescriptionController.text.length == 0){
      msg += " Product Description is Required.";
    
    }else if(_priceController.text.length == 0){
      msg += " Product Price is Required.";
    }

    if(msg != ""){
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(msg)));
      setState(() {
        _loading = false;
      });
      return false;
    }
    return true;
  }

  Future<String> uploadImage(File _image) async {
    try {
      
      var uploadTask = await fireStorage
          .ref()
          .child('products/${context.read(authenticatedUserProvider).documentId}_${DateTime.now()}')
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

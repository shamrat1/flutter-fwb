import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:logger/logger.dart';

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
            ElevatedButton(
              style: ElevatedButton.styleFrom(primary: Colors.indigo[50]),
              onPressed: () {},
              child: Text(
                'Save',
                style: TextStyle(color: Colors.indigo[900]),
              ),
            )
          ],
        ),
      ),
    );
  }
}

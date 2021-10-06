import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class UploadContent extends StatefulWidget {
  UploadContent({Key? key}) : super(key: key);

  @override
  _UploadContentState createState() => _UploadContentState();
}

class _UploadContentState extends State<UploadContent> {
  XFile? image;

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
        padding: EdgeInsets.all(5),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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
            Container(
              padding: EdgeInsets.all(10),
              margin: EdgeInsets.all(0),
              decoration: BoxDecoration(
                  color: Colors.indigo[50],
                  borderRadius: BorderRadius.circular(10)),
              child: TextField(
                  decoration: InputDecoration(
                hintText: 'Description of Product',
              )),
            ),
            Container(
              padding: EdgeInsets.all(10),
              margin: EdgeInsets.all(0),
              decoration: BoxDecoration(
                  color: Colors.indigo[50],
                  borderRadius: BorderRadius.circular(10)),
              child: TextField(
                  decoration: InputDecoration(
                hintText: 'Tag Catagory',
              )),
            ),
            Container(
              padding: EdgeInsets.all(10),
              margin: EdgeInsets.all(0),
              decoration: BoxDecoration(
                  color: Colors.indigo[50],
                  borderRadius: BorderRadius.circular(10)),
              child: TextField(
                  decoration: InputDecoration(
                hintText: 'Add Price',
              )),
            ),
            ElevatedButton(
                style: ElevatedButton.styleFrom(primary: Colors.indigo[50]),
                onPressed: () {},
                child: Text(
                  'Share',
                  style: TextStyle(color: Colors.indigo[900]),
                ))
          ],
        ),
      ),
    );
  }
}

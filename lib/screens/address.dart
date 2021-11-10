import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app103/state/AuthenticatedUserState.dart';
import 'package:flutter_app103/state/SelectedAddressState.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logger/logger.dart';

class Address extends StatefulWidget {
  Address({Key? key}) : super(key: key);

  @override
  _AddressState createState() => _AddressState();
}

class _AddressState extends State<Address> {
  final TextEditingController addressController = TextEditingController();
  final TextEditingController cityController = TextEditingController();
  final TextEditingController landMarkController = TextEditingController();
  final TextEditingController pinCodeController = TextEditingController();
  late String valueChoose;
  var addressType = "Home";
  bool defaultAddress = false;
  bool showNewAddressPage = false;
  List listItem = ["Item 1", "Item 2", "Item 3", "Item 4", "Item 5"];
  var address;

  @override
  void initState() {
    super.initState();
    getAddresses();
  }

  void getAddresses() async {
    address = FirebaseFirestore.instance.collection("/address").where("user",isEqualTo: context.read(authenticatedUserProvider).documentId).get();
    address.then((snapshot){
      if(!(snapshot.size > 0)){
        setState(() {
          showNewAddressPage = true;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.indigo[100],
      appBar: AppBar(
        title: Text(
          "FEMALEPRENEUR BAZAAR",
          style: TextStyle(fontSize: 25, fontWeight: FontWeight.w700),
        ),
        actions: [
          if(!showNewAddressPage)
          IconButton(
            onPressed: (){
              setState(() {
                showNewAddressPage = true;
              });
            },
          icon: Icon(Icons.add)),

          if(showNewAddressPage)
          IconButton(
            onPressed: (){
              setState(() {
                showNewAddressPage = false;
              });
            },
          icon: Icon(Icons.list)),
        ],
      ),
      body: SafeArea(
        child: Stack(
          children: [

            if(!showNewAddressPage)
            Consumer(
              builder: (context, watch, child) {
                var selectedAddress = watch(selectedAddressProvider);

                return FutureBuilder<QuerySnapshot>(
                  future: address,
                  builder: (context, snapshot){
                    if(snapshot.connectionState == ConnectionState.waiting) return Center(
                      child: CircularProgressIndicator(),
                    );

                    return ListView.builder(
                      itemBuilder: (context, index){
                        
                        var address = snapshot.data!.docs[index].data() as Map<String, dynamic>;
                        return ListTile(
                          title: Text("${address["address"]}, ${address["landmark"]}"),
                          subtitle: Text("${address["pincode"]}, ${address["city"]}"),
                          tileColor: snapshot.data!.docs[index].id == selectedAddress.documentId ? Colors.blueAccent.shade100 : null,
                          onTap: (){

                            context.read(selectedAddressProvider.notifier).change(AddressModel(
                              documentId: snapshot.data!.docs[index].id,
                              data: address,
                            ));
                          },
                        );
                      },
                      itemCount: snapshot.data!.size,
                    );
                  },
                );
              }
            ),
            if(showNewAddressPage)
            Container(
              margin: EdgeInsets.symmetric(horizontal: 30),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    
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
                      controller: cityController,
                      decoration: InputDecoration(hintText: "City"),
                    ),
                    TextField(
                      controller: pinCodeController,
                      decoration: InputDecoration(hintText: "Pin Code"),
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
                    //       // setState(() {
                    //       //   valueChoose = newValue;
                    //       // });
                    //     },
                    //   ),
                    // ),
                    // Row(
                    //   children: [
                    //     Text("Home"),
                    //     Text("Office"),
                    //     Text("Others"),
                    //   ],
                    // ),
                    Padding(
                      padding: EdgeInsets.all(8),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Radio(
                                value: "Home",
                                groupValue: addressType,
                                onChanged: (String? value){
                                  setState(() {
                                    addressType = value!;
                                  });
                                }),
                                Text("Home")
                            ],
                          ),
                          Row(
                            children: [
                              Radio(
                                value: "Work",
                                groupValue: addressType,
                                onChanged: (String? value){
                                  setState(() {
                                    addressType = value!;
                                  });
                                }),
                                Text("Work")
                            ],
                          ),
                          Row(
                            children: [
                              Radio(
                                value: "Other",
                                groupValue: addressType,
                                onChanged: (String? value){
                                  setState(() {
                                    addressType = value!;
                                  });
                                }),
                                Text("Other")
                            ],
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(8),
                      child: Row(
                        children: [
                          Checkbox(
                            value: defaultAddress,
                            onChanged: (bool? value){
                              setState(() {
                                defaultAddress = value!;
                              });
                            }
                          ),
                          Text("Set as default address"),
                        ],
                      ),
                    ),
                    // ElevatedButton(
                    //   onPressed: () {},
                    //   child: Text("Update Using Location"),
                    // ),
                    ElevatedButton(
                      onPressed: () async {
                        if(_validate()){
                          var data = {
                            "address" : addressController.text,
                            "landmark" : landMarkController.text,
                            "pincode" : pinCodeController.text,
                            "city" : cityController.text,
                            "addressType" : addressType,
                            "default_address" : defaultAddress,
                            "user" : context.read(authenticatedUserProvider).documentId,
                          };
                          await FirebaseFirestore.instance.collection("/address").add(data);
                          setState(() {
                            showNewAddressPage = false;
                            addressController.text = "";
                            landMarkController.text = "";
                            pinCodeController.text = "";
                            cityController.text = "";
                          });
                          getAddresses();
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Address added successfully.")));
                        }
                        
                      },
                      child: Text("Save Address"),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  bool _validate(){
    var msg = "";
    if(addressController.text.length == 0){
      msg += "Address is required";
    }else if(landMarkController.text.length == 0){
      msg += "Land mark is required";
    }else if(cityController.text.length == 0){
      msg += "City is required";
    }
    if(msg != ""){
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(msg)));
    }
    return msg == "" ? true : false;
  }
}

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app103/constants.dart';
import 'package:flutter_app103/screens/checkout_Payment.dart';
import 'package:flutter_app103/state/AuthenticatedUserState.dart';
import 'package:flutter_app103/state/SelectedAddressState.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:logger/logger.dart';
import 'package:google_geocoding/google_geocoding.dart';

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
  bool _loading = false;

  @override
  void initState() {
    super.initState();
    getAddresses();
  }

  void getAddresses() async {
    address = FirebaseFirestore.instance.collection("/address").where("user",isEqualTo: context.read(authenticatedUserProvider).documentId).get();
    address.then((QuerySnapshot snapshot){
;

      if(!(snapshot.size > 0)){

        setState(() {
          showNewAddressPage = true;
        });
      }else{
        if( context.read(selectedAddressProvider).documentId == null){
          snapshot.docs.forEach((singleSnap){
            var data = singleSnap.data() as Map<String, dynamic>;
                      Logger().e(data["default_address"]);

            if(data["default_address"] == true){
              context.read(selectedAddressProvider.notifier).change(AddressModel(
                documentId: singleSnap.id,
                data: data
              ));
              
            }
          });
        }
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

                    return Column(
                      children: [
                        Container(
                          height: MediaQuery.of(context).size.height * .80 - 56,
                          child: ListView.builder(
                            itemBuilder: (context, index){
                              
                              var address = snapshot.data!.docs[index].data() as Map<String, dynamic>;
                              Logger().d("Default address ${address["default_address"]}");
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
                          ),
                        ),
                        Container(
                          // color: Colors.white,
                          height: MediaQuery.of(context).size.height * .10,
                          child: Center(
                            child: InkWell(
                              onTap: (){
                                if(context.read(selectedAddressProvider).documentId != null){
                                  Navigator.push(context, MaterialPageRoute(builder: (ctx) => CheckoutPayment()));
                                }
                              },
                              child: Container(
                                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                                width: MediaQuery.of(context).size.width * .40,
                                height: 50,
                                decoration: BoxDecoration(
                                  color: watch(selectedAddressProvider).documentId != null ? Theme.of(context).accentColor : Colors.grey,
                                  borderRadius: BorderRadius.circular(10),
                                  boxShadow: [
                                    BoxShadow(
                                      blurRadius: 3
                                    )
                                  ]
                                ),
                                child: Center(
                                  child: Text("Continue", style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold
                                  ),),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
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
                        if(_loading != true && _validate()){
                          if(defaultAddress){
                            var addresses = await FirebaseFirestore.instance.collection("/address")
                            .where("user",isEqualTo: context.read(authenticatedUserProvider).documentId)
                            .where("default_address",isEqualTo: true)
                            .get();

                            addresses.docs.forEach((element) {
                              FirebaseFirestore.instance.collection("/address").doc(element.id).update({
                                "default_address" : false,
                              });
                            });
                          }
                          var data = {
                            "address" : addressController.text,
                            "landmark" : landMarkController.text,
                            "pincode" : pinCodeController.text,
                            "city" : cityController.text,
                            "addressType" : addressType,
                            "default_address" : defaultAddress,
                            "user" : context.read(authenticatedUserProvider).documentId,
                          };
                          var newAddress = await FirebaseFirestore.instance.collection("/address").add(data);
                          FirebaseFirestore.instance.collection("/address").doc(newAddress.id).get().then((value){
                            context.read(selectedAddressProvider.notifier).change(AddressModel(documentId: newAddress.id, data: value.data() as dynamic));
                          });
                          getAddresses();
                          setState(() {
                            showNewAddressPage = false;
                            addressController.text = "";
                            landMarkController.text = "";
                            pinCodeController.text = "";
                            cityController.text = "";
                          });
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Address added successfully.")));
                        }
                        
                      },
                      child: _loading ? CircularProgressIndicator() : Text("Save Address"),
                    ),

                    // SizedBox(height: 20,),
                    Padding(
                      padding: EdgeInsets.all(8),
                      child: TextButton(
                        onPressed: () async {
                          // setState(() {
                          //   _loading = true;
                          // });
                          var position = await Geolocator.getCurrentPosition();
                          var geoCoding = GoogleGeocoding(googleApiKey);
                          GeocodingResponse? response = await geoCoding.geocoding.getReverse(LatLon(position.latitude, position.longitude));
                          if(response != null && response.status == "OK"){
                            var address = response.results?.first;
                            var components = address?.addressComponents;
                            var pinCode = address?.postcodeLocalities?.first ?? "";
                            var city = components![components.length - 2].longName;
                            var addressString = "";
                            for(var i = 0; i < 2; i++){
                              addressString += components[i].longName!;
                            }

                            setState(() {
                              addressController.text = addressString;
                              cityController.text = city!;
                              pinCodeController.text = pinCode;
                            });

                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Address Details Fetched based on your current location.")));
                          }
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Failed to Fetch data. ${response!.status}")));
                        },
                        child: Text("Get Address From Current Location"),
                      ),
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

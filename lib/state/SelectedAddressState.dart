

import 'package:flutter_riverpod/flutter_riverpod.dart';

final selectedAddressProvider = StateNotifierProvider<SelectedAddressState, AddressModel>((ref) => SelectedAddressState(AddressModel()));

class SelectedAddressState extends StateNotifier<AddressModel>{

  SelectedAddressState(AddressModel state) : super(state);

  void change(AddressModel address) => state = address;
}

class AddressModel {

  final String? documentId;
  final Map<String,dynamic>? data;

  AddressModel({this.documentId, this.data});
}


import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

/**
 * !!! : THIS CLASS WILL BE LATER IMPLEMENTED WITH STATIC METHODS
 */
class AddUser{

  final String fullName;
  final String email;

  AddUser(this.fullName,this.email);

  CollectionReference users = FirebaseFirestore.instance.collection('Users');

  CollectionReference products = FirebaseFirestore.instance.collection('Products');

  Future<void> addUser(){

    return users.add({
      'full name' : fullName,
      'email' : email,
    }).then ((value) => print('User added.'))
    .catchError((error) => print('Failed to Add User: $error'));
  }

  Future<void> addProduct(){

    return products.add({
      'name' : 'kama sutra playing cards',
      'barcode' : '2000737053704'
    }).then((value) => print('Product added'))
        .catchError((error) => print('Failed to Add Product: $error'));
  }
  void printDetails(){
    print('Name : ${this.fullName}, Email : ${this.email}');
  }
}
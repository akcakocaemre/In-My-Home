import 'package:flutter/material.dart';

var butonrengi = Color(0x791074DE);
var yazirengi = Color(0xF0FFFFFF);
var butonrengi2= Color(0xFF083663);
var butonrengi3= Color(0xFF487BEA);

final kHintTextStyle = TextStyle(
  color: Colors.white54,
  fontFamily: 'OpenSans',
);

final kLabelStyle = TextStyle(
  color: yazirengi,
  fontWeight: FontWeight.bold,
  fontFamily: 'OpenSans',
);

final kBoxDecorationStyle = BoxDecoration(
  color: butonrengi2,
  borderRadius: BorderRadius.circular(10.0),
  boxShadow: [
    BoxShadow(
      color: Colors.black12,
      blurRadius: 6.0,
      offset: Offset(0, 2),
    ),
  ],
);

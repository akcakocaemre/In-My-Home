import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter1/screens/constants.dart';
import 'kutucukolustur.dart';
import 'productekle.dart';
import 'package:flutter1/main.dart';

var butonrengi = Color(0x791074DE);
var yazirengi = Color(0xF0FFFFFF);
var butonrengi2= Color(0xFF083663);
var butonrengi3= Color(0xFF487BEA);

const List deneme = [];


class ListScreen extends StatefulWidget {
  ListScreen({required this.urunlist});
  List urunlist;
  // @override
  _LoginScreenState createState() => _LoginScreenState(urun_list: urunlist);

}

class _LoginScreenState extends State<ListScreen> {
  bool _rememberMe = false;
  _LoginScreenState({required this.urun_list});
  List urun_list;
  // get urunlist => urunlist;
  // get urunlist => Future.value(urunlist);

  Widget _buildaraTF() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        SizedBox(height: 10.0),
        Container(
          alignment: Alignment.centerLeft,
          decoration: kBoxDecorationStyle,
          height: 60.0,
          child: TextField(
            keyboardType: TextInputType.emailAddress,
            style: TextStyle(
              color: yazirengi,
              fontFamily: 'OpenSans',
            ),
            decoration: InputDecoration(
              border: InputBorder.none,
              contentPadding: EdgeInsets.only(top: 14.0),
              prefixIcon: Icon(
                Icons.search,
                color: yazirengi,
              ),
              hintText: 'Arama',
              hintStyle: TextStyle(
                color: yazirengi,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildheadTF() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 10.0),
      width: double.infinity,
      child: RaisedButton(
        elevation: 5.0,
        onPressed: () => print('Ev Bakım Button Pressed'),
        padding: EdgeInsets.all(15.0),
        color: butonrengi2,
        child: Text(
          'Ürün Adı             Giriş Tarihi             Kalan Gün',
          style: TextStyle(
            color: yazirengi,
            fontSize: 15.0,
            fontWeight: FontWeight.bold,
            fontFamily: 'OpenSans',
          ),
        ),
      ),
    );
  }

  Widget _buildurun1TF() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 1.0),
      width: double.infinity,
      child: RaisedButton(
          elevation: 5.0,
          onPressed: () => print('Ev Bakım Button Pressed'),
          padding: EdgeInsets.all(15.0),
          color: butonrengi2,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly, // use whichever suits your need
            children: <Widget>[
              Text(
                urun_list[0].productname,
                style: TextStyle(
                  color: yazirengi,
                  fontSize: 15.0,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'OpenSans',
                ),
              ),
              Text(
                urun_list[0].expirationDate.toString(),
                style: TextStyle(
                  color: yazirengi,
                  fontSize: 15.0,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'OpenSans',
                ),
              ),
            ],
          )
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: butonrengi2,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(50),
          ),),
        toolbarHeight: 80.0,
        title: Text(
          '             Gıda',
          style: TextStyle(
            color: yazirengi,
            fontFamily: 'OpenSans',
            fontSize: 30.0,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.light,
        child: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: Stack(
            children: <Widget>[
              Container(
                height: double.infinity,
                width: double.infinity,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.white10,
                      Colors.white10,
                      Colors.white10,
                      Colors.white10,
                      Colors.white10,
                    ],
                    stops: [0.1, 0.3, 0.5, 0.7, 0.9],
                  ),
                ),
              ),
              Container(
                height: double.infinity,
                child: SingleChildScrollView(
                  physics: AlwaysScrollableScrollPhysics(),
                  padding: EdgeInsets.symmetric(
                    horizontal: 5.0,
                    vertical: 20.0,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      _buildaraTF(),
                      _buildheadTF(),
                      for ( var i in urun_list )
                        SignInButton(
                          text: i.productname,
                          text1: i.expirationDate.toString(),
                          onPressed: () {},
                        ),
                      // _buildurun2TF(),
                      // _buildurun3TF(),
                      // _buildurun4TF(),
                      // _buildurun5TF(),
                      // _buildurun6TF(),
                      // _buildurun7TF(),
                      // _buildurun8TF(),
                      // _buildurun9TF(),
                      // _buildurun10TF(),
                      // _buildurun11TF(),
                      // _buildurun12TF(),
                      // _buildurun13TF(),
                      // _buildurun14TF(),
                      // _buildurun15TF(),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
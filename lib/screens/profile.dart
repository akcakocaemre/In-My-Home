import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter1/service/add_user.dart';
import 'package:flutter1/service/user_services.dart';

import 'constants.dart';


var butonrengi = Color(0x791074DE);
var yazirengi = Color(0xF0FFFFFF);
var butonrengi2= Color(0xFF083663);
var butonrengi3= Color(0xFF487BEA);

class ProfilePage extends StatefulWidget{


  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  bool _isSendingVerification = false;
  bool _isSigningOut = false;
  bool _isRegisteredToDB = false;


  late User _currentUser;
  late AddUser _addUser;



  @override
  void initState(){
    _currentUser = FirebaseAuth.instance.currentUser!;
    _addUser = AddUser(_currentUser.displayName!, _currentUser.email!);
    _addUser.printDetails();
    super.initState();
  }

  Widget _buildNameBtn() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'İsim',
          style: TextStyle(color: butonrengi2),
        ),
        SizedBox(height: 10.0),
        Form(
          child: Container(
            alignment: Alignment.centerLeft,
            decoration: kBoxDecorationStyle,
            height: 60.0,
            child: Text('     ${_currentUser.displayName}',
              style: Theme.of(context).textTheme.bodyText1?.copyWith(color: yazirengi),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildEmailBtn() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        SizedBox(height: 10.0),
        Text(
          'E mail',
          style: TextStyle(color: butonrengi2),
        ),
        SizedBox(height: 10.0),
        Form(
          child: Container(
            alignment: Alignment.centerLeft,
            decoration: kBoxDecorationStyle,
            height: 60.0,
            child: Text(
              '     ${_currentUser.email}',
              style: Theme.of(context).textTheme.bodyText1?.copyWith(color: yazirengi),
            ),
          ),
        ),
      ],
    );
  }


  Widget _buildEmailverifiedBtn() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 10.0),
      width: double.infinity,
      height: 80,
      child: RaisedButton(
        elevation: 5.0,
        onPressed: () => print('Ev Bakım Button Pressed'),
        padding: EdgeInsets.all(15.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30.0),
        ),
        color: butonrengi2,
        child: _currentUser.emailVerified
            ?Text(
          'E mail Doğrulandı',
          style: Theme.of(context).textTheme.bodyText1?.copyWith(color: Colors.green),
        ) :
        Text(
          'E mail Doğrulanmadı',
          style: Theme.of(context).textTheme.bodyText1?.copyWith(color: Colors.red),
        ),
      ),
    );
  }

  Widget _buildverifiedBtn() {
    return Container(
      child:
      _isSendingVerification ?
      CircularProgressIndicator() :
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          ElevatedButton(
              onPressed: () async{
                setState(() {
                  _isSendingVerification = true;
                });
                await _currentUser.sendEmailVerification();
                setState(() {
                  _isSendingVerification = false;
                });
              },
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.all(15.0),
                primary: butonrengi2,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30.0),
                ),
                minimumSize: Size(250, 60),
              ),
              child: Text('Email Doğrula')),
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: () async{
              User? user = await UserService.refreshUser(_currentUser);
              if(user!= null){
                setState(() {
                  _currentUser = user;
                });
              }
            },
          ),
          Opacity(
            opacity: 0.0,
            child: Image.asset('assets/logos/facebook-logo.png'),
          ),
        ],
      ),
    );
  }

  Widget _buildcikisBtn() {
    return Container(
      child: _isSigningOut ? CircularProgressIndicator() :
      ElevatedButton(
        onPressed: () async {
          setState(() {
            _isSigningOut = true;
          });
          await FirebaseAuth.instance.signOut();

          setState(() {
            _isSigningOut = false;
          });
          Navigator.of(context).pushNamed('/kayıtolma');
        },
        child: Text('Oturumu Kapat'),
        style: ElevatedButton.styleFrom(
          padding: EdgeInsets.all(15.0),
          primary: butonrengi2,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30.0),
          ),
          minimumSize: Size(400, 60),
        ),
      ),
    );
  }

  Widget _builddataekleBtn() {
    return Container(
      child:   _isRegisteredToDB ? Text('Already in database'):ElevatedButton(
          onPressed: (){

            _addUser.addUser();
          },
          style: ElevatedButton.styleFrom(
            padding: EdgeInsets.all(15.0),
            primary: butonrengi2,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30.0),
            ),
            minimumSize: Size(400, 60),
          ),
          child: Text('Database Ekle')),
    );
  }

  @override
  Widget build(BuildContext context){

    return Scaffold(
      appBar: AppBar(
        backgroundColor: butonrengi2,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(50),
          ),),
        toolbarHeight: 80.0,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              padding: const EdgeInsets.all(8.0), child: Text(
              'In My Home',
              style: TextStyle(
                color: yazirengi,
                fontFamily: 'OpenSans',
                fontSize: 30.0,
                fontWeight: FontWeight.bold,
              ),
            ),),
            ClipRRect(
              borderRadius: BorderRadius.circular(30.0),
              child: Image.asset(
                'assets/logos/foto.jpg',
                width: 60.0,
                height: 60.0,
                fit: BoxFit.fill,
              ),
            ),
          ],
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
                    horizontal: 30.0,
                    vertical: 20.0,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      _buildNameBtn(),
                      _buildEmailBtn(),
                      SizedBox(height: 10.0),
                      _buildEmailverifiedBtn(),
                      SizedBox(height: 10.0),
                      _buildverifiedBtn(),
                      SizedBox(height: 10.0),
                      SizedBox(height: 10.0),
                      _buildcikisBtn(),
                      SizedBox(height: 10.0),
                      SizedBox(height: 10.0),
                      _builddataekleBtn(),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),);
  }
}
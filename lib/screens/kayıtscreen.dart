import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter1/screens/constants.dart';
import 'package:flutter1/service/user_services.dart';
import 'package:flutter1/service/validator2.dart';

var butonrengi = Color(0x791074DE);
var yazirengi = Color(0xF0FFFFFF);
var butonrengi2= Color(0xFF083663);
var butonrengi3= Color(0xFF487BEA);

class KayitScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<KayitScreen> {
  bool _rememberMe = false;

  final _registerEmailFormKey = GlobalKey<FormState>();
  final _registerPasswordFormKey = GlobalKey<FormState>();
  final _registerNameFormKey = GlobalKey<FormState>();

  final _nameTextController = TextEditingController();
  final _emailTextController = TextEditingController();
  final _passwordTextController = TextEditingController();

  final _focusName = FocusNode();
  final _focusEmail = FocusNode();
  final _focusPassword = FocusNode();

  bool _isProcessing = false;



  Widget _buildEmailTF() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'Email',
          style: TextStyle(color: butonrengi2),
        ),
        SizedBox(height: 10.0),
        Form(
          key: _registerEmailFormKey,
          child: Container(
            alignment: Alignment.centerLeft,
            decoration: kBoxDecorationStyle,
            height: 60.0,
            child: TextFormField(
              controller: _emailTextController,
              focusNode: _focusEmail,
              validator: (value) => Validator.validateEmail(
                  email: value),
              keyboardType: TextInputType.emailAddress,
              style: TextStyle(
                color: yazirengi,
                fontFamily: 'OpenSans',
              ),
              decoration: InputDecoration(
                border: InputBorder.none,
                contentPadding: EdgeInsets.only(top: 14.0),
                prefixIcon: Icon(
                  Icons.email,
                  color: yazirengi,
                ),
                hintText: 'Email veya kullanıcı adı giriniz',
                hintStyle: TextStyle(
                  color: yazirengi,
                ),
              ),
            ),
          ),
        ),

      ],
    );
  }

  Widget _buildIsimTF() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'Ad',
          style: TextStyle(color: butonrengi2),
        ),
        SizedBox(height: 10.0),
        Form(
          key: _registerNameFormKey,
          child: Container(
            alignment: Alignment.centerLeft,
            decoration: kBoxDecorationStyle,
            height: 60.0,
            child: TextFormField(
              controller: _nameTextController,
              focusNode: _focusName,
              validator: (value) => Validator.validateName(
                  name: value),
              keyboardType: TextInputType.emailAddress,
              style: TextStyle(
                color: yazirengi,
                fontFamily: 'OpenSans',
              ),
              decoration: InputDecoration(
                border: InputBorder.none,
                contentPadding: EdgeInsets.only(top: 14.0),
                prefixIcon: Icon(
                  Icons.account_circle,
                  color: yazirengi,
                ),
                hintText: 'Adınızı giriniz',
                hintStyle: TextStyle(
                  color: yazirengi,
                ),
              ),
            ),
          ),
        ),

      ],
    );
  }

  Widget _buildSoyisimTF() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'Soyad',
          style: TextStyle(color: butonrengi2),
        ),
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
                Icons.account_circle,
                color: yazirengi,
              ),
              hintText: 'Soyadınızı giriniz',
              hintStyle: TextStyle(
                color: yazirengi,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildTelefonTF() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'Telefon',
          style: TextStyle(color: butonrengi2),
        ),
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
                Icons.local_phone,
                color: yazirengi,
              ),
              hintText: 'Telefon numaranızı giriniz',
              hintStyle: TextStyle(
                color: yazirengi,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildSifreTekrarTF() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'Şifre Tekrar',
          style: TextStyle(color: butonrengi2),
        ),
        SizedBox(height: 10.0),
        Container(
          alignment: Alignment.centerLeft,
          decoration: kBoxDecorationStyle,
          height: 60.0,
          child: TextField(
            obscureText: true,
            style: TextStyle(
              color: yazirengi,
              fontFamily: 'OpenSans',
            ),
            decoration: InputDecoration(
              border: InputBorder.none,
              contentPadding: EdgeInsets.only(top: 14.0),
              prefixIcon: Icon(
                Icons.lock,
                color: yazirengi,
              ),
              hintText: 'Şifrenizi tekrar giriniz',
              hintStyle: TextStyle(
                color: yazirengi,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildPasswordTF() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'Şifre',
          style: TextStyle(color: butonrengi2),
        ),
        SizedBox(height: 10.0),
        Form(
          key: _registerPasswordFormKey,
          child: Container(

          alignment: Alignment.centerLeft,
          decoration: kBoxDecorationStyle,
          height: 60.0,
          child: TextFormField(
            controller: _passwordTextController,
            focusNode: _focusPassword,
            validator: (value) => Validator.validatePassword(
                password: value),
            obscureText: true,
            style: TextStyle(
              color: yazirengi,
              fontFamily: 'OpenSans',
            ),
            decoration: InputDecoration(
              border: InputBorder.none,
              contentPadding: EdgeInsets.only(top: 14.0),
              prefixIcon: Icon(
                Icons.lock,
                color: yazirengi,
              ),
              hintText: 'Şifrenizi giriniz',
              hintStyle: TextStyle(
                color: yazirengi,
              ),
            ),
          ),
        ),
        ),
      ],
    );
  }

  Widget _buildLoginBtn() {
    return _isProcessing?
    CircularProgressIndicator() : Container(
      padding: EdgeInsets.symmetric(vertical: 25.0),
      width: double.infinity,
      child: RaisedButton(
        elevation: 5.0,
        onPressed: () async{

          if(_registerEmailFormKey.currentState!.validate()
              || _registerNameFormKey.currentState!.validate()
              || _registerPasswordFormKey.currentState!.validate()){
            setState(() {
              _isProcessing = true;
            });

          }
          User? user = await UserService.registerUsingEmailPassword(
              name: _nameTextController.text,
              email: _emailTextController.text,
              password: _passwordTextController.text);
          setState(() {
            _isProcessing = false;
          });
          Navigator.pushNamed(context, '/kayıtolma');
        },
        padding: EdgeInsets.all(15.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30.0),
        ),
        color: butonrengi2,
        child: Text(
          'Kayıt Ol',
          style: TextStyle(
            color: yazirengi,
            letterSpacing: 1.5,
            fontSize: 18.0,
            fontWeight: FontWeight.bold,
            fontFamily: 'OpenSans',
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(

      child: Scaffold(
        appBar: AppBar(
          backgroundColor: butonrengi2,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
              bottom: Radius.circular(50),
            ),),
          toolbarHeight: 80.0,
          title: Text(
            '       In My Home',
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
                      horizontal: 30.0,
                      vertical: 20.0,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        SizedBox(height: 10.0),
                        _buildIsimTF(),
                        SizedBox(height: 10.0),
                        _buildSoyisimTF(),
                        SizedBox(height: 10.0),
                        _buildEmailTF(),
                        SizedBox(height: 10.0),
                        _buildTelefonTF(),
                        SizedBox(height: 10.0),
                        _buildPasswordTF(),
                        SizedBox(height: 10.0),
                        _buildSifreTekrarTF(),
                        SizedBox(height: 10.0),
                        _buildLoginBtn(),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );

  }
}

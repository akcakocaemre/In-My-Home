import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter1/provider/google_sign_in_provider.dart';
import 'package:flutter1/screens/constants.dart';
import 'package:flutter1/service/user_services.dart';
import 'package:provider/provider.dart';

import '../service/validator2.dart';

var butonrengi = Color(0x791074DE);
var yazirengi = Color(0xF0FFFFFF);
var butonrengi2= Color(0xFF083663);
var butonrengi3= Color(0xFF487BEA);

class HesapScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<HesapScreen> {
  bool _rememberMe = false;
  final _formEmailKey = GlobalKey<FormState>();
  final _formPasswordKey = GlobalKey<FormState>();

  final _emailTextController = TextEditingController();
  final _passwordTextController = TextEditingController();

  final _focusEmail = FocusNode();
  final _focusPassword = FocusNode();

  bool _isProcessing = false;

  User? user = FirebaseAuth.instance.currentUser;

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
          key: _formEmailKey,
          child: Container(
            alignment: Alignment.centerLeft,
            decoration: kBoxDecorationStyle,
            height: 60.0,
            child: TextFormField(
              controller: _emailTextController,
              focusNode: _focusEmail,
              validator: (value) => Validator.validateEmail(
                email: value,
              ),
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
          key: _formPasswordKey,
          child:
          Container(
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

  Widget _buildForgotPasswordBtn() {
    return Container(
      alignment: Alignment.centerRight,
      child: FlatButton(
        onPressed: () => print('Forgot Password Button Pressed'),
        padding: EdgeInsets.only(right: 0.0),
        child: Text(
          'Şifrenizi mi unuttunuz?',
          style: TextStyle(
            color: butonrengi2,
          ),
        ),
      ),
    );
  }

  Widget _buildRememberMeCheckbox() {
    return Container(
      height: 20.0,
      child: Row(
        children: <Widget>[
          Theme(
            data: ThemeData(unselectedWidgetColor: Colors.black87),
            child: Checkbox(
              value: _rememberMe,
              checkColor: butonrengi2,
              activeColor: butonrengi2,
              onChanged: (value) {
                setState(() {
                  _rememberMe = value!;
                });
              },
            ),
          ),
          Text(
            'Beni Hatırla',
            style: TextStyle(
              color: butonrengi2,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLoginBtn() {
    return _isProcessing? CircularProgressIndicator() : Container(
      padding: EdgeInsets.symmetric(vertical: 10.0),
      width: double.infinity,
      child: RaisedButton(
        elevation: 5.0,
        onPressed: () async{
          _focusEmail.unfocus();
          _focusPassword.unfocus();

          if(_formEmailKey.currentState!.validate() || _formPasswordKey.currentState!.validate()){
              setState(() {
                _isProcessing = true;
              });
          }

          User? user = await UserService.signInUsingEmailPassword(
              email: _emailTextController.text,
              password: _passwordTextController.text);

          setState(() {
            _isProcessing = false;
          });

          Navigator.pushNamed(context, '/login');
        },
        padding: EdgeInsets.all(15.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30.0),
        ),
        color: butonrengi2,
        child: Text(
          'Giriş Yap',
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

  Widget _buildSignupBtn() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 5.0),
      width: double.infinity,
      child: RaisedButton(
        elevation: 5.0,
        onPressed: () {
          Navigator.pushNamed(context, '/kayıt');
        },
        padding: EdgeInsets.all(15.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30.0),
        ),
        color: butonrengi2,
        child: RichText(
          text: TextSpan(
            children: [
              TextSpan(
                text: 'Hesabınız yok mu? ',
                style: TextStyle(
                  color: yazirengi,
                  fontSize: 18.0,
                  fontWeight: FontWeight.w400,
                ),
              ),
              TextSpan(
                text: 'Kayıt Ol',
                style: TextStyle(
                  color: yazirengi,
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

/*  Google Sign In Button
    This button invokes a Google Authentication Process.
 */
  Widget _buildGoogleBtn() => ChangeNotifierProvider(
        create: (BuildContext context) => GoogleSignInProvider(),
      child: Container(
      padding: EdgeInsets.symmetric(vertical: 5.0),
      width: double.infinity,
      child: RaisedButton(
        onPressed: () => { GoogleSignInProvider().googleLogin()
        , print(GoogleSignInProvider().googleSignIn.currentUser?.email),
        Navigator.pushNamed(context, '/login')},
        padding: EdgeInsets.all(15.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30.0),
        ),
        color: butonrengi2,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Image.asset('assets/logos/google-logo.png'),
            Text(
              'Google ile Kayıt Ol',
              style: TextStyle(
                color: yazirengi,
                letterSpacing: 1.5,
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
                fontFamily: 'OpenSans',
              ),
            ),
            Opacity(
              opacity: 0.0,
              child: Image.asset('assets/logos/google-logo.png'),
            ),
          ],
        ),
      ),
    )
    );


  Widget _buildFacebookBtn() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 5.0),
      width: double.infinity,
      child: RaisedButton(
        onPressed: () => print('Forgot Password Button Pressed'),
        padding: EdgeInsets.all(15.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30.0),
        ),
        color: butonrengi2,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Image.asset('assets/logos/facebook-logo.png'),
            Text(
              'Facebook ile Kayıt Ol',
              style: TextStyle(
                color: yazirengi,
                letterSpacing: 1.5,
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
                fontFamily: 'OpenSans',
              ),
            ),
            Opacity(
              opacity: 0.0,
              child: Image.asset('assets/logos/facebook-logo.png'),
            ),
          ],
        ),
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

                      SizedBox(height: 30.0),
                      _buildEmailTF(),
                      SizedBox(
                        height: 30.0,
                      ),

                      _buildPasswordTF(),
                      _buildForgotPasswordBtn(),
                      _buildRememberMeCheckbox(),
                      _buildLoginBtn(),
                      _buildSignupBtn(),
                      _buildGoogleBtn(),
                      _buildFacebookBtn()
                      //_buildSignInWithText(),
                      //_buildSocialBtnRow2()
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

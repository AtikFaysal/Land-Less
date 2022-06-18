
import 'dart:io';

import 'package:device_info/device_info.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:land_less/AppTheme/app_theme.dart';
import 'package:land_less/drawer/dc_drawer.dart';
import 'package:land_less/drawer/userdrawer.dart';
import 'package:land_less/model/common_login_model.dart';
import 'package:land_less/model/login_response.dart';
import 'package:land_less/screen/main_dashboard.dart';
import 'package:land_less/service/apiService.dart';
import 'package:land_less/service/connection_check.dart';
import 'package:land_less/utils/Constant.dart';
import 'package:land_less/widget/alert_dilog_singleText.dart';
import 'package:land_less/widget/toast_massage.dart';
import 'package:shared_preferences/shared_preferences.dart';
class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  String uniqueId = "Unknown";

  bool _isLoading=false;
  bool _passwordVisible;
  bool _rememberMe=false;
  final formKey = new GlobalKey<FormState>();


  String _username,_password;
  TextEditingController emailController=new TextEditingController();
  TextEditingController passwordController=new TextEditingController();

  Future<String> _getId() async {
    var deviceInfo = DeviceInfoPlugin();
    if (Platform.isIOS) { // import 'dart:io'
      var iosDeviceInfo = await deviceInfo.iosInfo;
      return iosDeviceInfo.identifierForVendor; // unique ID on iOS
    } else {
      var androidDeviceInfo = await deviceInfo.androidInfo;
      return androidDeviceInfo.androidId; // unique ID on Android
    }
  }
  @override
  void initState() {
    // TODO: implement initState
    _getId().then((value) {
      setState(() {
        uniqueId=value;
      });
    });
    _passwordVisible=false;
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.light,
        child: GestureDetector(
            onTap: () => FocusScope.of(context).unfocus(),
            child: Container(
              child: Form(
                key: formKey,
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
                            AppTheme.mainColor,
                            AppTheme.mainColor,

                          ],
                          //stops: [0.1, 0.4, 0.7, 0.9],
                          tileMode: TileMode.repeated,
                        ),
                      ),
                    ),
                    _isLoading?
                    Center(child: SpinKitWave(color: AppTheme.subColors, type: SpinKitWaveType.center),):Container(
                      height: double.infinity,
                      child: SingleChildScrollView(
                        physics: AlwaysScrollableScrollPhysics(),
                        padding: EdgeInsets.symmetric(
                          horizontal: 40.0,
                          vertical: 100.0,
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Image.asset('assets/images/mainLogo.png',height: 110,width: 110,),
                            Center(
                              child: Text(
                                'প্রজেক্ট ইমপ্লিমেন্টেশন ট্র্যাকিং',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: AppTheme.mainInfo,
                                  fontFamily: 'OpenSans',
                                  fontSize: 25.0,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            SizedBox(height: 30,),
                            Center(
                              child: Text(
                                'ব্যবহারকারীর তথ্য',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: AppTheme.nearlyWhite,
                                  fontFamily: 'OpenSans',
                                  fontSize: 20.0,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            SizedBox(height: 20.0),
                            _buildEmailTF(),
                            SizedBox(
                              height: 20.0,
                            ),
                            _buildPasswordTF(),
                            //_buildForgotPasswordBtn(),
                            //_buildRememberMeCheckbox(),
                            SizedBox(
                              height: 10.0,
                            ),
                            _buildLoginBtn(),
                            checkDeviceId(context)
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
            )
        ),
      ),
    );
  }
  Widget _buildEmailTF() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        /*Text(
          'ব্যবহারকারীর নাম',
          style: kLabelStyle,
        ),*/
        SizedBox(height: 10.0),
        Container(
          alignment: Alignment.centerLeft,
          decoration: kBoxDecorationStyle,
          height: 60.0,
          child: TextFormField(
            //validator:validateEmail,
            onSaved: (value)=>_username=value,
            validator: (value)=>value.isEmpty ? "আপনার ইউজার নাম লিখুন" : null,
            //controller: emailController,
            keyboardType: TextInputType.emailAddress,
            style: TextStyle(
              color: AppTheme.nearlyBlack,
              fontFamily: 'OpenSans',
            ),
            decoration: InputDecoration(
              border: InputBorder.none,
              contentPadding: EdgeInsets.only(top: 14.0),
              prefixIcon: Icon(
                Icons.person,
                color: Colors.black,
              ),
              hintText: 'ব্যবহারকারীর নাম',
              hintStyle: TextStyle(color: AppTheme.nearlyBlack),
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
        /*Text(
          'পাসওয়ার্ড',
          style: kLabelStyle,
        ),*/
        SizedBox(height: 7.0),
        Container(
          alignment: Alignment.centerLeft,
          decoration: kBoxDecorationStyle,
          height: 60.0,
          child: TextFormField(
            obscureText: !_passwordVisible,
            onSaved: (value)=>_password=value,
            validator: (value)=>value.isEmpty ? "আপনার পাসওয়ার্ড লিখুন" : null,
            //controller:passwordController,
            style: TextStyle(
              color: AppTheme.nearlyBlack,
              fontFamily: 'OpenSans',
            ),
            decoration: InputDecoration(
              suffixIcon: IconButton(
                  icon: Icon(
                    // Based on passwordVisible state choose the icon
                    _passwordVisible
                        ? Icons.visibility
                        : Icons.visibility_off,
                    color: Theme.of(context).primaryColor,
                  ),
                onPressed: () {
                  // Update the state i.e. toogle the state of passwordVisible variable
                  setState(() {
                    _passwordVisible = !_passwordVisible;
                  });
                },
              ),
              border: InputBorder.none,
              contentPadding: EdgeInsets.only(top: 14.0),
              prefixIcon: Icon(
                Icons.vpn_key_sharp,
                color: Colors.black,
              ),
              hintText: 'ব্যবহারকারীর পাসওয়ার্ড ',
              hintStyle: TextStyle(color: AppTheme.nearlyBlack),
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
          'Forgot Password?',
          style: kLabelStyle,
        ),
      ),
    );
  }

  Widget _buildLoginBtn() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 25.0),
      width: double.infinity,
      child: RaisedButton(
        elevation: 5.0,
        onPressed:()async{
          SharedPreferences prefs=await SharedPreferences.getInstance();
          setState(() {
            _isLoading=true;
          });
          final form = formKey.currentState;
          if (form.validate()) {
            form.save();
            String _uniqeId=await _getId();
            print(_uniqeId);
            check().then((internet) {
              if(internet!=null && internet){
                ApiCall().login(_uniqeId, _username, _password).then((value) {
                  if(value['status']==200){
                    CommonLogin loginResponse=CommonLogin.fromJson(value);
                    Future.delayed(const Duration(milliseconds: 500), (){
                      prefs.setString('device_id', _uniqeId);
                      setState(() {
                        _isLoading=false;
                      });
                      print(loginResponse.commonResponse.userRole);
                      successToast(context, 'লগিন সফল হয়েছে');
                      Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(
                          builder: (BuildContext context) => AllServiceDashboard()), (
                          Route<dynamic> route) => false);
                      /*if(loginResponse.response.userRole=='1'){
                        setState(() {
                          _isLoading=false;
                        });
                        successToast(context,'লগইন সফল হয়েছে');
                        Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(
                            builder: (BuildContext context) => DcDrawer(loginResponse)), (
                            Route<dynamic> route) => false);
                      }else{
                        setState(() {
                          _isLoading=false;
                        });
                        successToast(context,'লগইন সফল হয়েছে');
                        Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(
                            builder: (BuildContext context) => UserDrawer(loginResponse)), (
                            Route<dynamic> route) => false);
                      }*/
                    });
                  }else if(value['status']==500){
                    setState(() {
                      _isLoading=false;
                    });
                    showToastMassage(context, 'দুঃখিত ! ইতিমধ্যে আপনাকে অথিরিটি দ্বারা নিষ্ক্রিয় করা হয়েছে');
                  }else if(value['status']==403){
                    setState(() {
                      _isLoading=false;
                    });
                    showToastMassage(context, 'আপনার পাসওয়ার্ড ভূল হয়েছে');
                  }else if(value['status']==650){
                    setState(() {
                      _isLoading=false;
                    });
                    showToastMassage(context, 'দুঃখিত ! আপনার ব্যবহৃত মোবাইলটি অ্যাপ্স ব্যবহারের জন্য অনুমোদিত নয়। অনুগ্রহকরে অথিরিটির সাথে যোগাযোগ করুন।');
                  }else if(value['status']==402){
                    setState(() {
                      _isLoading=false;
                    });
                    showToastMassage(context, 'আপনার ইউজার নাম ভূল হয়েছে');
                  }else if(value['status']==550){
                    setState(() {
                      _isLoading=false;
                    });
                    showToastMassage(context, 'দুঃখিত !এটি আপনার জন্য অনুমোদিত মোবাইল নয়। অনুগ্রহকরে অথিরিটির সাথে যোগাযোগ করুন।');
                  }
                  else{
                    setState(() {
                      _isLoading=false;
                    });
                    showToastMassage(context, 'আবশ্যক তথ্যগুলো প্রদান করুন');
                  }
                });
              }else{
                setState(() {
                  _isLoading=false;
                });
                showToastMassage(context, 'আপনার ইন্টারনেট কানেকশন চেক করুন এবং আবার ট্রাই করুন');
              }
            });
          } else {
            print("form is invalid");
            setState(() {
              _isLoading=false;
            });
            Fluttertoast.showToast(
                msg: "check username or password and try again",
                toastLength: Toast.LENGTH_LONG,
                gravity: ToastGravity.CENTER,
                timeInSecForIosWeb: 1,
                backgroundColor: Colors.amberAccent,
                textColor: Colors.redAccent,
                fontSize: 15.0
            );
          }
        },
        padding: EdgeInsets.all(15.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30.0),
        ),
        color: AppTheme.mainInfo,
        child: Text(
          'প্রবেশ করুন',
          style: TextStyle(
            color:AppTheme.nearlyWhite,
            letterSpacing: 1.5,
            fontSize: 18.0,
            fontWeight: FontWeight.bold,
            fontFamily: 'OpenSans',
          ),
        ),
      ),
    );
  }

  Widget checkDeviceId(BuildContext context){
    return Padding(padding: EdgeInsets.only(top: 10),
    child: GestureDetector(
      onTap: ()=>singleTextAlertDailog(context, "ফোন আইডি", uniqueId),
      child: Text(
        "আপনার ডিভাইস আইডি দেখুন",
        style: TextStyle(
            decoration: TextDecoration.underline,
            color: Colors.white,
            fontWeight: FontWeight.w500,
            fontSize: 13
        ),
      ),
    ),);
  }

}

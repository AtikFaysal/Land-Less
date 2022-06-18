import 'package:flutter/material.dart';
import 'package:land_less/AppTheme/app_theme.dart';
import 'package:land_less/screen/dashboard_info.dart';
import 'package:land_less/screen/main_dashboard.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:splashscreen/splashscreen.dart';

Future<void>main()async{
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String _userId=prefs.getString('userId');
  
  runApp( MaterialApp(
    debugShowCheckedModeBanner: false,
    theme: ThemeData(

      primaryColor:  Color(0xff003c8f),
      accentColor:  Color(0xff78909c),
      cursorColor: Color(0xfffd9992),
      textTheme: TextTheme(
        display2: TextStyle(
          fontFamily: 'OpenSans',
          fontSize: 45.0,
          color: Colors.orange,
        ),
        button: TextStyle(
          fontFamily: 'OpenSans',
        ),
        subhead: TextStyle(fontFamily: 'NotoSans'),
        body1: TextStyle(fontFamily: 'NotoSans'),
      ),
    ),
    home:_userId==null?SplashPage():AllServiceDashboard()
  ));
}

class SplashPage extends StatefulWidget {
  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {

  @override
  Widget build(BuildContext context) {
    return SplashScreen(
        seconds: 4,
        navigateAfterSeconds:MainDashboard(),
        title: new Text('প্রজেক্ট ইমপ্লিমেন্টেশন ট্র্যাকিং',
          style: new TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 25.0,color: AppTheme.mainInfo
          ),),
        image: Image.asset("assets/images/mainLogo.png"),
        //backgroundColor: AppTheme.mainColor,
        gradientBackground:LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            AppTheme.mainColor,
            AppTheme.mainColor,
          ],
          //stops: [0.1, 0.4, 0.7, 0.9],
          tileMode: TileMode.repeated,
        ),
        styleTextUnderTheLoader: new TextStyle(),
        photoSize: 100.0,
        onClick: ()=>print("Flutter Egypt"),
        loaderColor: AppTheme.subColors
    );
  }
}

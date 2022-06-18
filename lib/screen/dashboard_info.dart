import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:land_less/AppTheme/app_theme.dart';
import 'package:land_less/screen/login_page.dart';
import 'package:land_less/screen/public_show_member.dart';
class MainDashboard extends StatefulWidget {
  @override
  _MainDashboardState createState() => _MainDashboardState();
}

class _MainDashboardState extends State<MainDashboard> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.light,
        child: Container(
          child: Stack(
            children: [
              Container(
                height: double.infinity,
                width: double.infinity,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      AppTheme.mainColor,
                      AppTheme.mainColor

                    ],
                    //stops: [0.1, 0.4, 0.7, 0.9],
                    tileMode: TileMode.repeated,
                  ),
                ),
              ),
              Container(
                child: SingleChildScrollView(
                  physics: AlwaysScrollableScrollPhysics(),
                  padding: EdgeInsets.symmetric(
                    horizontal: 20.0,
                    vertical: 70.0,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          new FlatButton(
                            color: Colors.transparent,
                              child: Row(
                                children: <Widget>[
                                  Icon(
                                    Icons.search,
                                    size: 30,
                                    color: AppTheme.nearlyWhite,
                                  ),
                                  Text(
                                    'গ্রাহক অনুসন্ধান',
                                    style: TextStyle(
                                        color: AppTheme.nearlyWhite,
                                        fontWeight: FontWeight.w500,
                                        fontSize: 19
                                    ),
                                  ),

                                ],
                              ),
                              onPressed: ()=>Navigator.of(context).push(MaterialPageRoute(builder: (context)=>PublicShowData())),
                            shape: RoundedRectangleBorder(side: BorderSide(
                                color: AppTheme.mainInfo,
                                width: 1,
                                style: BorderStyle.solid
                            ), borderRadius: BorderRadius.circular(8)),
                          ),
                          new FlatButton(
                            color: Colors.transparent,
                              child: Row(
                                children: <Widget>[
                                  Icon(
                                    Icons.person,
                                    size: 30,
                                    color: AppTheme.nearlyWhite,
                                  ),
                                  Text(
                                    'লগইন করুন',
                                    style: TextStyle(
                                      color: AppTheme.nearlyWhite,
                                      fontWeight: FontWeight.w500,
                                      fontSize: 19
                                    ),
                                  ),
                                ],
                              ),
                              onPressed: ()=>Navigator.of(context).push(MaterialPageRoute(builder: (context)=>LoginScreen())),
                            shape: RoundedRectangleBorder(side: BorderSide(
                                color: AppTheme.mainInfo,
                                width: 1,
                                style: BorderStyle.solid
                            ), borderRadius: BorderRadius.circular(8)),
                          )
                        ],
                      ),
                      Padding(padding: EdgeInsets.only(top: 80),
                      child: Container(
                        height: MediaQuery.of(context).size.height*1.2/3,
                        width: MediaQuery.of(context).size.width*1.8/2,
                        child: Card(
                          color: Colors.transparent,
                          //elevation: 5.5,
                          shape: new RoundedRectangleBorder(borderRadius: new BorderRadius.circular(15.0)),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Padding(padding: EdgeInsets.only(bottom: 40),
                              child: Text('প্রজেক্ট ইমপ্লিমেন্টেশন ট্র্যাকিং',style: TextStyle(
                                fontSize: 25,fontWeight: FontWeight.w500,
                                color: AppTheme.mainInfo
                              ),),),
                              Padding(padding: EdgeInsets.all(10),
                              child:Row(
                                children: [
                                  Text('পরিকল্পনা ও বাস্তবায়নেঃ ',style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 15,
                                    color: Colors.white
                                  ),),
                                  Text('মোঃ মাশফাকুর রহমান',style: TextStyle(
                                      fontWeight: FontWeight.w300,
                                      fontSize: 18,
                                      color: AppTheme.mainInfo
                                  ),),
                                ],
                              ) ,),
                              Padding(padding: EdgeInsets.all(10),
                              child: Text('উপজেলা নির্বাহী অফিসার , রাঙ্গাবালী',style: TextStyle(
                                  fontWeight: FontWeight.w300,
                                  fontSize: 18,
                                  color: AppTheme.mainInfo
                              ),),),
                              Padding(padding: EdgeInsets.all(10),
                                child: Text('সহযোগিতায়ঃ',style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 18,
                                    color: Colors.white
                                ),),),
                              Padding(padding: EdgeInsets.all(5),
                                child: Text('উপজেলা পরিষদ, রাঙ্গাবালী, পটুয়াখালী',style: TextStyle(
                                    fontWeight: FontWeight.w300,
                                    fontSize: 18,
                                    color: AppTheme.mainInfo
                                ),),),
                            ],
                          ),
                        ),
                      ),),
                      Padding(
                        padding: EdgeInsets.only(top: 50),
                        child: Container(
                          height: MediaQuery.of(context).size.height/5,
                          width: MediaQuery.of(context).size.width*1.8/2,
                          child: Card(
                            shape: new RoundedRectangleBorder(borderRadius: new BorderRadius.circular(15.0)),
                            color: Colors.transparent,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              //crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Padding(padding: EdgeInsets.all(10),
                                  child: Text('কারিগরি সহযোগী: ',style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 18,
                                      color: Colors.white
                                  ),),),
                                Padding(padding: EdgeInsets.all(1),
                                  child: Text('ডায়নামিক হোষ্ট বিডি',style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 18,
                                      color: AppTheme.mainInfo
                                  ),),),
                                Padding(padding: EdgeInsets.all(5),
                                  child:Text('www.dhostbd.com',style: TextStyle(
                                      fontSize: 15,color: AppTheme.mainInfo,fontWeight: FontWeight.w300,decoration:TextDecoration.underline
                                  ),),),
                                Padding(padding: EdgeInsets.all(5),
                                  child:Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text('প্রয়োজনেঃ ',style: TextStyle(
                                          fontWeight: FontWeight.w500,
                                          fontSize: 15,
                                          color: Colors.white
                                      ),),
                                      Text('০১৩০৩০০৯০৫২',style: TextStyle(
                                          fontWeight: FontWeight.w300,
                                          fontSize: 18,
                                          color: AppTheme.mainInfo
                                      ),),
                                    ],
                                  ) ,),

                              ],
                            ),
                          ),
                        ),
                      )
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

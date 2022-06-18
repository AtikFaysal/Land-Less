import 'package:flutter/material.dart';
import 'package:land_less/AppTheme/app_theme.dart';
import 'package:land_less/model/login_response.dart';
import 'package:land_less/screen/dashboard_info.dart';
import 'package:land_less/utils/shared_prefrence.dart';
class LogoutScreen extends StatelessWidget {
  LoginResponse loginResponse;

  LogoutScreen(this.loginResponse);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: FloatingActionButton.extended(
          onPressed: ()  async{
            UserPreferences().removeUser();
            Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(
                builder: (BuildContext context) => MainDashboard()), (
                Route<dynamic> route) => false);
          },
          label: Text('লগআউট করুন',style: TextStyle(color: AppTheme.mainColor),),
          icon: Icon(
            Icons.logout,
            color: AppTheme.mainColor,
          ),
          backgroundColor: AppTheme.mainInfo,
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      body: ListView(
        children: [
          Column(
            children: [
              new Container(
                height: 180.0,
                color: Colors.white,
                child: new Column(
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.only(top: 30.0),
                      child:
                      new Stack(fit: StackFit.loose, children: <
                          Widget>[
                        new Row(
                          crossAxisAlignment:
                          CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            new Container(
                              width: 140.0,
                              height: 140.0,
                              decoration: new BoxDecoration(
                                  shape: BoxShape.circle,
                                  image: new DecorationImage(
                                    image: loginResponse.response.userImage==null?AssetImage('assets/images/person.png'):NetworkImage(loginResponse.response.fileDirectory+loginResponse.response.userImage),
                                    //image: AssetImage('assets/images/person.png'),
                                    fit: BoxFit.cover,
                                  )),
                            )
                          ],
                        ),
                      ]),
                    ),

                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 10,bottom: 25),
                child: Container(
                  //height: MediaQuery.of(context).size.height/6,
                  width: MediaQuery.of(context).size.width*1.8/2,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(7.0),
                      color: Colors.white,
                      border: Border.all(color: AppTheme.subColors,width: 2.0)
                  ),
                  child: Card(
                    elevation: 0.0,
                    shape: new RoundedRectangleBorder(borderRadius: new BorderRadius.circular(15.0)),
                    color: Colors.white,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(padding: EdgeInsets.only(top: 10,left: 5,right: 5,bottom: 5),
                          child:Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text('নাম: ',style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 18,
                                  color: AppTheme.mainColor
                              ),),
                              Text(loginResponse.response.fullName,style: TextStyle(
                                  fontWeight: FontWeight.w300,
                                  fontSize: 18,
                                  color: AppTheme.nearlyBlack
                              ),),
                            ],
                          ) ,),
                        Padding(padding: EdgeInsets.all(5),
                          child:Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text('ইউজার নেম: ',style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 18,
                                  color: AppTheme.mainColor
                              ),),
                              loginResponse.response.userName!=null?Text(loginResponse.response.userName,style: TextStyle(
                                  fontWeight: FontWeight.w300,
                                  fontSize: 18,
                                  color: AppTheme.nearlyBlack
                              ),):Text(''),
                            ],
                          ) ,),
                        Padding(padding: EdgeInsets.all(5),
                          child:Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text('মোবাইল নাম্বার: ',style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 18,
                                  color: AppTheme.mainColor
                              ),),
                              loginResponse.response.mobileNumber!=null?Text(loginResponse.response.mobileNumber,style: TextStyle(
                                  fontWeight: FontWeight.w300,
                                  fontSize: 18,
                                  color: AppTheme.nearlyBlack
                              ),):Text(''),
                            ],
                          ) ,),
                        Padding(padding: EdgeInsets.all(5),
                          child:Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text('ই-মেইল এড্রেস: ',style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 18,
                                  color: AppTheme.mainColor
                              ),),
                              loginResponse.response.userEmail!=null?Flexible(
                                child: Text(loginResponse.response.userEmail,style: TextStyle(
                                    fontWeight: FontWeight.w300,
                                    fontSize: 18,
                                    color: AppTheme.nearlyBlack
                                ),),
                              ):Text(''),
                            ],
                          ) ,),
                        Padding(padding: EdgeInsets.all(5),
                          child:Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text('NID নম্বর: ',style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 18,
                                  color: AppTheme.mainColor
                              ),),
                              loginResponse.response.nationalId!=null?Flexible(
                                child: Text(loginResponse.response.nationalId,style: TextStyle(
                                    fontWeight: FontWeight.w300,
                                    fontSize: 18,
                                    color: AppTheme.nearlyBlack
                                ),),
                              ):Text(''),
                            ],
                          ) ,),
                        Padding(padding: EdgeInsets.all(5),
                          child:Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text('ঠিকানা: ',style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 18,
                                  color: AppTheme.mainColor
                              ),),
                              loginResponse.response.address!=null?Flexible(
                                child: Text(loginResponse.response.address,style: TextStyle(
                                    fontWeight: FontWeight.w300,
                                    fontSize: 18,
                                    color: AppTheme.nearlyBlack
                                ),),
                              ):Text(''),
                            ],
                          ) ,),
                        Padding(padding: EdgeInsets.all(5),
                          child:Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text('উপজেলা: ',style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 18,
                                  color: AppTheme.mainColor
                              ),),
                              loginResponse.response.upazilaName!=null?Text(loginResponse.response.upazilaName,style: TextStyle(
                                  fontWeight: FontWeight.w300,
                                  fontSize: 18,
                                  color: AppTheme.nearlyBlack
                              ),):Text(''),
                            ],
                          ) ,),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          )
        ],
      )
    );
  }
}

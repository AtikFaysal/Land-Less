import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:land_less/AppTheme/app_theme.dart';
import 'package:land_less/drawer/dc_drawer.dart';
import 'package:land_less/drawer/kabika_dc_drawer.dart';
import 'package:land_less/drawer/kabika_user_drawer.dart';
import 'package:land_less/drawer/tr_dc_drawer.dart';
import 'package:land_less/drawer/tr_user_drawer.dart';
import 'package:land_less/drawer/userdrawer.dart';
import 'package:land_less/model/common_login_model.dart';
import 'package:land_less/model/login_response.dart';
import 'package:land_less/screen/dashboard_info.dart';
import 'package:land_less/service/apiService.dart';
import 'package:land_less/utils/shared_prefrence.dart';
import 'package:land_less/widget/custom_card.dart';
import 'package:land_less/widget/toast_massage.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AllServiceDashboard extends StatefulWidget {
  @override
  _AllServiceDashboardState createState() => _AllServiceDashboardState();
}

class _AllServiceDashboardState extends State<AllServiceDashboard> {

  ProgressDialog pr;
  bool _isLoading=false;
  @override
  Widget build(BuildContext context) {
    pr = new ProgressDialog(context);
    pr.style(
        message: 'অপেক্ষা করুন...',
        borderRadius: 10.0,
        backgroundColor: Colors.white,
        progressWidget: CircularProgressIndicator(),
        elevation: 10.0,
        insetAnimCurve: Curves.easeInOut,
        progress: 0.0,
        maxProgress: 50.0,
        progressTextStyle: TextStyle(
            color: Colors.black, fontSize: 13.0, fontWeight: FontWeight.w400),
        messageTextStyle: TextStyle(
            color: Colors.black, fontSize: 18.0, fontWeight: FontWeight.w600)
    );
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        centerTitle: true,
        title: Text('ড্যাশবোর্ড',style: TextStyle(color: Colors.white,fontWeight: FontWeight.w500,fontSize: 20),),
          actions: [IconButton(icon: Icon(Icons.person_pin,color: AppTheme.mainInfo,), onPressed: ()=>logoutDilog(context))]
      ),
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
                  padding: EdgeInsets.symmetric(
                    vertical: 20,
                    horizontal: 20
                  ),
                  child: _isLoading?Align(

                    child: Text(''),):Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Center(child:CategoryCard(svgSrc: 'assets/images/landless.png',title: 'আশ্রয়ণ প্রকল্প',
                          press: ()async{
                        setState(() {
                          _isLoading=true;
                        });
                        pr.show();
                            SharedPreferences prefs = await SharedPreferences.getInstance();
                            String _userId=prefs.getString('userId');
                            String _deviceid=prefs.getString('device_id');
                            print(_userId);
                            print(_deviceid);
                        ApiCall().commonLogin(_deviceid, _userId).then((value){
                          if(value.status==200){
                            if(value.response.userRole=='1'){
                              setState(() {
                                _isLoading=false;
                              });
                              pr.hide();
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (BuildContext context) => DcDrawer(value)));
                            }else{
                              setState(() {
                                _isLoading=false;
                              });
                              pr.hide();
                          Navigator.of(context).push(MaterialPageRoute(
                          builder: (BuildContext context) => UserDrawer(value)));
                            }
                          }
                        });
                          }
                          ),),
                      SizedBox(height: 10,),
                      Center(child: CategoryCard(svgSrc: 'assets/images/work.png',title: 'কাবিখা',
                          press: ()async{
                            setState(() {
                              _isLoading=true;
                            });
                            pr.show();
                            SharedPreferences prefs = await SharedPreferences.getInstance();
                            String _userId=prefs.getString('userId');
                            String _deviceid=prefs.getString('device_id');
                            ApiCall().commonLogin(_deviceid, _userId).then((value){
                              if(value.status==200){
                                if(value.response.userRole=='1'){
                                  setState(() {
                                    _isLoading=false;
                                  });
                                  pr.hide();
                                  Navigator.of(context).push(MaterialPageRoute(
                                      builder: (BuildContext context) => Kabikha_DcDrawer(value)));
                                }else{
                                  setState(() {
                                    _isLoading=false;
                                  });
                                  pr.hide();
                                  Navigator.of(context).push(MaterialPageRoute(
                                      builder: (BuildContext context) => KabikhaUserDrawer(value)));
                                }
                              }
                            });
                          }),),
                      SizedBox(height: 10,),
                      Center(child: CategoryCard(svgSrc: 'assets/images/workIcon.png',title: 'টি.আর',
                          press: ()async{
                            setState(() {
                              _isLoading=true;
                            });
                            pr.show();
                            SharedPreferences prefs = await SharedPreferences.getInstance();
                            String _userId=prefs.getString('userId');
                            String _deviceid=prefs.getString('device_id');
                            ApiCall().commonLogin(_deviceid, _userId).then((value){
                              if(value.status==200){
                                if(value.response.userRole=='1'){
                                  setState(() {
                                    _isLoading=false;
                                  });
                                  pr.hide();
                                  Navigator.of(context).push(MaterialPageRoute(
                                      builder: (BuildContext context) => Tr_DcDrawer(value)));
                                }else{
                                  setState(() {
                                    _isLoading=false;
                                  });
                                  pr.hide();
                                  Navigator.of(context).push(MaterialPageRoute(
                                      builder: (BuildContext context) => TrUserDrawer(value)));
                                }
                              }
                            });
                          }),)

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

  logoutDilog(BuildContext context){
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10.0))),
          title: Center(child: Icon(Icons.person,size: 30,)),
          content: Container(
            height: 80,
            child: Center(
              child: Text(''),
            ),
          ),
          actions: [
            Padding(
              padding: EdgeInsets.only(right: 100),
              child:  RaisedButton(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(7.0),
                    side: BorderSide(color: Colors.red)),
                onPressed: () async{
                  UserPreferences().removeUser();
                  Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(
                      builder: (BuildContext context) => MainDashboard()), (
                      Route<dynamic> route) => false);
                },
                color: AppTheme.mainColor,
                textColor: Colors.white,
                child: Text("Logout".toUpperCase(),
                    style: TextStyle(fontSize: 15,fontWeight: FontWeight.w400)),
              ),)
          ],
        );
      },
    );
  }
}

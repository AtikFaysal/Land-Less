import 'package:drawerbehavior/drawerbehavior.dart';
import 'package:flutter/material.dart';
import 'package:land_less/AppTheme/app_theme.dart';
import 'package:land_less/kabikha/k_Page/k_Dashboard.dart';
import 'package:land_less/kabikha/k_Page/k_list_info.dart';
import 'package:land_less/kabikha/k_Page/k_reportPage.dart';
import 'package:land_less/model/login_response.dart';
import 'package:land_less/screen/dashboard_info.dart';
import 'package:land_less/screen/user_profile.dart';
import 'package:land_less/utils/kabikha_dc_drawr_menu.dart';
import 'package:land_less/utils/shared_prefrence.dart';
import 'package:land_less/view_model/kabikhaList.dart';
import 'package:land_less/view_model/landless_people_provider.dart';
import 'package:land_less/widget/logout_screen.dart';
import 'package:provider/provider.dart';
class Kabikha_DcDrawer extends StatefulWidget {
  LoginResponse loginResponse;

  Kabikha_DcDrawer(this.loginResponse);

  @override
  _Kabikha_DcDrawerState createState() => _Kabikha_DcDrawerState(loginResponse);
}

class _Kabikha_DcDrawerState extends State<Kabikha_DcDrawer> {
  LoginResponse loginResponse;

  _Kabikha_DcDrawerState(this.loginResponse);

  int selectedMenuItemId;
  String pageName='ড্যাশবোর্ড';

  @override
  void initState() {
    selectedMenuItemId = menuWithIconDcKabikha.items[0].id;

    super.initState();
  }

  Widget headerView(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          padding: EdgeInsets.fromLTRB(16, 12, 16, 0),
          child: Row(
            children: <Widget>[
              new Container(
                  width: 48.0,
                  height: 48.0,
                  decoration: new BoxDecoration(
                      shape: BoxShape.circle,
                      image: new DecorationImage(
                          fit: BoxFit.fill,
                          image: loginResponse.response.userImage!=null?
                          NetworkImage(loginResponse.response.fileDirectory+loginResponse.response.userImage):AssetImage('assets/images/logo.png')))),
              Container(
                  margin: EdgeInsets.only(left: 16),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        loginResponse.response.fullName,
                        style: Theme.of(context)
                            .textTheme
                            .subhead
                            .copyWith(color: Colors.white),
                      ),
                      Text(
                        'ব্যবহারকারী',
                        style: Theme.of(context)
                            .textTheme
                            .subtitle
                            .copyWith(color: Colors.white.withAlpha(200)),
                      )
                    ],
                  ))
            ],
          ),
        ),
        Divider(
          color: Colors.white.withAlpha(200),
          height: 16,
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<KhabikhaList>.value(
      value: KhabikhaList(),
      child: new MaterialApp(
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
        home: DrawerScaffold(
          cornerRadius: 0,
          appBar: AppBar(
              elevation: 0.0,
              centerTitle: true,
              leading: IconButton(icon: Icon(Icons.arrow_back),onPressed: ()=>Navigator.of(context).pop(),),
              title: Text(pageName,style: TextStyle(color: Colors.white,fontWeight: FontWeight.w500,fontSize: 18),),
              /*actions: [IconButton(icon: Icon(Icons.person_pin), onPressed: ()=>logoutDilog(context))]*/),
          drawers: [
            SideDrawer(
              percentage: 1,
              menu: menuWithIconDcKabikha,
              headerView: headerView(context),
              animation: true,
              alignment: Alignment.topLeft,
              color: AppTheme.mainColor,
              selectorColor: AppTheme.subColors,
              selectedItemId: selectedMenuItemId,
              onMenuItemSelected: (itemId) {

                setState(() {
                  selectedMenuItemId = itemId;
                  //itemId==0?pageName="DASHBOARD":pageName='REQUISITION';
                  headerTitle(itemId);
                });
              },
            )
          ],
          builder: (context, id) => IndexedStack(
            index: id,
            children: menuWithIconDcKabikha.items
                .map((e) {
              if(e.id==0){
                return KDashboard(loginResponse);
              }else if(e.id==1){
                return KabikhaListInfo(loginResponse);
              }
              else if(e.id==2){
                return  KabikhaReportPage(loginResponse);
              }else if(e.id==3) {
                return UserProfile(loginResponse);
              }else if(e.id==4){
                return LogoutScreen(loginResponse);
              }
              else{
                return KDashboard(loginResponse);
              }
            })

                .toList(),
          ),
        ),
      ),
    );
  }
  headerTitle(dynamic id){
    switch(id){
      case 0:
        pageName="ড্যাশবোর্ড";
        break;
      case 1:
        pageName='কাবিখা প্রকল্প তালিকা';
        break;
      case 2:
        pageName='রিপোর্ট';
        break;
      case 3:
        pageName='আপনার তথ্য পরিবর্তন করুন';
        break;
      case 4:
        pageName='লগআউট';
        break;
      default:
        pageName='ড্যাশবোর্ড';
        break;
    }
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
              child: Text(loginResponse.response.fullName),
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

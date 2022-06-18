import 'package:flutter/material.dart';
import 'package:land_less/AppTheme/app_theme.dart';
import 'package:land_less/model/login_response.dart';
import 'package:land_less/model/up_dashboard_data.dart';
import 'package:land_less/model/upozila_dashboard_data.dart';
import 'package:land_less/service/apiService.dart';
class DashBoard extends StatefulWidget {
  LoginResponse loginResponse;

  DashBoard(this.loginResponse);

  @override
  _DashBoardState createState() => _DashBoardState(loginResponse);
}

class _DashBoardState extends State<DashBoard> {
  LoginResponse loginResponse;


  _DashBoardState(this.loginResponse);

  List<UpazilaDashboardData>_upojalaDashdoardData=[];
  List<UpDashboardData>_upDashboardData=[];
  bool _isLoading=false;

  void dashbordData()async{
    setState(() {
      _isLoading=true;
    });
    ApiCall().getDashboardData(loginResponse.response.deviceId, loginResponse.response.userId,
        loginResponse.response.userRole, loginResponse.response.upazilaId).then((value) {
          print(value.upazilaDashboardData.toString());
       if(value.status==200){
         if(value.upazilaDashboardData.isNotEmpty){
           for(int i=0;i<value.upazilaDashboardData.length;i++){
             setState(() {
               _upojalaDashdoardData.add(value.upazilaDashboardData[i]);
             });
           }
           setState(() {
             _isLoading=false;
           });
         }
         if(value.upDashboardData.isNotEmpty){
           for(int i=0;i<value.upDashboardData.length;i++){
             setState(() {
               _upDashboardData.add(value.upDashboardData[i]);
             });
           }
           setState(() {
             _isLoading=false;
           });
         }
       }else{
         setState(() {
           _isLoading=false;
         });
       }
    });
  }
  @override
  void initState() {
    // TODO: implement initState
    dashbordData();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(8),
        child: _isLoading?Center(child: CircularProgressIndicator(),):Container(
          child: _upojalaDashdoardData.isNotEmpty?ListView.separated(
            itemCount:_upojalaDashdoardData.length ,
            separatorBuilder: (_,int i)=>Divider(),
            itemBuilder: (_,int i){
              return Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(7.0),
                    color: Colors.white,
                    border: Border.all(color: AppTheme.mainColor,width: 2.0)
                ),
                child: Card(
                  elevation: 0.0,
                  child: ListTile(
                    contentPadding: EdgeInsets.all(10),
                    title: Row(
                      children: [
                        Text('উপজেলা: ',style: TextStyle(fontWeight: FontWeight.w300,color: Colors.black,fontSize: 18),),
                        Text(
                          _upojalaDashdoardData[i].upazilaName,style: TextStyle(
                            fontSize:17,fontWeight: FontWeight.w800,color: Colors.black
                        ),
                        ),
                      ],
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text('নির্মাণাধীন ঘর সংখ্যা: ',style: TextStyle(fontWeight: FontWeight.w300,color: Colors.black,fontSize: 15),),
                            Text(
                              _upojalaDashdoardData[i].numberOfUnderConstructionHouse,overflow:TextOverflow.clip,style: TextStyle(
                                fontSize:15,fontWeight: FontWeight.w800,color: Colors.black
                            ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Text('নির্মিত ঘর সংখ্যা: ',style: TextStyle(fontWeight: FontWeight.w300,color: Colors.black,fontSize: 15),),
                            Text(
                              _upojalaDashdoardData[i].numberOfCompleteHouse,style: TextStyle(
                                fontSize:15,fontWeight: FontWeight.w800,color: Colors.black
                            ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ):ListView.separated(
            itemCount:_upDashboardData.length ,
            separatorBuilder: (_,int i)=>Divider(),
            itemBuilder: (_,int i){
              return Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(7.0),
                    color: Colors.white,
                    border: Border.all(color: AppTheme.mainColor,width: 2.0)
                ),
                child: Card(
                  elevation: 0.0,
                  child: ListTile(
                    contentPadding: EdgeInsets.all(10),
                    title: Row(
                      children: [
                        Text('ইউনিয়ন/পৌরসভা: ',style: TextStyle(fontWeight: FontWeight.w300,color: Colors.black,fontSize: 18),),
                        Flexible(
                          child: Text(
                            _upDashboardData[i].upPourashavaName,style: TextStyle(
                              fontSize:17,fontWeight: FontWeight.w800,color: Colors.black
                          ),
                          ),
                        ),
                      ],
                    ),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text('নির্মাণাধীন ঘর সংখ্যা: ',style: TextStyle(fontWeight: FontWeight.w300,color: Colors.black,fontSize: 15),),
                            Text(
                              _upDashboardData[i].numberOfUnderConstructionHouse,style: TextStyle(
                                fontSize:15,fontWeight: FontWeight.w800,color: Colors.black
                            ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Text('নির্মিত ঘর সংখ্যা: ',style: TextStyle(fontWeight: FontWeight.w300,color: Colors.black,fontSize: 15),),
                            Text(
                              _upDashboardData[i].numberOfCompleteHouse,style: TextStyle(
                                fontSize:15,fontWeight: FontWeight.w800,color: Colors.black
                            ),
                            ),
                          ],
                        ),
                      ],
                  ),
                  ),
                ),
              );
            },
          )
        )
      )
    );
  }
}

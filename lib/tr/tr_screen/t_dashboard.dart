import 'package:flutter/material.dart';
import 'package:land_less/AppTheme/app_theme.dart';
import 'package:land_less/kabikha/k_Model/kabikha_dashboard.dart';
import 'package:land_less/model/login_response.dart';
import 'package:land_less/service/tr_apiService.dart';
class TrDashboard extends StatefulWidget {
  LoginResponse loginResponse;

  TrDashboard(this.loginResponse);

  @override
  _TrDashboardState createState() => _TrDashboardState(loginResponse);
}

class _TrDashboardState extends State<TrDashboard> {
  LoginResponse loginResponse;


  _TrDashboardState(this.loginResponse);

  List<UpazilaKabikhaDashboardData>_upojalaDashdoardData=[];
  List<UpKhabikhaDashboardData>_upDashboardData=[];
  bool _isLoading=false;

  void dashbordData()async{
    setState(() {
      _isLoading=true;
    });
    TrApi().getDashboardData(loginResponse.response.deviceId, loginResponse.response.userId,
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
                                  Text('অসম্পূর্ণ প্রকল্প সংখ্যা: ',style: TextStyle(fontWeight: FontWeight.w300,color: Colors.black,fontSize: 15),),
                                  Text(
                                    _upojalaDashdoardData[i].numberOfUnderConstructionProject,overflow:TextOverflow.clip,style: TextStyle(
                                      fontSize:15,fontWeight: FontWeight.w800,color: Colors.black
                                  ),
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  Text('সম্পূর্ণ প্রকল্প সংখ্যা: ',style: TextStyle(fontWeight: FontWeight.w300,color: Colors.black,fontSize: 15),),
                                  Text(
                                    _upojalaDashdoardData[i].numberOfCompleteProject,style: TextStyle(
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
                                  Text('অসম্পূর্ণ প্রকল্প সংখ্যা: ',style: TextStyle(fontWeight: FontWeight.w300,color: Colors.black,fontSize: 15),),
                                  Text(
                                    _upDashboardData[i].numberOfUnderConstructionProject,style: TextStyle(
                                      fontSize:15,fontWeight: FontWeight.w800,color: Colors.black
                                  ),
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  Text('সম্পূর্ণ প্রকল্প সংখ্যা: ',style: TextStyle(fontWeight: FontWeight.w300,color: Colors.black,fontSize: 15),),
                                  Text(
                                    _upDashboardData[i].numberOfCompleteProject,style: TextStyle(
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

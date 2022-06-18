import 'dart:convert';

import 'package:http/http.dart';
import 'package:land_less/kabikha/k_Model/kabikha_dashboard.dart';
import 'package:land_less/kabikha/k_Model/kabikha_report_model.dart';
import 'package:land_less/model/dashboard_model.dart';
import 'package:land_less/service/app_url.dart';

class KhabikhaApi{
  Future<Map<String,dynamic>>getKabikhaInfoById(Map<String,dynamic>task) async {
    Response response = await post(
        AppUrl.kabikhaProjectById,
        body: task,
        //headers: {'Content-Type': 'application/json'},
        headers: {
          "Accept": "application/json",
          //"Content-Type": "application/json"
        },
        encoding: Encoding.getByName("utf-8")
    );
    // response=await dio.post(AppUrl.login,data: loginData,options: new Options(contentType:ContentType.parse("application/x-www-form-urlencoded")));
    print(response.statusCode);
    if (response.statusCode == 200) {
      final Map<String, dynamic> responseData = json.decode(response.body);
      print(responseData.toString());
      // UserToken authUser = UserToken.fromJson(responseData);
      return responseData;
    } else {
      throw Exception("No found");
    }
  }

  Future<KabikhaDashboardData> getDashboardData(String device_id,String user_id,String user_role,String upozila_Id) async {
    final Map<String, dynamic> data = {
      'device_id':device_id,
      'user_id':user_id,
      'user_role':user_role,
      'upazila_id':upozila_Id==null?"":upozila_Id
    };
    print(data.toString());
    //String data=loginData.keys.map((key) => "$key=${loginData[key]}").join("&");
    Response response = await post(
        AppUrl.kabikhaDashboard,
        body: data,
        //headers: {'Content-Type': 'application/json'},
        headers: {
          "Accept": "application/json",
          //"Content-Type": "application/json"
        },
        encoding: Encoding.getByName("utf-8")
    );
    // response=await dio.post(AppUrl.login,data: loginData,options: new Options(contentType:ContentType.parse("application/x-www-form-urlencoded")));

    if (response.statusCode == 200) {
      final Map<String, dynamic> responseData = json.decode(response.body);
      print(responseData.toString());
      // UserToken authUser = UserToken.fromJson(responseData);
      if(responseData['status']==200){
        KabikhaDashboardData dashboardModel=KabikhaDashboardData.fromJson(responseData);
        return dashboardModel;
      }else{
        KabikhaDashboardData dashboardModel=KabikhaDashboardData.fromJson(responseData);
        return dashboardModel ;
      }
    } else {
      throw Exception("No found");
    }
  }

  Future<KabikhaReport>getAccordingToReportProjectById(Map<String,dynamic>task) async {
    Response response = await post(
        AppUrl.KabikhaReport,
        body: task,
        //headers: {'Content-Type': 'application/json'},
        headers: {
          "Accept": "application/json",
          //"Content-Type": "application/json"
        },
        encoding: Encoding.getByName("utf-8")
    );
    // response=await dio.post(AppUrl.login,data: loginData,options: new Options(contentType:ContentType.parse("application/x-www-form-urlencoded")));
    print(response.statusCode);
    if (response.statusCode == 200) {
      final Map<String, dynamic> responseData = json.decode(response.body);
      print(responseData.toString());
      // UserToken authUser = UserToken.fromJson(responseData);
      if(responseData['status']==200){
        KabikhaReport reportList=KabikhaReport.fromJson(responseData);
        return reportList;
      }else{
        KabikhaReport reportList=KabikhaReport.fromJson(responseData);
        return reportList;
      }
    } else {
      throw Exception("No found");
    }
  }
}
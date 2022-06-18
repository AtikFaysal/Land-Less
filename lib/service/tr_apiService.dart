import 'dart:convert';

import 'package:http/http.dart';
import 'package:land_less/kabikha/k_Model/kabikha_dashboard.dart';
import 'package:land_less/service/app_url.dart';
import 'package:land_less/tr/tr_model/tr_report_model.dart';

class TrApi{
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
        AppUrl.trDashboard,
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

  Future<Map<String,dynamic>>trProjectEntry(Map<String,dynamic>task) async {
    Response response = await post(
        AppUrl.trEntryProject,
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

  Future<Map<String,dynamic>>getTrInfoById(Map<String,dynamic>task) async {
    Response response = await post(
        AppUrl.trListItemById,
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
      //print(responseData.toString());
      // UserToken authUser = UserToken.fromJson(responseData);
      return responseData;
    } else {
      throw Exception("No found");
    }
  }

  Future<Map<String,dynamic>>approvedTrItem(Map<String,dynamic>task) async {
    Response response = await post(
        AppUrl.trApprovedItem,
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

  Future<Map<String,dynamic>>rejectTrItem(Map<String,dynamic>task) async {
    Response response = await post(
        AppUrl.trRejectItem,
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

  Future<TrReportById>getTrProjectReportById(Map<String,dynamic>task) async {
    Response response = await post(
        AppUrl.trReportShow,
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
        TrReportById reportList=TrReportById.fromJson(responseData);
        return reportList;
      }else{
        TrReportById reportList=TrReportById.fromJson(responseData);
        return reportList;
      }
    } else {
      throw Exception("No found");
    }
  }
}
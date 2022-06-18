import 'dart:convert';

import 'package:http/http.dart';
import 'package:land_less/model/dashboard_model.dart';
import 'package:land_less/model/landless_memberList.dart';
import 'package:land_less/model/login_response.dart';
import 'package:land_less/model/post_landless_member.dart';
import 'package:land_less/model/public_data_model.dart';
import 'package:land_less/model/public_member.dart';
import 'package:land_less/model/public_member_ById.dart';
import 'package:land_less/model/report_member_list.dart';
import 'package:land_less/model/user_response.dart';
import 'package:land_less/screen/landless_people_list.dart';
import 'package:land_less/service/app_url.dart';
import 'package:land_less/utils/shared_prefrence.dart';

class ApiCall{
  Future<Map<String,dynamic>> login(String device_id,String user_name, String password) async {
    final Map<String, dynamic> loginData = {
      'user_name':user_name,
      'password':password,
      'device_id':device_id,
    };
    //String data=loginData.keys.map((key) => "$key=${loginData[key]}").join("&");
    Response response = await post(
        AppUrl.login,
        body: loginData,
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
       UserResponse userResponse=UserResponse.fromJson(responseData['common_response']);

       UserPreferences().saveUser(userResponse);
       return responseData;
     }else{
       return responseData ;
     }
    } else {
      throw Exception(response.body.toString());
    }
  }
  Future<LoginResponse> commonLogin(String device_id, String user_id) async {
    final Map<String, dynamic> loginData = {
      'user_id':user_id,
      'device_id':device_id,
    };
    //String data=loginData.keys.map((key) => "$key=${loginData[key]}").join("&");
    Response response = await post(
        AppUrl.commanLogin,
        body: loginData,
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
        LoginResponse loginResponse=LoginResponse.fromJson(responseData);
        return loginResponse;
      }else{
        LoginResponse loginResponse=LoginResponse.fromJson(responseData);
        return loginResponse;
      }
    } else {
      throw Exception(response.body.toString());
    }
  }
  Future<LandlessMemberList> memberListFromApi(String device_id,String user_id,String user_role,String upozila_Id) async {
    final Map<String, dynamic> data = {
      'device_id':device_id,
      'user_id':user_id,
      'user_role':user_role,
      'upazila_id':upozila_Id
    };
    print(data.toString());
    //String data=loginData.keys.map((key) => "$key=${loginData[key]}").join("&");
    Response response = await post(
        AppUrl.memberListApi,
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
       LandlessMemberList landlessMemberList=LandlessMemberList.fromJson(responseData);
        return landlessMemberList;
      }else{
        LandlessMemberList landlessMemberList=LandlessMemberList.fromJson(responseData);
        return landlessMemberList ;
      }
    } else {
      throw Exception("No found");
    }
  }
  Future<Map<String,dynamic>> memberEntryApi(Map<String,dynamic>task) async {
    Response response = await post(
        AppUrl.memberEntry,
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
  Future<Map<String,dynamic>> memberEntryUpdate(Map<String,dynamic>task) async {
    Response response = await post(
        AppUrl.memberEntryUpdate,
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
  Future<Map<String,dynamic>>getMemberById(Map<String,dynamic>task) async {
    Response response = await post(
        AppUrl.getMemberById,
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

  Future<Map<String,dynamic>>approvedMember(Map<String,dynamic>task) async {
    Response response = await post(
        AppUrl.approvedMember,
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


  Future<Map<String,dynamic>>rejectMember(Map<String,dynamic>task) async {
    Response response = await post(
        AppUrl.rejectMember,
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

  Future<DashboardModel> getDashboardData(String device_id,String user_id,String user_role,String upozila_Id) async {
    final Map<String, dynamic> data = {
      'device_id':device_id,
      'user_id':user_id,
      'user_role':user_role,
      'upazila_id':upozila_Id==null?"":upozila_Id
    };
    print(data.toString());
    //String data=loginData.keys.map((key) => "$key=${loginData[key]}").join("&");
    Response response = await post(
        AppUrl.dashboardApi,
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
        DashboardModel dashboardModel=DashboardModel.fromJson(responseData);
        return dashboardModel;
      }else{
        DashboardModel dashboardModel=DashboardModel.fromJson(responseData);
        return dashboardModel ;
      }
    } else {
      throw Exception("No found");
    }
  }

  Future<PublicData> getPublicData() async {

    Response response = await get(
        AppUrl.getPublicDataApi,
        //headers: {'Content-Type': 'application/json'},
        headers: {
          "Accept": "application/json",
          //"Content-Type": "application/json"
        },
    );
    if (response.statusCode == 200) {
      final Map<String, dynamic> responseData = json.decode(response.body);
      print(responseData.toString());
      // UserToken authUser = UserToken.fromJson(responseData);
      if(responseData['status']==200){
        PublicData publicData=PublicData.fromJson(responseData);
        return publicData;
      }else{
        PublicData publicData=PublicData.fromJson(responseData);
        return publicData;
      }
    } else {
      throw Exception("No found");
    }
  }

  Future<PublicMember> getPublicMember(Map<String,dynamic>task) async {

    print(task.toString());
    //String data=loginData.keys.map((key) => "$key=${loginData[key]}").join("&");
    Response response = await post(
        AppUrl.getPublicMemberApi,
        body: task,
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
        PublicMember publicMember=PublicMember.fromJson(responseData);
        return publicMember;
      }else{
        PublicMember publicMember=PublicMember.fromJson(responseData);
        return publicMember;
      }
    } else {
      throw Exception("No found");
    }
  }
  Future<PublicMemberById> getPublicMemberById(String memberId) async {
    final Map<String, dynamic> data = {
      'member_id':memberId,
    };
    print(data.toString());
    //String data=loginData.keys.map((key) => "$key=${loginData[key]}").join("&");
    Response response = await post(
        AppUrl.getPublicMemberById,
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
        PublicMemberById memberById=PublicMemberById.fromJson(responseData);
        return memberById;
      }else{
        PublicMemberById memberById=PublicMemberById.fromJson(responseData);
        return memberById;
      }
    } else {
      throw Exception("No found");
    }
  }

  Future<UnionData> getUnionData(String upozila_Id) async {
    final Map<String, dynamic> data = {
      'upazila_id':upozila_Id,
    };
    print(data.toString());
    //String data=loginData.keys.map((key) => "$key=${loginData[key]}").join("&");
    Response response = await post(
        AppUrl.unionData,
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
        UnionData unionData=UnionData.fromJson(responseData);
        return unionData;
      }else{
        UnionData unionData=UnionData.fromJson(responseData);
        return unionData;
      }
    } else {
      throw Exception("No found");
    }
  }
  Future<Map<String,dynamic>> changePassword(Map<String,dynamic>task) async {

    Response response = await post(
        AppUrl.changePassword,
        body: task,
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
        return responseData;
      }else{
        return responseData;
      }
    } else {
      throw Exception("No found");
    }
  }
  Future<ReportMemberLisModel>getAccordingToReportMemberById(Map<String,dynamic>task) async {
    Response response = await post(
        AppUrl.showReport,
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
        ReportMemberLisModel reportList=ReportMemberLisModel.fromJson(responseData);
        return reportList;
      }else{
        ReportMemberLisModel reportList=ReportMemberLisModel.fromJson(responseData);
        return reportList;
      }
    } else {
      throw Exception("No found");
    }
  }

  //Kabikha_project_Entry
  Future<Map<String,dynamic>>KabikhaProjectEntry(Map<String,dynamic>task) async {
    Response response = await post(
        AppUrl.kabikhaProjectEntry,
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

  Future<Map<String,dynamic>>approvedKabikha(Map<String,dynamic>task) async {
    Response response = await post(
        AppUrl.approveKhabikha,
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

  Future<Map<String,dynamic>>rejectKhabikha(Map<String,dynamic>task) async {
    Response response = await post(
        AppUrl.rejectKhabikha,
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

}


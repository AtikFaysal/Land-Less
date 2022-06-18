import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart';
import 'package:land_less/model/landless_memberList.dart';
import 'package:land_less/model/member_data.dart';
import 'package:land_less/model/user_response.dart';
import 'package:land_less/service/app_url.dart';
import 'package:land_less/utils/shared_prefrence.dart';

class LandlessPeople extends ChangeNotifier{
  List<MemberData>_memberList;

  List<MemberData> get memberList => _memberList;

  set memberList(List<MemberData> value) {
    _memberList = value;
    notifyListeners();
  }
  Future<List<MemberData>> memberListFromApiProvider(String device_id,String user_id,String user_role,String upozila_Id) async {
    //UserResponse _userResponse=await UserPreferences().getUser();
    final Map<String, dynamic> data = {
      'device_id':device_id,
      'user_id':user_id,
      'user_role':user_role,
      'upazila_id':upozila_Id
    };
    //print(data.toString());
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
    if (response.statusCode == 200) {
      final Map<String, dynamic> responseData = json.decode(response.body);
      //print(responseData.toString());
      if(responseData['status']==200){
        List tempList=responseData['member_data'];
        List<MemberData>data=[];
        for(int i=0;i<tempList.length;i++){
          var member=MemberData.fromJson(tempList[i]);
          data.add(member);
        }
        memberList=data;
        return memberList;
      }
    } else {
      throw Exception("No found");
    }
  }
}
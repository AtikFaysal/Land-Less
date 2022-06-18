import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart';
import 'package:land_less/kabikha/k_Model/kabikha_data.dart';
import 'package:land_less/service/app_url.dart';

class KhabikhaList extends ChangeNotifier{

  List<KabikhaData>_kabikhaListData;

  List<KabikhaData> get kabikhaListData => _kabikhaListData;

  set kabikhaListData(List<KabikhaData> value) {
    _kabikhaListData = value;
    notifyListeners();
  }

  Future<List<KabikhaData>> kabukhaInfoListFromApiProvider(String device_id,String user_id,String user_role,String upozila_Id) async {
    //UserResponse _userResponse=await UserPreferences().getUser();
    final Map<String, dynamic> data = {
      'device_id':device_id,
      'user_id':user_id,
      'user_role':user_role,
      'upazila_id':upozila_Id
    };
    //print(data.toString());
    Response response = await post(
        AppUrl.kabikhaInfoListDataApi,
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
        List tempList=responseData['kabikha_data'];
        List<KabikhaData>data=[];
        for(int i=0;i<tempList.length;i++){
          var member=KabikhaData.fromJson(tempList[i]);
          data.add(member);
        }
        kabikhaListData=data;
        return kabikhaListData;
      }
    } else {
      throw Exception("No found");
    }
  }
}
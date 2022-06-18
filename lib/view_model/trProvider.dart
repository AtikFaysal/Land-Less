import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart';
import 'package:land_less/service/app_url.dart';
import 'package:land_less/tr/tr_model/trListModel.dart';

class TrProvider extends ChangeNotifier{
  List<TrData>_trList;

  List<TrData> get trList => _trList;

  set trList(List<TrData> value) {
    _trList = value;
    notifyListeners();
  }

  Future<List<TrData>> TrInfoListFromApiProvider(String device_id,String user_id,String user_role,String upozila_Id) async {
    //UserResponse _userResponse=await UserPreferences().getUser();
    final Map<String, dynamic> data = {
      'device_id':device_id,
      'user_id':user_id,
      'user_role':user_role,
      'upazila_id':upozila_Id
    };
    //print(data.toString());
    Response response = await post(
        AppUrl.trList,
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
        List tempList=responseData['tr_data'];
        List<TrData>data=[];
        for(int i=0;i<tempList.length;i++){
          var member=TrData.fromJson(tempList[i]);
          data.add(member);
        }
        trList=data;
        return trList;
      }
    } else {
      throw Exception("No found");
    }
  }
}
import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:land_less/service/app_url.dart';

class DioApiCall{
  Future<Map<String,dynamic>>uploadMemberFromDio(FormData _fromData) async {
    var dio = new Dio();
    dio.options.baseUrl = AppUrl.baseURL;
    dio.options.connectTimeout = 5000; //5s
    dio.options.receiveTimeout = 5000;
    var response = await dio.post(AppUrl.dioMemebrEntry,
        data: _fromData,
        options: Options(
            method: 'POST',
            responseType: ResponseType.json // or ResponseType.JSON
        ));
    print("Response status: ${response.statusCode}");
    print("Response data: ${response.data}");
    if (response.statusCode == 200) {
      final Map<String, dynamic> responseData = json.decode(response.data);
      print(responseData.toString());
      // UserToken authUser = UserToken.fromJson(responseData);
      return responseData;
    } else {
      throw Exception("No found");
    }
  }

  Future<Map<String,dynamic>>dioUpdateMemberEntry(FormData _fromData) async {
    var dio = new Dio();
    dio.options.baseUrl = AppUrl.baseURL;
    dio.options.connectTimeout = 5000; //5s
    dio.options.receiveTimeout = 5000;
    var response = await dio.post(AppUrl.dioMemebrEntryUpdate,
        data: _fromData,
        options: Options(
            method: 'POST',
            responseType: ResponseType.json // or ResponseType.JSON
        ));
    print("Response status: ${response.statusCode}");
    print("Response data: ${response.data}");
    if (response.statusCode == 200) {
      final Map<String, dynamic> responseData = json.decode(response.data);
      print(responseData.toString());
      // UserToken authUser = UserToken.fromJson(responseData);
      return responseData;
    } else {
      throw Exception("No found");
    }
  }

  Future<Map<String,dynamic>>dioHouseInformationEntry(FormData _fromData) async {
    var dio = new Dio();
    dio.options.baseUrl = AppUrl.baseURL;
    dio.options.connectTimeout = 10000; //5s
    dio.options.receiveTimeout = 5000;
    var response = await dio.post(AppUrl.postHouseInformation,
        data: _fromData,
        options: Options(
            method: 'POST',
            responseType: ResponseType.json // or ResponseType.JSON
        ));
    print("Response status: ${response.statusCode}");
    print("Response data: ${response.data}");
    if (response.statusCode == 200) {
      final Map<String, dynamic> responseData = json.decode(response.data);
      print(responseData.toString());
      // UserToken authUser = UserToken.fromJson(responseData);
      return responseData;
    } else {
      throw Exception("No found");
    }
  }

  Future<Map<String,dynamic>>dioUpdateKhabikhaProject(FormData _fromData) async {
    var dio = new Dio();
    dio.options.baseUrl = AppUrl.baseURL;
    dio.options.connectTimeout = 5000; //5s
    dio.options.receiveTimeout = 5000;
    var response = await dio.post(AppUrl.khabikhaProjectUpdate,
        data: _fromData,
        options: Options(
            method: 'POST',
            responseType: ResponseType.json // or ResponseType.JSON
        ));
    print("Response status: ${response.statusCode}");
    print("Response data: ${response.data}");
    if (response.statusCode == 200) {
      final Map<String, dynamic> responseData = json.decode(response.data);
      print(responseData.toString());
      // UserToken authUser = UserToken.fromJson(responseData);
      return responseData;
    } else {
      throw Exception("No found");
    }
  }
  Future<Map<String,dynamic>>dioUpdateTrProject(FormData _fromData) async {
    var dio = new Dio();
    dio.options.baseUrl = AppUrl.baseURL;
    dio.options.connectTimeout = 5000; //5s
    dio.options.receiveTimeout = 5000;
    var response = await dio.post(AppUrl.trUpdateListItemById,
        data: _fromData,
        options: Options(
            method: 'POST',
            responseType: ResponseType.json // or ResponseType.JSON
        ));
    print("Response status: ${response.statusCode}");
    print("Response data: ${response.data}");
    if (response.statusCode == 200) {
      final Map<String, dynamic> responseData = json.decode(response.data);
      print(responseData.toString());
      // UserToken authUser = UserToken.fromJson(responseData);
      return responseData;
    } else {
      throw Exception("No found");
    }
  }

  Future<Map<String,dynamic>>dioKhabikhaProjectInformationEntry(FormData _fromData) async {
    var dio = new Dio();
    dio.options.baseUrl = AppUrl.baseURL;
    dio.options.connectTimeout = 10000; //5s
    dio.options.receiveTimeout = 5000;
    var response = await dio.post(AppUrl.kabikhaInfoEntry,
        data: _fromData,
        options: Options(
            method: 'POST',
            responseType: ResponseType.json // or ResponseType.JSON
        ));
    print("Response status: ${response.statusCode}");
    print("Response data: ${response.data}");
    if (response.statusCode == 200) {
      final Map<String, dynamic> responseData = json.decode(response.data);
      print(responseData.toString());
      // UserToken authUser = UserToken.fromJson(responseData);
      return responseData;
    } else {
      throw Exception("No found");
    }
  }
  Future<Map<String,dynamic>>dioTrProjectInformationEntry(FormData _fromData) async {
    var dio = new Dio();
    dio.options.baseUrl = AppUrl.baseURL;
    dio.options.connectTimeout = 10000; //5s
    dio.options.receiveTimeout = 5000;
    var response = await dio.post(AppUrl.trProjectInfoEntry,
        data: _fromData,
        options: Options(
            method: 'POST',
            responseType: ResponseType.json // or ResponseType.JSON
        ));
    print("Response status: ${response.statusCode}");
    print("Response data: ${response.data}");
    if (response.statusCode == 200) {
      final Map<String, dynamic> responseData = json.decode(response.data);
      print(responseData.toString());
      // UserToken authUser = UserToken.fromJson(responseData);
      return responseData;
    } else {
      throw Exception("No found");
    }
  }

  Future<Map<String,dynamic>>dioKabikhaLocation(FormData _fromData) async {
    var dio = new Dio();
    dio.options.baseUrl = AppUrl.baseURL;
    dio.options.connectTimeout = 10000; //5s
    dio.options.receiveTimeout = 5000;
    var response = await dio.post(AppUrl.kabikhaLocationAndImageUpload,
        data: _fromData,
        options: Options(
            method: 'POST',
            responseType: ResponseType.json // or ResponseType.JSON
        ));
    print("Response status: ${response.statusCode}");
    print("Response data: ${response.data}");
    if (response.statusCode == 200) {
      final Map<String, dynamic> responseData = json.decode(response.data);
      print(responseData.toString());
      // UserToken authUser = UserToken.fromJson(responseData);
      return responseData;
    } else {
      throw Exception("No found");
    }
  }

  Future<Map<String,dynamic>>dioTrLocation(FormData _fromData) async {
    var dio = new Dio();
    dio.options.baseUrl = AppUrl.baseURL;
    dio.options.connectTimeout = 10000; //5s
    dio.options.receiveTimeout = 5000;
    var response = await dio.post(AppUrl.trImageAndLocation,
        data: _fromData,
        options: Options(
            method: 'POST',
            responseType: ResponseType.json // or ResponseType.JSON
        ));
    print("Response status: ${response.statusCode}");
    print("Response data: ${response.data}");
    if (response.statusCode == 200) {
      final Map<String, dynamic> responseData = json.decode(response.data);
      print(responseData.toString());
      // UserToken authUser = UserToken.fromJson(responseData);
      return responseData;
    } else {
      throw Exception("No found");
    }
  }

}
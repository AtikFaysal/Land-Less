import 'package:land_less/model/response.dart';
import 'package:land_less/model/up_data.dart';
import 'package:land_less/model/upojala_data.dart';
import 'package:land_less/model/year_data.dart';

class LoginResponse {
  int status;
  String message;
  Response response;
  List<YearJsonData> yearJsonData;
  List<UpazilaData> upazilaData;
  List<UpData> upData;

  LoginResponse(
      {this.status,
        this.message,
        this.response,
        this.yearJsonData,
        this.upazilaData,
        this.upData});

  LoginResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    response = json['response'] != null
        ? new Response.fromJson(json['response'])
        : null;
    if (json['year_json_data'] != null) {
      yearJsonData = new List<YearJsonData>();
      json['year_json_data'].forEach((v) {
        yearJsonData.add(new YearJsonData.fromJson(v));
      });
    }
    if (json['upazila_data'] != null) {
      upazilaData = new List<UpazilaData>();
      json['upazila_data'].forEach((v) {
        upazilaData.add(new UpazilaData.fromJson(v));
      });
    }
    if (json['up_data'] != null) {
      upData = new List<UpData>();
      json['up_data'].forEach((v) {
        upData.add(new UpData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.response != null) {
      data['response'] = this.response.toJson();
    }
    if (this.yearJsonData != null) {
      data['year_json_data'] =
          this.yearJsonData.map((v) => v.toJson()).toList();
    }
    if (this.upazilaData != null) {
      data['upazila_data'] = this.upazilaData.map((v) => v.toJson()).toList();
    }
    if (this.upData != null) {
      data['up_data'] = this.upData.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
import 'package:land_less/model/up_dashboard_data.dart';
import 'package:land_less/model/upozila_dashboard_data.dart';

class DashboardModel {
  int status;
  String message;
  List<UpazilaDashboardData> upazilaDashboardData;
  List<UpDashboardData> upDashboardData;

  DashboardModel(
      {this.status,
        this.message,
        this.upazilaDashboardData,
        this.upDashboardData});

  DashboardModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['upazila_dashboard_data'] != null) {
      upazilaDashboardData = new List<UpazilaDashboardData>();
      json['upazila_dashboard_data'].forEach((v) {
        upazilaDashboardData.add(new UpazilaDashboardData.fromJson(v));
      });
    }
    if (json['up_dashboard_data'] != null) {
      upDashboardData = new List<UpDashboardData>();
      json['up_dashboard_data'].forEach((v) {
        upDashboardData.add(new UpDashboardData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.upazilaDashboardData != null) {
      data['upazila_dashboard_data'] =
          this.upazilaDashboardData.map((v) => v.toJson()).toList();
    }
    if (this.upDashboardData != null) {
      data['up_dashboard_data'] =
          this.upDashboardData.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
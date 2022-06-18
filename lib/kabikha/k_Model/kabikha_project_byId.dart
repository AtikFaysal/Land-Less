import 'package:land_less/kabikha/k_Model/kabikha_data.dart';
import 'package:land_less/kabikha/k_Model/kabikha_project_info.dart';

class KabikhaDetailsById {
  int status;
  List<KabikhaData> kabikhaData;
  List<ProjectInformation> projectInformation;

  KabikhaDetailsById({this.status, this.kabikhaData, this.projectInformation});

  KabikhaDetailsById.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['kabikha_data'] != null) {
      kabikhaData = new List<KabikhaData>();
      json['kabikha_data'].forEach((v) {
        kabikhaData.add(new KabikhaData.fromJson(v));
      });
    }
    if (json['project_information'] != null) {
      projectInformation = new List<ProjectInformation>();
      json['project_information'].forEach((v) {
        projectInformation.add(new ProjectInformation.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    if (this.kabikhaData != null) {
      data['kabikha_data'] = this.kabikhaData.map((v) => v.toJson()).toList();
    }
    if (this.projectInformation != null) {
      data['project_information'] =
          this.projectInformation.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
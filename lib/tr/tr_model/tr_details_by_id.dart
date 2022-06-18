import 'package:land_less/kabikha/k_Model/kabikha_project_info.dart';
import 'package:land_less/tr/tr_model/trListModel.dart';

class TrDetailsById {
  int status;
  List<TrData> trData;
  List<ProjectInformation> projectInformation;

  TrDetailsById({this.status, this.trData, this.projectInformation});

  TrDetailsById.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['tr_data'] != null) {
      trData = new List<TrData>();
      json['tr_data'].forEach((v) {
        trData.add(new TrData.fromJson(v));
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
    if (this.trData != null) {
      data['tr_data'] = this.trData.map((v) => v.toJson()).toList();
    }
    if (this.projectInformation != null) {
      data['project_information'] =
          this.projectInformation.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
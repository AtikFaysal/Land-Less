class KabikhaDashboardData {
  int status;
  String message;
  List<UpazilaKabikhaDashboardData> upazilaDashboardData;
  List<UpKhabikhaDashboardData> upDashboardData;

  KabikhaDashboardData(
      {this.status,
        this.message,
        this.upazilaDashboardData,
        this.upDashboardData});

  KabikhaDashboardData.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['upazila_dashboard_data'] != null) {
      upazilaDashboardData = new List<UpazilaKabikhaDashboardData>();
      json['upazila_dashboard_data'].forEach((v) {
        upazilaDashboardData.add(new UpazilaKabikhaDashboardData.fromJson(v));
      });
    }
    if (json['up_dashboard_data'] != null) {
      upDashboardData = new List<UpKhabikhaDashboardData>();
      json['up_dashboard_data'].forEach((v) {
        upDashboardData.add(new UpKhabikhaDashboardData.fromJson(v));
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

class UpazilaKabikhaDashboardData {
  String upazilaId;
  String upazilaName;
  String numberOfCompleteProject;
  String numberOfUnderConstructionProject;

  UpazilaKabikhaDashboardData(
      {this.upazilaId,
        this.upazilaName,
        this.numberOfCompleteProject,
        this.numberOfUnderConstructionProject});

  UpazilaKabikhaDashboardData.fromJson(Map<String, dynamic> json) {
    upazilaId = json['upazila_id'];
    upazilaName = json['upazila_name'];
    numberOfCompleteProject = json['number_of_complete_project'];
    numberOfUnderConstructionProject =
    json['number_of_under_construction_project'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['upazila_id'] = this.upazilaId;
    data['upazila_name'] = this.upazilaName;
    data['number_of_complete_project'] = this.numberOfCompleteProject;
    data['number_of_under_construction_project'] =
        this.numberOfUnderConstructionProject;
    return data;
  }
}

class UpKhabikhaDashboardData {
  String upPourashavaId;
  String upPourashavaName;
  String projectObserverId;
  String numberOfCompleteProject;
  String numberOfUnderConstructionProject;

  UpKhabikhaDashboardData(
      {this.upPourashavaId,
        this.upPourashavaName,
        this.projectObserverId,
        this.numberOfCompleteProject,
        this.numberOfUnderConstructionProject});

  UpKhabikhaDashboardData.fromJson(Map<String, dynamic> json) {
    upPourashavaId = json['up_pourashava_id'];
    upPourashavaName = json['up_pourashava_name'];
    projectObserverId = json['project_observer_id'];
    numberOfCompleteProject = json['number_of_complete_project'];
    numberOfUnderConstructionProject =
    json['number_of_under_construction_project'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['up_pourashava_id'] = this.upPourashavaId;
    data['up_pourashava_name'] = this.upPourashavaName;
    data['project_observer_id'] = this.projectObserverId;
    data['number_of_complete_project'] = this.numberOfCompleteProject;
    data['number_of_under_construction_project'] =
        this.numberOfUnderConstructionProject;
    return data;
  }
}
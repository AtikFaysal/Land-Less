class KabikhaReport {
  int status;
  List<KabikhaProjectData> kabikhaProjectData;

  KabikhaReport({this.status, this.kabikhaProjectData});

  KabikhaReport.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['kabikha_project_data'] != null) {
      kabikhaProjectData = new List<KabikhaProjectData>();
      json['kabikha_project_data'].forEach((v) {
        kabikhaProjectData.add(new KabikhaProjectData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    if (this.kabikhaProjectData != null) {
      data['kabikha_project_data'] =
          this.kabikhaProjectData.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class KabikhaProjectData {
  String kabikhaProjectId;
  String projectName;
  String projectConstructionAddress;
  String comments;
  String projectStartDate;
  String completionOfProject;
  String projectEndDate;
  String assignedAmount;
  String entryDate;
  String approvedDate;
  String status;
  String financialYearId;
  String financialYear;
  String upazilaId;
  String upazilaName;
  String upPourashavaId;
  String upPourashavaName;
  String approvedBy;
  String createdBy;

  KabikhaProjectData(
      {this.kabikhaProjectId,
        this.projectName,
        this.projectConstructionAddress,
        this.comments,
        this.projectStartDate,
        this.completionOfProject,
        this.projectEndDate,
        this.assignedAmount,
        this.entryDate,
        this.approvedDate,
        this.status,
        this.financialYearId,
        this.financialYear,
        this.upazilaId,
        this.upazilaName,
        this.upPourashavaId,
        this.upPourashavaName,
        this.approvedBy,
        this.createdBy});

  KabikhaProjectData.fromJson(Map<String, dynamic> json) {
    kabikhaProjectId = json['kabikha_project_id'];
    projectName = json['project_name'];
    projectConstructionAddress = json['project_construction_address'];
    comments = json['comments'];
    projectStartDate = json['project_start_date'];
    completionOfProject = json['completion_of_project'];
    projectEndDate = json['project_end_date'];
    assignedAmount = json['assigned_amount'];
    entryDate = json['entry_date'];
    approvedDate = json['approved_date'];
    status = json['status'];
    financialYearId = json['financial_year_id'];
    financialYear = json['financial_year'];
    upazilaId = json['upazila_id'];
    upazilaName = json['upazila_name'];
    upPourashavaId = json['up_pourashava_id'];
    upPourashavaName = json['up_pourashava_name'];
    approvedBy = json['approved_by'];
    createdBy = json['created_by'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['kabikha_project_id'] = this.kabikhaProjectId;
    data['project_name'] = this.projectName;
    data['project_construction_address'] = this.projectConstructionAddress;
    data['comments'] = this.comments;
    data['project_start_date'] = this.projectStartDate;
    data['completion_of_project'] = this.completionOfProject;
    data['project_end_date'] = this.projectEndDate;
    data['assigned_amount'] = this.assignedAmount;
    data['entry_date'] = this.entryDate;
    data['approved_date'] = this.approvedDate;
    data['status'] = this.status;
    data['financial_year_id'] = this.financialYearId;
    data['financial_year'] = this.financialYear;
    data['upazila_id'] = this.upazilaId;
    data['upazila_name'] = this.upazilaName;
    data['up_pourashava_id'] = this.upPourashavaId;
    data['up_pourashava_name'] = this.upPourashavaName;
    data['approved_by'] = this.approvedBy;
    data['created_by'] = this.createdBy;
    return data;
  }
}
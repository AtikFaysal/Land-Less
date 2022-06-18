class TrData {
  String trProjectId;
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
  double latitude;
  double longitude;
  String file_directory;
  String image;

  TrData(
      {this.trProjectId,
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
        this.createdBy,this.latitude,this.longitude,this.file_directory,this.image});

  TrData.fromJson(Map<String, dynamic> json) {
    trProjectId = json['tr_project_id'];
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
    latitude=json['latitude'];
    longitude=json['longitude'];
    file_directory=json['file_directory'];
    image=json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['tr_project_id'] = this.trProjectId;
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
    data['latitude'] = this.latitude;
    data['longitude'] = this.longitude;
    data['file_directory']=this.file_directory;
    data['image']=this.image;
    return data;
  }
}
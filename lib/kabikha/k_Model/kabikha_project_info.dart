class ProjectInformation {
  String kabikhaProjectConstructionId;
  String kabikhaProjectId;
  String details;
  String image;
  String fileDirectory;
  String status;
  String entryDate;
  double latitude;
  double longitude;

  ProjectInformation(
      {this.kabikhaProjectConstructionId,
        this.kabikhaProjectId,
        this.details,
        this.image,
        this.fileDirectory,
        this.status,
        this.entryDate,this.latitude,this.longitude});

  ProjectInformation.fromJson(Map<String, dynamic> json) {
    kabikhaProjectConstructionId = json['kabikha_project_construction_id'];
    kabikhaProjectId = json['kabikha_project_id'];
    details = json['details'];
    image = json['image'];
    fileDirectory = json['file_directory'];
    status = json['status'];
    entryDate = json['entry_date'];
    latitude=json['latitude'];
    longitude=json['longitude'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['kabikha_project_construction_id'] = this.kabikhaProjectConstructionId;
    data['kabikha_project_id'] = this.kabikhaProjectId;
    data['details'] = this.details;
    data['image'] = this.image;
    data['file_directory'] = this.fileDirectory;
    data['status'] = this.status;
    data['entry_date'] = this.entryDate;
    data['latitude'] = this.latitude;
    data['longitude'] = this.longitude;
    return data;
  }
}
class HouseInformation {
  String houseBuildingInfoId;
  String memberId;
  String details;
  String image;
  String fileDirectory;
  String status;
  String entryDate;
  double latitude;
  double longitude;

  HouseInformation(
      {this.houseBuildingInfoId,
        this.memberId,
        this.details,
        this.image,
        this.fileDirectory,
        this.status,
        this.entryDate,
      this.latitude,
      this.longitude});

  HouseInformation.fromJson(Map<String, dynamic> json) {
    houseBuildingInfoId = json['house_building_info_id'];
    memberId = json['member_id'];
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
    data['house_building_info_id'] = this.houseBuildingInfoId;
    data['member_id'] = this.memberId;
    data['details'] = this.details;
    data['image'] = this.image;
    data['file_directory'] = this.fileDirectory;
    data['status'] = this.status;
    data['entry_date'] = this.entryDate;
    data['latitude']=this.latitude;
    data['longitude']=this.longitude;
    return data;
  }
}
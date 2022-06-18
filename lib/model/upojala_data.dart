class UpazilaData {
  String upazilaId;
  String upazilaName;
  String status;

  UpazilaData({this.upazilaId, this.upazilaName, this.status});

  UpazilaData.fromJson(Map<String, dynamic> json) {
    upazilaId = json['upazila_id'];
    upazilaName = json['upazila_name'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['upazila_id'] = this.upazilaId;
    data['upazila_name'] = this.upazilaName;
    data['status'] = this.status;
    return data;
  }
}
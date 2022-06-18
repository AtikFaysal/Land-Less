class PublicData {
  int status;
  List<PublicUpazilaData> publicUpazilaData;

  PublicData({this.status, this.publicUpazilaData,});

  PublicData.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['public_upazila_data'] != null) {
      publicUpazilaData = new List<PublicUpazilaData>();
      json['public_upazila_data'].forEach((v) {
        publicUpazilaData.add(new PublicUpazilaData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    if (this.publicUpazilaData != null) {
      data['public_upazila_data'] =
          this.publicUpazilaData.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class PublicUpazilaData {
  String upazilaId;
  String upazilaName;
  String status;

  PublicUpazilaData({this.upazilaId, this.upazilaName, this.status});

  PublicUpazilaData.fromJson(Map<String, dynamic> json) {
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

class PublicUpData {
  String upazilaId;
  String upPourashavaId;
  String upPourashavaName;
  String projectObserverId;
  String status;

  PublicUpData(
      {this.upazilaId,
        this.upPourashavaId,
        this.upPourashavaName,
        this.projectObserverId,
        this.status});

  PublicUpData.fromJson(Map<String, dynamic> json) {
    upazilaId = json['upazila_id'];
    upPourashavaId = json['up_pourashava_id'];
    upPourashavaName = json['up_pourashava_name'];
    projectObserverId = json['project_observer_id'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['upazila_id'] = this.upazilaId;
    data['up_pourashava_id'] = this.upPourashavaId;
    data['up_pourashava_name'] = this.upPourashavaName;
    data['project_observer_id'] = this.projectObserverId;
    data['status'] = this.status;
    return data;
  }
}
class UnionData{
  int status;
  List<PublicUpData>publicUpData;

  UnionData({this.status, this.publicUpData});

  UnionData.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['public_up_data'] != null) {
      publicUpData = new List<PublicUpData>();
      json['public_up_data'].forEach((v) {
        publicUpData.add(new PublicUpData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    if (this.publicUpData != null) {
      data['public_upazila_data'] =
          this.publicUpData.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
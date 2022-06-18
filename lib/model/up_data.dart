class UpData {
  String upazilaId;
  String upPourashavaId;
  String upPourashavaName;
  String projectObserverId;
  String status;

  UpData(
      {this.upazilaId,
        this.upPourashavaId,
        this.upPourashavaName,
        this.projectObserverId,
        this.status});

  UpData.fromJson(Map<String, dynamic> json) {
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
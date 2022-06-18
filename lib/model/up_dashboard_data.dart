class UpDashboardData {
  String upPourashavaId;
  String upPourashavaName;
  String projectObserverId;
  String numberOfCompleteHouse;
  String numberOfUnderConstructionHouse;

  UpDashboardData(
      {this.upPourashavaId,
        this.upPourashavaName,
        this.projectObserverId,
        this.numberOfCompleteHouse,
        this.numberOfUnderConstructionHouse});

  UpDashboardData.fromJson(Map<String, dynamic> json) {
    upPourashavaId = json['up_pourashava_id'];
    upPourashavaName = json['up_pourashava_name'];
    projectObserverId = json['project_observer_id'];
    numberOfCompleteHouse = json['number_of_complete_house'];
    numberOfUnderConstructionHouse = json['number_of_under_construction_house'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['up_pourashava_id'] = this.upPourashavaId;
    data['up_pourashava_name'] = this.upPourashavaName;
    data['project_observer_id'] = this.projectObserverId;
    data['number_of_complete_house'] = this.numberOfCompleteHouse;
    data['number_of_under_construction_house'] =
        this.numberOfUnderConstructionHouse;
    return data;
  }
}
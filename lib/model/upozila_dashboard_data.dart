class UpazilaDashboardData {
  String upazilaId;
  String upazilaName;
  String numberOfCompleteHouse;
  String numberOfUnderConstructionHouse;

  UpazilaDashboardData(
      {this.upazilaId,
        this.upazilaName,
        this.numberOfCompleteHouse,
        this.numberOfUnderConstructionHouse});

  UpazilaDashboardData.fromJson(Map<String, dynamic> json) {
    upazilaId = json['upazila_id'];
    upazilaName = json['upazila_name'];
    numberOfCompleteHouse = json['number_of_complete_house'];
    numberOfUnderConstructionHouse = json['number_of_under_construction_house'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['upazila_id'] = this.upazilaId;
    data['upazila_name'] = this.upazilaName;
    data['number_of_complete_house'] = this.numberOfCompleteHouse;
    data['number_of_under_construction_house'] =
        this.numberOfUnderConstructionHouse;
    return data;
  }
}
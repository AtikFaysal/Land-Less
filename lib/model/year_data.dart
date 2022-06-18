class YearJsonData {
  String financialYearId;
  String financialYear;
  String status;

  YearJsonData({this.financialYearId, this.financialYear, this.status});

  YearJsonData.fromJson(Map<String, dynamic> json) {
    financialYearId = json['financial_year_id'];
    financialYear = json['financial_year'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['financial_year_id'] = this.financialYearId;
    data['financial_year'] = this.financialYear;
    data['status'] = this.status;
    return data;
  }
}
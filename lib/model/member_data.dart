class MemberData {
  String memberId;
  String memberName;
  String type;
  String fatherName;
  String motherName;
  String dateOfBirth;
  String nid;
  String mobileNumber;
  String address;
  String houseConstructionAddress;
  String entryDate;
  String approvedDate;
  String image;
  String fileDirectory;
  String status;
  String financialYearId;
  String financialYear;
  String upazilaId;
  String upazilaName;
  String upPourashavaId;
  String upPourashavaName;
  String approvedBy;
  String createdBy;

  MemberData(
      {this.memberId,
        this.memberName,
        this.type,
        this.fatherName,
        this.motherName,
        this.dateOfBirth,
        this.nid,
        this.mobileNumber,
        this.address,
        this.houseConstructionAddress,
        this.entryDate,
        this.approvedDate,
        this.image,
        this.fileDirectory,
        this.status,
        this.financialYearId,
        this.financialYear,
        this.upazilaId,
        this.upazilaName,
        this.upPourashavaId,
        this.upPourashavaName,
        this.approvedBy,
        this.createdBy});

  MemberData.fromJson(Map<String, dynamic> json) {
    memberId = json['member_id'];
    memberName = json['member_name'];
    type = json['type'];
    fatherName = json['father_name'];
    motherName = json['mother_name'];
    dateOfBirth = json['date_of_birth'];
    nid = json['nid'];
    mobileNumber = json['mobile_number'];
    address = json['address'];
    houseConstructionAddress = json['house_construction_address'];
    entryDate = json['entry_date'];
    approvedDate = json['approved_date'];
    image = json['image'];
    fileDirectory = json['file_directory'];
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
    data['member_id'] = this.memberId;
    data['member_name'] = this.memberName;
    data['type'] = this.type;
    data['father_name'] = this.fatherName;
    data['mother_name'] = this.motherName;
    data['date_of_birth'] = this.dateOfBirth;
    data['nid'] = this.nid;
    data['mobile_number'] = this.mobileNumber;
    data['address'] = this.address;
    data['house_construction_address'] = this.houseConstructionAddress;
    data['entry_date'] = this.entryDate;
    data['approved_date'] = this.approvedDate;
    data['image'] = this.image;
    data['file_directory'] = this.fileDirectory;
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
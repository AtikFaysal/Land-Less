class PublicMember {
  int status;
  List<PuMemberData> puMemberData;

  PublicMember({this.status, this.puMemberData});

  PublicMember.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['pu_member_data'] != null) {
      puMemberData = new List<PuMemberData>();
      json['pu_member_data'].forEach((v) {
        puMemberData.add(new PuMemberData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    if (this.puMemberData != null) {
      data['pu_member_data'] =
          this.puMemberData.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class PuMemberData {
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
  String upazilaId;
  String upazilaName;
  String upPourashavaId;
  String upPourashavaName;
  String approvedBy;
  String createdBy;

  PuMemberData(
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
        this.upazilaId,
        this.upazilaName,
        this.upPourashavaId,
        this.upPourashavaName,
        this.approvedBy,
        this.createdBy});

  PuMemberData.fromJson(Map<String, dynamic> json) {
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
    data['upazila_id'] = this.upazilaId;
    data['upazila_name'] = this.upazilaName;
    data['up_pourashava_id'] = this.upPourashavaId;
    data['up_pourashava_name'] = this.upPourashavaName;
    data['approved_by'] = this.approvedBy;
    data['created_by'] = this.createdBy;
    return data;
  }
}
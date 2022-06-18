import 'package:land_less/model/house_information.dart';
import 'package:land_less/model/member_data.dart';

class LandlessMemberList {
  int status;
  List<MemberData> memberData;
  List<HouseInformation> houseInformation;

  LandlessMemberList({this.status, this.memberData, this.houseInformation});

  LandlessMemberList.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['member_data'] != null) {
      memberData = new List<MemberData>();
      json['member_data'].forEach((v) {
        memberData.add(new MemberData.fromJson(v));
      });
    }
    if (json['house_information'] != null) {
      houseInformation = new List<HouseInformation>();
      json['house_information'].forEach((v) {
        houseInformation.add(new HouseInformation.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    if (this.memberData != null) {
      data['member_data'] = this.memberData.map((v) => v.toJson()).toList();
    }
    if (this.houseInformation != null) {
      data['house_information'] =
          this.houseInformation.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
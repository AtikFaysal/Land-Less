import 'package:land_less/model/member_data.dart';

class ReportMemberLisModel {
  int status;
  List<MemberData> memberData;

  ReportMemberLisModel({this.status, this.memberData});

  ReportMemberLisModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['member_data'] != null) {
      memberData = new List<MemberData>();
      json['member_data'].forEach((v) {
        memberData.add(new MemberData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    if (this.memberData != null) {
      data['member_data'] = this.memberData.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
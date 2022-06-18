
import 'dart:io';

class PostLandlessMember{
  String device_id;
  String user_id;
  String user_role;
  String type;
  String up_pourashava_id;
  String member_name;
  String father_name;
  String mother_name;
  String date_of_birth;
  String nid;
  String mobile_number;
  String address;
  String house_construction_address;
  File image;

  PostLandlessMember({
      this.device_id,
      this.user_id,
      this.user_role,
      this.type,
      this.up_pourashava_id,
      this.member_name,
      this.father_name,
      this.mother_name,
      this.date_of_birth,
      this.nid,
      this.mobile_number,
      this.address,
      this.house_construction_address,
      this.image});

  PostLandlessMember.fromJson(Map<String,dynamic>data){
    device_id=data['device_id'];
    user_id=data['user_id'];
    user_role=data['user_role'];
    type=data['type'];
    up_pourashava_id=data['up_pourashava_id'];
    member_name=data['member_name'];
    father_name=data['father_name'];
    mother_name=data['mother_name'];
    date_of_birth=data['date_of_birth'];
    nid=data['nid'];
    mobile_number=data['mobile_number'];
    address=data['address'];
    house_construction_address=data['house_construction_address'];
    image=data['image'];
  }

  Map<String,dynamic>toJson(){
    final Map<String,dynamic>data=new Map<String,dynamic>();
    data['device_id']=this.device_id;
    data['user_id']=this.user_id;
    data['user_role']=this.user_role;
    data['type']=this.type;
    data['up_pourashava_id']=this.up_pourashava_id;
    data['member_name']=this.member_name;
    data['father_name']=this.father_name;
    data['mother_name']=this.mother_name;
    data['date_of_birth']=this.date_of_birth;
    data['nid']=this.nid;
    data['mobile_number']=this.mobile_number;
    data['address']=this.address;
    data['house_construction_address']=this.house_construction_address;
    data['image']=this.image;

    return data;
  }
}
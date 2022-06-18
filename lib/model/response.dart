class Response {
  String userId;
  String userName;
  String fullName;
  String userRole;
  String upazilaId;
  String upazilaName;
  String deviceId;
  String userEmail;
  String mobileNumber;
  String nationalId;
  String address;
  String userImage;
  String fileDirectory;
  int status;

  Response(
      {this.userId,
        this.userName,
        this.fullName,
        this.userRole,
        this.upazilaId,
        this.upazilaName,
        this.deviceId,
        this.userEmail,
        this.mobileNumber,
        this.nationalId,
        this.address,
        this.userImage,
        this.fileDirectory,
        this.status});

  Response.fromJson(Map<String, dynamic> json) {
    userId = json['user_id'];
    userName = json['user_name'];
    fullName = json['full_name'];
    userRole = json['user_role'];
    upazilaId = json['upazila_id'];
    upazilaName = json['upazila_name'];
    deviceId = json['device_id'];
    userEmail = json['user_email'];
    mobileNumber = json['mobile_number'];
    nationalId = json['national_id'];
    address = json['address'];
    userImage = json['user_image'];
    fileDirectory = json['file_directory'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['user_id'] = this.userId;
    data['user_name'] = this.userName;
    data['full_name'] = this.fullName;
    data['user_role'] = this.userRole;
    data['upazila_id'] = this.upazilaId;
    data['upazila_name'] = this.upazilaName;
    data['device_id'] = this.deviceId;
    data['user_email'] = this.userEmail;
    data['mobile_number'] = this.mobileNumber;
    data['national_id'] = this.nationalId;
    data['address'] = this.address;
    data['user_image'] = this.userImage;
    data['file_directory'] = this.fileDirectory;
    data['status'] = this.status;
    return data;
  }
}

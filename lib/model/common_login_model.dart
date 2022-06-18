class CommonLogin {
  int status;
  String message;
  CommonResponse commonResponse;

  CommonLogin({this.status, this.message, this.commonResponse});

  CommonLogin.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    commonResponse = json['common_response'] != null
        ? new CommonResponse.fromJson(json['common_response'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.commonResponse != null) {
      data['common_response'] = this.commonResponse.toJson();
    }
    return data;
  }
}

class CommonResponse {
  String userId;
  String userRole;
  int status;

  CommonResponse({this.userId, this.userRole, this.status});

  CommonResponse.fromJson(Map<String, dynamic> json) {
    userId = json['user_id'];
    userRole = json['user_role'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['user_id'] = this.userId;
    data['user_role'] = this.userRole;
    data['status'] = this.status;
    return data;
  }
}
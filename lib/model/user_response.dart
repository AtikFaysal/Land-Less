
// ignore: camel_case_types
class UserResponse{
  String userId;
  String userRole;

  UserResponse(
      {this.userId,
        this.userRole,
        });

  factory UserResponse.fromJson(Map<String,dynamic>data){
    return UserResponse(
      userId: data['user_id'],
      userRole: data['user_role'],
    );
  }
}
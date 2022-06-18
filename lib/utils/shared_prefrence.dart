import 'package:land_less/model/user_response.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserPreferences {
  Future<bool> saveUser(UserResponse userResponse) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    prefs.setString("userId", userResponse.userId);
    prefs.setString("userRole", userResponse.userRole);

    print("object prefere");
    print(userResponse.userId);

    return prefs.commit();
  }

  Future<UserResponse> getUser() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    String userId = prefs.getString("userId");
    String userRole = prefs.getString("userRole");

    return UserResponse(
        userId: userId,
        userRole: userRole);
  }

  void removeUser() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    prefs.remove("userId");
    prefs.remove("userRole");
    prefs.remove('device_id');
  }


  Future<String> getUserRole() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String deviceId = prefs.getString("userRole");
    return deviceId;
  }
  Future<String> getUserId() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String userName = prefs.getString("userId");
    return userName;
  }
  Future<String> getDeviceId() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String deviceId = prefs.getString("device_id");
    return deviceId;
  }

}
import 'package:flutter/cupertino.dart';
import 'package:land_less/model/user_response.dart';

class UserProvider with ChangeNotifier{
  UserResponse _userResponse=new UserResponse();

  // ignore: unnecessary_getters_setters
  UserResponse get userResponse => _userResponse;

  // ignore: unnecessary_getters_setters
  set userResponse(UserResponse value) {
    _userResponse = value;
    notifyListeners();
  }
}
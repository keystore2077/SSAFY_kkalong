import 'package:flutter/material.dart';

class UserStore extends ChangeNotifier {
  String accessToken = '';
  changeAccessToken(accesstoken) {
    accessToken = accesstoken;
  }

  String userId = '';
  changeUserInfo(userInfo) {
    userId = userInfo;
  }
}

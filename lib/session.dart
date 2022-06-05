class Session {
  static final Session _session = Session._internal();
  Session._internal();
  static Session get instance => _session;

  static var _userInfo;

  Map get userInfo {
    return _userInfo;
  }

  void setInfo(userInfo) {
    _userInfo = userInfo;
  }
}
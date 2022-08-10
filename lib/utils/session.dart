class Session {
  static final Session _session = Session._internal();
  Session._internal();
  static Session get instance => _session;

  static Map _userInfo = {};
  static Map _dietInfo = {};

  Map get userInfo => _userInfo;

  Map get dietInfo => _dietInfo;

  Future setInfo(userInfo) async {
    _userInfo = userInfo;

    _dietInfo['recom_cal'] = (((_userInfo['height'] - 100) * 0.9) * 30).toInt();
    _dietInfo['recom_hydrate'] = ((_dietInfo['recom_cal'] * 0.55) / 4).toInt();
    _dietInfo['recom_protein'] = ((_dietInfo['recom_cal'] * 0.2) / 4).toInt();
    _dietInfo['recom_fat'] = ((_dietInfo['recom_cal'] * 0.25) / 9).toInt();
    _dietInfo['recom_sugar'] = ((_dietInfo['recom_cal'] * 0.1) / 4).toInt();
    _dietInfo['recom_salt'] = 2300;
    _dietInfo['recom_cholesterol'] = 300;
  }
}
import '../../dbHandler.dart';

class StatisticsDataBuilder {
  var _reportList;

  statisticsDataBuilder() async {
    _reportList = await getReportList();
  }

  Future getData(week) async {

  }
}
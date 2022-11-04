import 'dart:math';

import 'package:ai_dang/utils/session.dart';
import 'package:intl/intl.dart';

import '../../utils/dbHandler.dart';
import 'dart:math';

class SugarData {
  SugarData(this.x, this.y);
  final String x;
  final double? y;
}

class EnergyData {
  EnergyData(this.x, this.y);
  final String x;
  final double? y;
}

class StatisticsDataBuilder {
  Future getData() async {
    var cosumeInfo = await getConsumeInfo();
    List reportList = [];

    List<SugarData> sugarChartData = [];
    List<EnergyData> energyChartData = [];

    Map entireSugarInfo = {};
    int rowCount = 0;
    List entireSugarValList = [];

    List cbHydraList = [];
    List proteinList = [];
    List fatList = [];
    List saltList = [];
    List cholesterolList = [];
    for (var row in cosumeInfo) {
      // 전체 합계인 경우
      if (row['week'] == null) {
        entireSugarValList.sort();
        entireSugarInfo = {
          'average': double.parse((row['sugar_SUM'] / rowCount).toStringAsFixed(2)),
          'max': double.parse(entireSugarValList.last.toStringAsFixed(2)),
          'min': double.parse(entireSugarValList.first.toStringAsFixed(2))
        };
        // 주 소계인 경우
      } else if (row['date'] == null) {
        String weekStr = formatWeek(row['week']);
        int weekRowCnt = sugarChartData.length;
        // 혈당 섭취량 정보 계산
        List sugarValList = getValList(sugarChartData);
        entireSugarValList += sugarValList;
        Map sugarData = {
          'average': double.parse((row['sugar_SUM'] / weekRowCnt).toStringAsFixed(2)),
          'max': double.parse(sugarValList.last.toStringAsFixed(2)),
          'min': double.parse(sugarValList.first.toStringAsFixed(2)),
          'chartData': sugarChartData
        };

        // 칼로리 섭취량 정보 계산
        List energyValList = getValList(energyChartData);
        Map energyData = {
          'average': double.parse((row['energy_SUM'] / weekRowCnt).toStringAsFixed(2)),
          'max': double.parse(energyValList.last.toStringAsFixed(2)),
          'min': double.parse(energyValList.first.toStringAsFixed(2)),
          'chartData': energyChartData
        };

        // 영양소 섭취량 정보 계산
        List<double> nutData = [];
        nutData.add(((row['cbhydra_SUM'] ?? 0.0 / weekRowCnt) / Session.instance.dietInfo['recom_hydrate']) * 10);
        nutData.add(((row['protein_SUM'] ?? 0.0 / weekRowCnt) / Session.instance.dietInfo['recom_protein']) * 10);
        nutData.add(((row['fat_SUM'] ?? 0.0 / weekRowCnt) / Session.instance.dietInfo['recom_fat']) * 10);
        nutData.add(((row['salt_SUM'] ?? 0.0 / weekRowCnt) /  Session.instance.dietInfo['recom_salt']) * 10);
        nutData.add((((row['cholesterol_SUM'] ?? 0.0) / weekRowCnt) / Session.instance.dietInfo['recom_cholesterol']) * 10);
        reportList.add({'week': weekStr, 'sugarData': sugarData, 'energyData': energyData, 'nutData': nutData});

        // 각 정보 초기화
        sugarChartData = [];
        energyChartData = [];
        // 일별 소계인 경우
      } else {
        String date = DateFormat('MM월 dd일').format(DateTime.parse(row['date']));
        // 혈당 정보 추가
        sugarChartData.add(SugarData(date, row['sugar_SUM']));
        // 칼로리 정보 추가
        energyChartData.add(EnergyData(date, row['energy_SUM']));
        rowCount += 1;
      }
    }

    print(reportList);
    return [reportList, entireSugarInfo];
  }

  String formatWeek(String str) {
     List splitList = str.split('/');
     return "${splitList[0]}년 ${splitList[1]}월 ${splitList[2]}주";
  }

  List getValList(list) {
    List valList = [];
    for (var row in list) {
      valList.add(row.y);
    }

    valList.sort();
    return valList;
  }
}

import 'package:ai_dang/views/Statistics/statisticsBuilder.dart';
import 'package:ai_dang/views/home.dart';
import 'package:ai_dang/views/predResult.dart';
import 'package:ai_dang/widgets/colors.dart';
import 'package:ai_dang/widgets/infoWidget.dart';
import 'package:async/async.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:multi_charts/multi_charts.dart' as multi_charts;
import 'package:syncfusion_flutter_charts/charts.dart';
import '../../utils/dbHandler.dart';
import '../../utils/session.dart';

var colorBlack = const Color(0xff535353);
var colorRed = const Color(0xffCF2525);
var colorLightGray = const Color(0xffF3F3F3);
var colorGray = const Color(0xffE0E0E0);
var colorDarkGray = const Color(0xffADADBE);
var colorOrange = const Color(0xffFBAA47);
var colorGreen = const Color(0xff8AD03C);

class statistics extends StatefulWidget {
  const statistics({Key? key}) : super(key: key);

  @override
  State<statistics> createState() => _statisticsState();
}

var dietInfo_cal = Session.instance.dietInfo['recom_cal'];
var dietInfo_hydrate = Session.instance.dietInfo['recom_hydrate'];
var dietInfo_protein = Session.instance.dietInfo['recom_protein'];
var dietInfo_fat = Session.instance.dietInfo['recom_fat'];
var dietInfo_sugar = Session.instance.dietInfo['recom_sugar'];

class ChartData {
  ChartData(this.x, this.y);
  final int x;
  final int y;
}

final List<ChartData> chartData = [
  ChartData(11, 35),
  ChartData(12, 23),
  ChartData(13, 34),
  ChartData(14, 25),
  ChartData(15, 40)
];

class EatChartData {
  EatChartData(this.x, this.y, this.y_user);
  final String x;
  final double? y;
  final double? y_user;
}

class BloodData {
  BloodData(this.x, this.y);
  final String x;
  final double? y;
}

class _statisticsState extends State<statistics> with TickerProviderStateMixin {
  List _reportList = [];
  int _reportIdx = 0;
  String _curtWeek = '';
  Map _sugarData = {'average': 0, 'max': 0, 'min': 0, 'chartData': List<SugarData>.empty()};
  Map _energyData = {'average': 0, 'max': 0, 'min': 0, 'chartData': List<EnergyData>.empty()};
  Map _entireSugarData = {'average': 0, 'max': 0, 'min': 0};
  List<double> _nutData = [0, 0, 0, 0, 0];
  List<EatChartData> _sugarCompareData = [
    EatChartData('최저', 0, 0),
    EatChartData('최고', 0, 0),
    EatChartData('평균', 0, 0),
  ];
  final AsyncMemoizer _memoizer = AsyncMemoizer();

  Future _setReportData() async {
    return _memoizer.runOnce(() async {
      List result = await statDataBuilder.getData();
      _reportList = result[0];
      _entireSugarData = result[1];
      _reportIdx = (_reportList.length - 1);
      refreshData();
      return _reportList;
    });
  }

  void previous() {
    _reportIdx -= 1;
    if(_reportIdx < 0) {
      _reportIdx = (_reportList.length - 1);
    }
    refreshData();
  }

  void forward() {
    _reportIdx += 1;
    if(_reportIdx == _reportList.length) {
      _reportIdx = 0;
    }

    refreshData();
  }

  void refreshData() {
    setState(() {
      _curtWeek = _reportList[_reportIdx]['week'];
      _sugarData = _reportList[_reportIdx]['sugarData'];
      // 섭취량 비교 그래프 갱신
      _sugarCompareData = [
        EatChartData('최저', _sugarData['min'], _entireSugarData['min']),
        EatChartData('최고', _sugarData['max'], _entireSugarData['max']),
        EatChartData('평균', _sugarData['average'], _entireSugarData['average']),
      ];
      // 칼로리 섭취량 그래프 갱신
      _energyData = _reportList[_reportIdx]['energyData'];
      // 영양소 그래프 갱신
      _nutData = _reportList[_reportIdx]['nutData'];
    });
  }

  StatisticsDataBuilder statDataBuilder = StatisticsDataBuilder();

  @override
  Widget build(BuildContext context) {

    return FutureBuilder(
      future: _setReportData(),
      builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
        if(!snapshot.hasData) {
          EasyLoading.show(status: '로딩 중..');
        } else {
          EasyLoading.dismiss();
        }
        return DefaultTabController(
          length: 2,
          child: Scaffold(
            appBar: AppBar(
              title: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // 이전 버튼 ------------------------------------------------------
                  IconButton(
                    icon: Icon(Icons.arrow_back_ios, color: colorBlack),
                    splashColor: Colors.transparent,
                    highlightColor: Colors.transparent,
                    iconSize: 21,
                    onPressed: () {
                      previous();
                    },
                  ),
                  Text(
                    '$_curtWeek 리포트',
                    textScaleFactor: 0.9,
                    style: TextStyle(
                      fontWeight: FontWeight.w700,
                      color: colorRed,
                    ),
                  ),
                  // 이후 버튼 ------------------------------------------------------
                  IconButton(
                    icon: Icon(Icons.arrow_forward_ios, color: colorBlack),
                    splashColor: Colors.transparent,
                    highlightColor: Colors.transparent,
                    iconSize: 21,
                    onPressed: () {
                      forward();
                    },
                  ),
                ],
              ),
              automaticallyImplyLeading: false,
              backgroundColor: Colors.white,
              bottom: TabBar(
                indicatorWeight: 6, // 라벨 꽉 차게
                indicatorColor: colorRed,
                labelColor: black,
                labelStyle: const TextStyle(
                  fontWeight: FontWeight.w700,
                ),
                tabs: const [
                  Tab(
                    text: '혈당 정보',
                  ),
                  Tab(text: '영양 정보'),
                ],
              ),
            ),
            body: Container(
              color: colorLightGray,
              child: TabBarView(
                children: [
                  // 혈당 정보 ------------------------------------------------------
                  Center(
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            // 혈당섭취 정보
                            sugarConsumeInfo(),
                            // 혈당섭취 비교 그래프
                            sugarCompareInfo(),
                          ],
                        ),
                      )),

                  // 영양 정보 ------------------------------------------------------
                  Container(
                    color: colorLightGray,
                    child: Center(
                        child: SingleChildScrollView(
                          child: Column(
                            children: [
                              // 칼로리 섭취량 그래프 -------------------------------------
                              calConsumeInfo(),
                              // 섭취 영양소 그래프 --------------------------------------
                              nutConsumeInfo(),
                            ],
                          ),
                        )),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  // 혈당 섭취량 정보
  Widget sugarConsumeInfo() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20.0, 25.0, 20.0, 0.0),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.white,
        ),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(30.0, 20.0, 30.0, 25.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                '혈당 섭취량 그래프',
                textScaleFactor: 1.1,
                style: TextStyle(
                  fontWeight: FontWeight.w700,
                  color: colorRed,
                ),
              ),
              const SizedBox(height: 20),
              SizedBox(
                height: 200,
                child: SfCartesianChart(
                    primaryXAxis: CategoryAxis(),
                    series: <CartesianSeries>[
                      LineSeries<SugarData, String>(
                        dataSource: _sugarData['chartData'],
                        xValueMapper: (SugarData data, _) => data.x,
                        yValueMapper: (SugarData data, _) => data.y,
                        color: colorRed,
                        markerSettings:
                            MarkerSettings(isVisible: true, color: colorRed),
                      ),
                    ]),
              ),
              infoWidget('평균 섭취량', '${_sugarData['average']}g', labelColor: colorRed),
              infoWidget('최고 섭취량', '${_sugarData['max']}g'),
              infoWidget('최저 섭취량', '${_sugarData['min']}g')
            ],
          ),
        ),
      ),
    );
  }

  // 혈당섭취 비교 그래프
  Widget sugarCompareInfo() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20.0, 25.0, 20.0, 20.0),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.white,
        ),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(30.0, 20.0, 30.0, 25.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                '섭취량 비교 그래프',
                textScaleFactor: 1.1,
                style: TextStyle(
                  fontWeight: FontWeight.w700,
                  color: colorRed,
                ),
              ),
              const SizedBox(height: 10),
              SizedBox(
                height: 250,
                child: SfCartesianChart(
                    enableAxisAnimation: true,
                    primaryXAxis: CategoryAxis(),
                    legend: Legend(isVisible: true, position: LegendPosition.bottom),
                    series: <CartesianSeries>[
                      BarSeries<EatChartData, String>(
                        name: '이번 섭취량',
                        dataSource: _sugarCompareData,
                        xValueMapper: (EatChartData data, _) => data.x,
                        yValueMapper: (EatChartData data, _) => data.y,
                        color: colorRed,
                        width: 0.5,
                      ),
                      BarSeries<EatChartData, String>(
                        name: '전체 섭취량',
                        dataSource: _sugarCompareData,
                        xValueMapper: (EatChartData data, _) => data.x,
                        yValueMapper: (EatChartData data, _) => data.y_user,
                        color: colorBlack,
                        width: 0.5,
                      )
                    ]),
              ),
              RichText(
                textScaleFactor: 1.1,
                text: TextSpan(
                  text: '전체 섭취량 보다 ',
                  style: TextStyle(color: black, fontWeight: FontWeight.w400),
                  children: <TextSpan>[
                    TextSpan(
                        text: '혈당을 18% 더 섭취',
                        style: TextStyle(
                            color: colorRed, fontWeight: FontWeight.w600)),
                    const TextSpan(text: '하고 있어요.')
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  // 칼로리 섭취량 그래프
  Widget calConsumeInfo() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20.0, 25.0, 20.0, 0.0),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.white,
        ),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(25.0, 20.0, 25.0, 25.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                '칼로리 섭취량 그래프',
                textScaleFactor: 1.1,
                style: TextStyle(
                  fontWeight: FontWeight.w700,
                  color: colorRed,
                ),
              ),
              const SizedBox(height: 10),
              SizedBox(
                height: 200,
                child: SfCartesianChart(
                    enableSideBySideSeriesPlacement: false,
                    primaryXAxis: CategoryAxis(),
                    series: <ChartSeries<EnergyData, String>>[
                      // Renders column chart
                      ColumnSeries<EnergyData, String>(
                        dataSource: _energyData['chartData'],
                        xValueMapper: (EnergyData data, _) => data.x,
                        yValueMapper: (EnergyData data, _) => data.y,
                        width: 0.3,
                        color: colorRed,
                      )
                    ]),
              ),
              // 열량 정보  ------------------------------------
              infoWidget('평균 섭취량', '${_energyData['average']}kcal', labelColor: colorRed),
              infoWidget('최고 섭취량', '${_energyData['max']}kcal'),
              infoWidget('최저 섭취량', '${_energyData['min']}kcal'),
            ],
          ),
        ),
      ),
    );
  }

  // 섭취 영양소 그래프
  Widget nutConsumeInfo() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20.0, 25.0, 20.0, 20.0),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.white,
        ),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(25.0, 20.0, 25.0, 25.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                '섭취 영양소 그래프',
                textScaleFactor: 1.1,
                style: TextStyle(
                  fontWeight: FontWeight.w700,
                  color: colorRed,
                ),
              ),
              // 섭취 영양소 차트 ------------------------------
              SizedBox(
                height: 250,
                //Radar Chart
                child: multi_charts.RadarChart(
                  values: _nutData,
                  labels: const [
                    "탄수화물",
                    "단백질",
                    "지방",
                    "나트륨",
                    "콜레스트롤",
                  ],
                  maxValue: 15,
                  fillColor: colorRed,
                  strokeColor: colorDarkGray,
                  chartRadiusFactor: 0.8,
                ),
              ),
              Center(
                child: RichText(
                    textScaleFactor: 1.1,
                    text: TextSpan(
                      text: '나트륨을 ',
                      style:
                          TextStyle(color: black, fontWeight: FontWeight.w400),
                      children: <TextSpan>[
                        TextSpan(
                            text: '너무 과도하게 섭취',
                            style: TextStyle(
                                color: colorRed, fontWeight: FontWeight.w600)),
                        const TextSpan(text: '하고 있어요.')
                      ],
                    )),
              ),
              const SizedBox(height: 20),
              infoWidget('탄수화물 섭취량', '${(_nutData[0] * 10).toInt()}%'),
              infoWidget('단백질 섭취량', '${(_nutData[1] * 10).toInt()}%'),
              infoWidget('지방 섭취량', '${(_nutData[2] * 10).toInt()}%'),
              infoWidget('나트륨 섭취량', '${(_nutData[3] * 10).toInt()}%', labelColor: colorRed),
              infoWidget('콜레스트롤 섭취량', '${(_nutData[4] * 10).toInt()}%'),
            ],
          ),
        ),
      ),
    );
  }
}

import 'package:ai_dang/views/home.dart';
import 'package:ai_dang/views/predResult.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

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


// final List<ChartData> chartData = [
//   //환자평균
//   ChartData(11, 35, 20),
//   ChartData(12, 23, 15),
//   ChartData(13, 34, 30),
// ];






//
// class ChartUserData {
//
// }

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

  final List<BloodData> bloodData = [
    BloodData('5월 26일', 120),
    BloodData('5월 27일', 110),
    BloodData('5월 28일', 108),
    BloodData('5월 29일', 125),
    BloodData('5월 30일', 121),
    BloodData('5월 31일', 105),
    BloodData('6월 01일', 80),
  ];

  final List<EatChartData> eatChartData = [
    EatChartData('최저', 118, 120),
    EatChartData('최고', 123, 115),
    EatChartData('평균', 107, 109),
  ];

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2 ,
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            '2022년 4월 2주 리포트',
            style: TextStyle(
              fontWeight: FontWeight.w700,
              color: colorRed,
              fontSize: (MediaQuery
                  .of(context)
                  .size
                  .width) * 0.04,
            ),
          ),
          centerTitle: true,
          automaticallyImplyLeading: false,
          backgroundColor: Colors.white,
          bottom: TabBar(
            // indicatorSize: TabBarIndicatorSize.label, // 라벨 사이즈에 맞게
            indicatorWeight: 6, // 라벨 꽉 차게
            indicatorColor: colorRed,
            labelColor: colorRed,
            labelStyle: TextStyle(
              fontWeight: FontWeight.w700,
              color: colorRed,
              fontSize: (MediaQuery
                  .of(context)
                  .size
                  .width) * 0.04,
            ),
            tabs: [
              Tab(text: '혈당 정보',),
              Tab(text: '영양 정보',),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            Center(child:
            SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(
                    width: (MediaQuery
                        .of(context)
                        .size
                        .width),
                    height: (MediaQuery
                        .of(context)
                        .size
                        .height) * 0.03,
                    child: Container(
                      color: colorLightGray,
                    ),

                  ),
                  Container(
                    width: (MediaQuery
                        .of(context)
                        .size
                        .width),
                    color: colorLightGray,
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(
                          20.0, 10.0, 20.0, 10.0),
                      child: Column(
                        children: [
                          Container(
                            width: (MediaQuery
                                .of(context)
                                .size
                                .width) * 0.9,
                            height: (MediaQuery
                                .of(context)
                                .size
                                .height) * 0.65,
                            color: Colors.white,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                  width: (MediaQuery
                                      .of(context)
                                      .size
                                      .width),
                                  height: (MediaQuery
                                      .of(context)
                                      .size
                                      .height) * 0.02,
                                ),
                                Container(
                                  child: Row(
                                    children: [
                                      SizedBox(
                                        width: (MediaQuery
                                            .of(context)
                                            .size
                                            .width) * 0.05,
                                      ),
                                      Text(
                                        '혈당 섭취량 그래프',
                                        style: TextStyle(
                                          fontWeight: FontWeight.w700,
                                          color: colorRed,
                                          fontSize: (MediaQuery
                                              .of(context)
                                              .size
                                              .width) * 0.04,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  width: (MediaQuery
                                      .of(context)
                                      .size
                                      .width),
                                  height: (MediaQuery
                                      .of(context)
                                      .size
                                      .height) * 0.02,
                                ),
                                Padding(
                                  padding: const EdgeInsets.fromLTRB(
                                      20.0, 10.0, 20.0, 10.0),
                                  child: Column(
                                    children: <Widget>[
                                      SfCartesianChart(
                                          primaryXAxis: CategoryAxis(),
                                          series: <CartesianSeries>[
                                            LineSeries<BloodData, String>(
                                              dataSource: bloodData,
                                              xValueMapper: (BloodData data, _) => data.x,
                                              yValueMapper: (BloodData data, _) => data.y,
                                              color: colorRed,
                                              markerSettings: MarkerSettings(
                                                  isVisible: true,
                                                  color: colorRed
                                              ),
                                            ),
                                          ]
                                      ),
                                      // 열량 정보  ------------------------------------
                                      Container(
                                        padding:
                                        const EdgeInsets.fromLTRB(
                                            15.0, 20.0, 15.0, 10.0),
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment
                                              .spaceBetween,
                                          children: [
                                            Text('평균 섭취량',
                                                textScaleFactor: 1.1,
                                                style: TextStyle(
                                                    color: black)),
                                            Text('1,702g',
                                                textScaleFactor: 1.1,
                                                style: TextStyle(
                                                    color: black,
                                                    fontWeight: FontWeight
                                                        .w700))
                                          ],
                                        ),
                                        decoration: BoxDecoration(
                                          border: Border(
                                            bottom: BorderSide(
                                                width: 1.5, color: gray),
                                          ),
                                        ),
                                      ),
                                      // 탄수화물 정보 ----------------------------------
                                      Container(
                                        padding:
                                        const EdgeInsets.fromLTRB(
                                            15.0, 20.0, 15.0, 10.0),
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment
                                              .spaceBetween,
                                          children: [
                                            Text('최고 섭취량',
                                                textScaleFactor: 1.1,
                                                style: TextStyle(
                                                    color: black)),
                                            Text('1,890g',
                                                textScaleFactor: 1.1,
                                                style: TextStyle(
                                                    color: black,
                                                    fontWeight: FontWeight
                                                        .w700))
                                          ],
                                        ),
                                        decoration: BoxDecoration(
                                          border: Border(
                                            bottom: BorderSide(
                                                width: 1.5, color: gray),
                                          ),
                                        ),
                                      ),
                                      // 단백질 정보 -----------------------------------
                                      Container(
                                        padding:
                                        const EdgeInsets.fromLTRB(
                                            15.0, 20.0, 15.0, 10.0),
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment
                                              .spaceBetween,
                                          children: [
                                            Text('최저 섭취량',
                                                textScaleFactor: 1.1,
                                                style: TextStyle(
                                                    color: black)),
                                            Text('1,414g',
                                                textScaleFactor: 1.1,
                                                style: TextStyle(
                                                    color: black,
                                                    fontWeight: FontWeight
                                                        .w700))
                                          ],
                                        ),
                                        decoration: BoxDecoration(
                                          border: Border(
                                            bottom: BorderSide(
                                                width: 1.5, color: gray),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  // SizedBox(
                  //   width: (MediaQuery.of(context).size.width),
                  //   height: (MediaQuery.of(context).size.height) * 0.03,
                  // ),
                  Container(
                    width: (MediaQuery
                        .of(context)
                        .size
                        .width),
                    color: colorLightGray,
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(
                          20.0, 10.0, 20.0, 10.0),
                      child: Column(
                        children: [
                          Container(
                            width: (MediaQuery
                                .of(context)
                                .size
                                .width) * 0.9,
                            // height: (MediaQuery.of(context).size.height) * 0.75,
                            color: Colors.white,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                  width: (MediaQuery
                                      .of(context)
                                      .size
                                      .width),
                                  height: (MediaQuery
                                      .of(context)
                                      .size
                                      .height) * 0.02,
                                ),
                                Container(
                                  child: Row(
                                    children: [
                                      SizedBox(
                                        width: (MediaQuery
                                            .of(context)
                                            .size
                                            .width) * 0.05,
                                      ),
                                      Text(
                                        '섭취량 비교 그래프',
                                        style: TextStyle(
                                          fontWeight: FontWeight.w700,
                                          color: colorRed,
                                          fontSize: (MediaQuery
                                              .of(context)
                                              .size
                                              .width) * 0.04,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  width: (MediaQuery
                                      .of(context)
                                      .size
                                      .width),
                                  height: (MediaQuery
                                      .of(context)
                                      .size
                                      .height) * 0.02,
                                ),
                                Padding(
                                  padding: const EdgeInsets.fromLTRB(
                                      20.0, 10.0, 20.0, 10.0),
                                  child: Column(
                                    children: <Widget>[
                                      SfCartesianChart(
                                          primaryXAxis: CategoryAxis(),
                                          series: <CartesianSeries>[
                                            BarSeries<EatChartData, String>(
                                                dataSource: eatChartData,
                                                xValueMapper: (EatChartData data, _) => data.x,
                                                yValueMapper: (EatChartData data, _) => data.y,
                                                color: colorRed
                                            ),
                                            BarSeries<EatChartData, String>(
                                                dataSource: eatChartData,
                                                xValueMapper: (EatChartData data, _) => data.x,
                                                yValueMapper: (EatChartData data, _) => data.y_user,
                                                color: colorBlack
                                            )
                                          ]
                                      ),
                                      Container(
                                        padding:
                                        const EdgeInsets.fromLTRB(
                                            15.0, 20.0, 15.0, 10.0),
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.stretch,
                                          mainAxisSize: MainAxisSize.max,
                                          children: [
                                            Text('당뇨병 환자 평균보다 혈당을 18% 더 섭취하고 있어요.',
                                                textScaleFactor: 1.2,
                                                style: TextStyle(
                                                    color: black)),
                                          ],
                                        ),
                                      ),

                                    ],
                                  ),
                                ),
                              ],
                            ),

                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            )

            ),









            // 영양 정보
            Center(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      SizedBox(
                        width: (MediaQuery
                            .of(context)
                            .size
                            .width),
                        height: (MediaQuery
                            .of(context)
                            .size
                            .height) * 0.03,
                        child: Container(
                          color: colorLightGray,
                        ),

                      ),
                      Container(
                        width: (MediaQuery
                            .of(context)
                            .size
                            .width),
                        color: colorLightGray,
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(
                              20.0, 10.0, 20.0, 10.0),
                          child: Column(
                            children: [
                              Container(
                                width: (MediaQuery
                                    .of(context)
                                    .size
                                    .width) * 0.9,
                                height: (MediaQuery
                                    .of(context)
                                    .size
                                    .height) * 0.65,
                                color: Colors.white,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SizedBox(
                                      width: (MediaQuery
                                          .of(context)
                                          .size
                                          .width),
                                      height: (MediaQuery
                                          .of(context)
                                          .size
                                          .height) * 0.02,
                                    ),
                                    Container(
                                      child: Row(
                                        children: [
                                          SizedBox(
                                            width: (MediaQuery
                                                .of(context)
                                                .size
                                                .width) * 0.05,
                                          ),
                                          Text(
                                            '칼로리 섭취량 그래프',
                                            style: TextStyle(
                                              fontWeight: FontWeight.w700,
                                              color: colorRed,
                                              fontSize: (MediaQuery
                                                  .of(context)
                                                  .size
                                                  .width) * 0.04,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    SizedBox(
                                      width: (MediaQuery
                                          .of(context)
                                          .size
                                          .width),
                                      height: (MediaQuery
                                          .of(context)
                                          .size
                                          .height) * 0.02,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.fromLTRB(
                                          20.0, 10.0, 20.0, 10.0),
                                      child: Column(
                                        children: <Widget>[
                                          SfCartesianChart(
                                              enableSideBySideSeriesPlacement: false,
                                              series: <
                                                  ChartSeries<ChartData, int>>[
                                                // Renders column chart
                                                ColumnSeries<ChartData, int>(
                                                  dataSource: chartData,
                                                  xValueMapper: (ChartData data,
                                                      _) => data.x,
                                                  yValueMapper: (ChartData data,
                                                      _) => data.y,
                                                  width: 0.5,
                                                  color: colorRed,
                                                )
                                              ]
                                          ),
                                          // 열량 정보  ------------------------------------
                                          Container(
                                            padding:
                                            const EdgeInsets.fromLTRB(
                                                15.0, 20.0, 15.0, 10.0),
                                            child: Row(
                                              mainAxisAlignment: MainAxisAlignment
                                                  .spaceBetween,
                                              children: [
                                                Text('평균 섭취량',
                                                    textScaleFactor: 1.1,
                                                    style: TextStyle(
                                                        color: black)),
                                                Text('1,702g',
                                                    textScaleFactor: 1.1,
                                                    style: TextStyle(
                                                        color: black,
                                                        fontWeight: FontWeight
                                                            .w700))
                                              ],
                                            ),
                                            decoration: BoxDecoration(
                                              border: Border(
                                                bottom: BorderSide(
                                                    width: 1.5, color: gray),
                                              ),
                                            ),
                                          ),
                                          // 탄수화물 정보 ----------------------------------
                                          Container(
                                            padding:
                                            const EdgeInsets.fromLTRB(
                                                15.0, 20.0, 15.0, 10.0),
                                            child: Row(
                                              mainAxisAlignment: MainAxisAlignment
                                                  .spaceBetween,
                                              children: [
                                                Text('최고 섭취량',
                                                    textScaleFactor: 1.1,
                                                    style: TextStyle(
                                                        color: black)),
                                                Text('1,890g',
                                                    textScaleFactor: 1.1,
                                                    style: TextStyle(
                                                        color: black,
                                                        fontWeight: FontWeight
                                                            .w700))
                                              ],
                                            ),
                                            decoration: BoxDecoration(
                                              border: Border(
                                                bottom: BorderSide(
                                                    width: 1.5, color: gray),
                                              ),
                                            ),
                                          ),
                                          // 단백질 정보 -----------------------------------
                                          Container(
                                            padding:
                                            const EdgeInsets.fromLTRB(
                                                15.0, 20.0, 15.0, 10.0),
                                            child: Row(
                                              mainAxisAlignment: MainAxisAlignment
                                                  .spaceBetween,
                                              children: [
                                                Text('최저 섭취량',
                                                    textScaleFactor: 1.1,
                                                    style: TextStyle(
                                                        color: black)),
                                                Text('1,414g',
                                                    textScaleFactor: 1.1,
                                                    style: TextStyle(
                                                        color: black,
                                                        fontWeight: FontWeight
                                                            .w700))
                                              ],
                                            ),
                                            decoration: BoxDecoration(
                                              border: Border(
                                                bottom: BorderSide(
                                                    width: 1.5, color: gray),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      // SizedBox(
                      //   width: (MediaQuery.of(context).size.width),
                      //   height: (MediaQuery.of(context).size.height) * 0.03,
                      // ),
                      Container(
                        width: (MediaQuery
                            .of(context)
                            .size
                            .width),
                        color: colorLightGray,
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(
                              20.0, 10.0, 20.0, 10.0),
                          child: Column(
                            children: [
                              Container(
                                width: (MediaQuery
                                    .of(context)
                                    .size
                                    .width) * 0.9,
                                // height: (MediaQuery.of(context).size.height) * 0.75,
                                color: Colors.white,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SizedBox(
                                      width: (MediaQuery
                                          .of(context)
                                          .size
                                          .width),
                                      height: (MediaQuery
                                          .of(context)
                                          .size
                                          .height) * 0.02,
                                    ),
                                    Container(
                                      child: Row(
                                        children: [
                                          SizedBox(
                                            width: (MediaQuery
                                                .of(context)
                                                .size
                                                .width) * 0.05,
                                          ),
                                          Text(
                                            '섭취 영양소 그래프',
                                            style: TextStyle(
                                              fontWeight: FontWeight.w700,
                                              color: colorRed,
                                              fontSize: (MediaQuery
                                                  .of(context)
                                                  .size
                                                  .width) * 0.04,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    SizedBox(
                                      width: (MediaQuery
                                          .of(context)
                                          .size
                                          .width),
                                      height: (MediaQuery
                                          .of(context)
                                          .size
                                          .height) * 0.02,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.fromLTRB(
                                          20.0, 10.0, 20.0, 10.0),
                                      child: Column(
                                        children: <Widget>[
                                          SfCartesianChart(
                                              enableSideBySideSeriesPlacement: false,
                                              series: <
                                                  ChartSeries<ChartData, int>>[
                                                // Renders column chart
                                                ColumnSeries<ChartData, int>(
                                                  dataSource: chartData,
                                                  xValueMapper: (ChartData data,
                                                      _) => data.x,
                                                  yValueMapper: (ChartData data,
                                                      _) => data.y,
                                                  width: 0.5,
                                                  color: colorRed,
                                                )
                                              ]
                                          ),
                                          Container(
                                            padding:
                                            const EdgeInsets.fromLTRB(
                                                15.0, 20.0, 15.0, 10.0),
                                            child: Row(
                                              mainAxisAlignment: MainAxisAlignment
                                                  .spaceBetween,
                                              children: [
                                                Text('나트륨을',
                                                    textScaleFactor: 1.2,
                                                    style: TextStyle(
                                                        color: black)),
                                                Text('너무 과도하게 섭취',
                                                    textScaleFactor: 1.2,
                                                    style: TextStyle(
                                                        color: colorRed)),
                                                Text('하고 있어요.',
                                                    textScaleFactor: 1.2,
                                                    style: TextStyle(
                                                        color: black)),
                                              ],
                                            ),
                                          ),
                                          SizedBox(
                                            width: (MediaQuery
                                                .of(context)
                                                .size
                                                .width),
                                            height: (MediaQuery
                                                .of(context)
                                                .size
                                                .height) * 0.01,
                                          ),
                                          Container(
                                            padding:
                                            const EdgeInsets.fromLTRB(
                                                15.0, 20.0, 15.0, 10.0),
                                            child: Row(
                                              mainAxisAlignment: MainAxisAlignment
                                                  .spaceBetween,
                                              children: [
                                                Text('탄수화물 섭취량',
                                                    textScaleFactor: 1.1,
                                                    style: TextStyle(
                                                        color: black)),
                                                Text('125%',
                                                    textScaleFactor: 1.1,
                                                    style: TextStyle(
                                                        color: black,
                                                        fontWeight: FontWeight
                                                            .w700))
                                              ],
                                            ),
                                            decoration: BoxDecoration(
                                              border: Border(
                                                bottom: BorderSide(
                                                    width: 1.5, color: gray),
                                              ),
                                            ),
                                          ),
                                          Container(
                                            padding:
                                            const EdgeInsets.fromLTRB(
                                                15.0, 20.0, 15.0, 10.0),
                                            child: Row(
                                              mainAxisAlignment: MainAxisAlignment
                                                  .spaceBetween,
                                              children: [
                                                Text('단백질 섭취량',
                                                    textScaleFactor: 1.1,
                                                    style: TextStyle(
                                                        color: black)),
                                                Text('103%',
                                                    textScaleFactor: 1.1,
                                                    style: TextStyle(
                                                        color: black,
                                                        fontWeight: FontWeight
                                                            .w700))
                                              ],
                                            ),
                                            decoration: BoxDecoration(
                                              border: Border(
                                                bottom: BorderSide(
                                                    width: 1.5, color: gray),
                                              ),
                                            ),
                                          ),
                                          Container(
                                            padding:
                                            const EdgeInsets.fromLTRB(
                                                15.0, 20.0, 15.0, 10.0),
                                            child: Row(
                                              mainAxisAlignment: MainAxisAlignment
                                                  .spaceBetween,
                                              children: [
                                                Text('지방 섭취량',
                                                    textScaleFactor: 1.1,
                                                    style: TextStyle(
                                                        color: black)),
                                                Text('89%',
                                                    textScaleFactor: 1.1,
                                                    style: TextStyle(
                                                        color: black,
                                                        fontWeight: FontWeight
                                                            .w700))
                                              ],
                                            ),
                                            decoration: BoxDecoration(
                                              border: Border(
                                                bottom: BorderSide(
                                                    width: 1.5, color: gray),
                                              ),
                                            ),
                                          ),
                                          Container(
                                            padding:
                                            const EdgeInsets.fromLTRB(
                                                15.0, 20.0, 15.0, 10.0),
                                            child: Row(
                                              mainAxisAlignment: MainAxisAlignment
                                                  .spaceBetween,
                                              children: [
                                                Text('나트륨 섭취량',
                                                    textScaleFactor: 1.1,
                                                    style: TextStyle(
                                                        color: black)),
                                                Text('135%',
                                                    textScaleFactor: 1.1,
                                                    style: TextStyle(
                                                        color: black,
                                                        fontWeight: FontWeight
                                                            .w700))
                                              ],
                                            ),
                                            decoration: BoxDecoration(
                                              border: Border(
                                                bottom: BorderSide(
                                                    width: 1.5, color: gray),
                                              ),
                                            ),
                                          ),
                                          Container(
                                            padding:
                                            const EdgeInsets.fromLTRB(
                                                15.0, 20.0, 15.0, 10.0),
                                            child: Row(
                                              mainAxisAlignment: MainAxisAlignment
                                                  .spaceBetween,
                                              children: [
                                                Text('콜레스테롤 섭취량',
                                                    textScaleFactor: 1.1,
                                                    style: TextStyle(
                                                        color: black)),
                                                Text('111%',
                                                    textScaleFactor: 1.1,
                                                    style: TextStyle(
                                                        color: black,
                                                        fontWeight: FontWeight
                                                            .w700))
                                              ],
                                            ),
                                            decoration: BoxDecoration(
                                              border: Border(
                                                bottom: BorderSide(
                                                    width: 1.5, color: gray),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                )),
          ],
        ),
      ),
    );
  }
}
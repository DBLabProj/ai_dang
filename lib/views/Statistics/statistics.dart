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
  final double y;
}

class _statisticsState extends State<statistics> {

  @override
  Widget build(BuildContext context) {


      //Column Chart
      final List<ChartData> chartData = [
        ChartData(11, 35),
        ChartData(12, 23),
        ChartData(13, 34),
        ChartData(14, 25),
        ChartData(15, 40)
      ];
      return Scaffold(
          body: Center(
              child: Column(
                children: [
                  Container(
                    width: (MediaQuery.of(context).size.width),
                    height: (MediaQuery.of(context).size.height) * 0.214,
                    color: Colors.black,
                    child: Column(
                      children: [
                          SizedBox(
                            height: (MediaQuery.of(context).size.height) * 0.08,
                          ),
                          Text(
                            '날짜 section',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w700,
                              fontSize: (MediaQuery.of(context).size.width)*0.04
                            ),
                          ),
                          SizedBox(
                            height: (MediaQuery.of(context).size.height) * 0.04,
                          ),
                          Container(
                            color: Colors.white,
                            child: Row(
                              children: [
                                SizedBox(
                                  width: (MediaQuery.of(context).size.width)*0.08,
                                ),
                                TextButton(
                                    onPressed: () {},
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Container(
                                          child: Row(
                                            children: [
                                              Text(
                                                '혈당 정보',
                                                style: TextStyle(
                                                    fontWeight: FontWeight.w600,
                                                    fontSize: (MediaQuery.of(context).size.width)*0.035,
                                                    color: Colors.black
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    )
                                ),
                                SizedBox(
                                  width: (MediaQuery.of(context).size.width)*0.08,
                                ),
                                TextButton(
                                    onPressed: () {},
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Container(
                                          child: Row(
                                            children: [
                                              Text(
                                                '영양 정보',
                                                style: TextStyle(
                                                    fontWeight: FontWeight.w600,
                                                    fontSize: (MediaQuery.of(context).size.width)*0.035,
                                                    color: Colors.black
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    )
                                ),
                              ],
                            ),
                          ),
                      ],
                    ),

                  ),
                  Container(
                      width: (MediaQuery.of(context).size.width) * 0.9,
                      height: (MediaQuery.of(context).size.height) * 0.5,
                      color: Colors.white,
                      child: SfCartesianChart(
                          enableSideBySideSeriesPlacement: false,
                          series: <ChartSeries<ChartData, int>>[
                            // Renders column chart
                            ColumnSeries<ChartData, int>(
                              dataSource: chartData,
                              xValueMapper: (ChartData data, _) => data.x,
                              yValueMapper: (ChartData data, _) => data.y,
                              width: 0.5,
                              color: colorRed,
                            )
                          ]
                      )
                  )
                ],
              )
          )
      );
    }


}


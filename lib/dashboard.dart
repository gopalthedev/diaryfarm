import 'package:diaryfarm/models/dataModel.dart';
import 'package:diaryfarm/shelterdata.dart';
import 'package:diaryfarm/utils/systemValues.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:syncfusion_flutter_charts/sparkcharts.dart';

class DashBoard extends StatefulWidget {
  const DashBoard({super.key});

  @override
  State<DashBoard> createState() => _DashBoardState();
}

class _DashBoardState extends State<DashBoard> {


  String formatDate(double date){
    String dateString = date.toString();

    String day = "${dateString[0]}${dateString[1]}/";
    String month = "${dateString[2]}${dateString[3]}/";
    String year = dateString[4] + dateString[5] + dateString[6] + dateString[7];

    return day + month + year;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getShelterData();
  }

  @override
  Widget build(BuildContext context) {
    print(shelterData.dailyDataList);
    return Scaffold(
      appBar: customAppBar(title: "DashBoard"),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(children: [
            //Initialize the chart widget
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                color: Colors.green.shade200
              ),
              child: SfCartesianChart(
                  primaryXAxis: const CategoryAxis(),
                  // Chart title
                  title: const ChartTitle(text: 'Daily Production',textStyle: TextStyle(color: Colors.blue)),
                  // Enable legend
                  legend: const Legend(isVisible: true),
                  // Enable tooltip
                  tooltipBehavior: TooltipBehavior(enable: true),
                  // backgroundColor: Colors.green.shade200,
                  series: <CartesianSeries<DailyData, String>>[
                    LineSeries<DailyData, String>(
                        dataSource: shelterData.dailyDataList,
                        xValueMapper: (DailyData temp, _) => formatDate(temp.date),
                        yValueMapper: (DailyData temp, _) => temp.milk,
                        name: 'Milk',
                        // Enable data label
                        dataLabelSettings: const DataLabelSettings(isVisible: true))
                  ]),
            ),
            const SizedBox(height: 20,),
            Expanded(
              child: Container(
                clipBehavior: Clip.antiAlias,
                decoration: BoxDecoration(
                  color: Colors.blue.shade200,
                  borderRadius: BorderRadius.circular(24)
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: SfSparkLineChart.custom(
                    //Enable the trackball
                    color: Colors.black,
                    trackball: const SparkChartTrackball(
                        activationMode: SparkChartActivationMode.tap),
                    //Enable marker
                    marker: const SparkChartMarker(
                        displayMode: SparkChartMarkerDisplayMode.all),
                    //Enable data label
                    labelDisplayMode: SparkChartLabelDisplayMode.all,
                    xValueMapper: (int index) => shelterData.dailyDataList[index].food,
                    yValueMapper: (int index) => shelterData.dailyDataList[index].milk,
                    dataCount: shelterData.dailyDataList.length,
                  ),
                ),
              ),
            )
          ]),
        )
    );
  }
}

class _SalesData {
  _SalesData(this.year, this.sales);

  final String year;
  final double sales;
}

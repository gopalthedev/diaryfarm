import 'dart:async';

import 'package:diaryfarm/models/cardModel.dart';
import 'package:diaryfarm/shelterdata.dart';
import 'package:diaryfarm/utils/systemValues.dart';
import 'package:flutter/material.dart';

class NotificationPage extends StatefulWidget {
  const NotificationPage({super.key});

  @override
  State<NotificationPage> createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {

  Timer? timer;
  void timerFun(Duration duration){
      timer = Timer.periodic(duration, (timer) {
       setState(() {
         getShelterData();
       });
      });
  }

  @override
  void initState() {
    // TODO: implement initState
    timerFun(const Duration(milliseconds: 1000));
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(title: "Notification"),
      body: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              CardModel(
                  dataLine: "Humidity", dataValue: shelterData.humidity),
              CardModel(
                  dataLine: "Gas (ppm)", dataValue: double.parse(int. parse("${shelterData.gas}", radix: 2). toRadixString(10))),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              CardModel(dataLine: "Temperature (C)", dataValue: shelterData.temp),
              CardModel(
                  dataLine: "Water Level (Cm)", dataValue: shelterData.waterLevel),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              clipBehavior: Clip.antiAlias,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16)
              ),
              child: MaterialButton(
                color: Colors.red,
                  splashColor: Colors.green,
                  elevation: 2,
                  mouseCursor: MaterialStateMouseCursor.clickable,
                  hoverColor: Colors.green.shade300,
                  hoverElevation: 10,
                  onPressed: getShelterData,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                    child: Text(
                      "Reload Data",
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ),
                  )),
            ),
          )
        ],
      ),
    );
  }
}

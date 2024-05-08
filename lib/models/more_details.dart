import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:diaryfarm/models/linear_bar.dart';
import 'package:diaryfarm/utils/systemValues.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/sparkcharts.dart';

class MoreDetails extends StatefulWidget {
  const MoreDetails({super.key, required this.docId});

  final String docId;

  @override
  State<MoreDetails> createState() => _MoreDetailsState();
}

class _MoreDetailsState extends State<MoreDetails> {
  Map<String, dynamic> map = {};

  List<Map<String, dynamic>> list = [];

  String lastDate = "3/5/2024";

  final dateController = TextEditingController();
  final milkController = TextEditingController();

  Future getCowDetails() async {
    try {
      await FirebaseFirestore.instance
          .collection("Cows")
          .doc(widget.docId)
          .get()
          .then((value) {
        List<Map<String, dynamic>> temp = [];
        for (Map<String, dynamic> i in value.get("milk")) {
          temp.add(i);
        }
        setState(() {
          map = value.data()!;
          list = temp;
        });
        print(map);
        init_data();
      });
    } catch (e) {
      showSnack(e.toString(), context);
    }
  }

  void addTodayMilk() async {
    try {
      String currentDate =
          "${DateTime.now().day}/${DateTime.now().month}/${DateTime.now().year}";
      if(dateController.value.text != currentDate){
        showSnack("You have entered wrong date", context);
      }
      print("method is called");
      for (Map<String, dynamic> i in list) {
        if (i['date'] == currentDate) {
          print(i);
          double temp = i['milkCount'].toDouble();
          print("temp value before $temp");
          print(milkController.value.text);
          temp += double.parse(milkController.value.text);
          print(temp);
          i['milkCount'] = temp;
          print("after the updation $i");
        }
      }
      await FirebaseFirestore.instance
          .collection("Cows")
          .doc(widget.docId)
          .update({"milk": list}).then((value) {
        showSnack("added successfully", context);
        milkController.clear();
        dateController.clear();
        Navigator.pop(context);
      });
    } catch (e) {
      showSnack("this is the error due to try $e", context);
    }
  }

  void init_data() async {
    print("init method is called");
    String currentDate =
        "${DateTime.now().day}/${DateTime.now().month}/${DateTime.now().year}";
    bool contains = false;
    print(list);
    for (Map<String, dynamic> i in list) {
      if (i['date'] == currentDate){
        print("yes it contains");
        setState(() {
          contains = true;
        });
      }
    }

    if (!contains) {
      try {
        list.add({'date': currentDate, 'milkCount': 0});
        await FirebaseFirestore.instance
            .collection("Cows")
            .doc(widget.docId)
            .update({"milk": list}).then((value) {
          showSnack("added successfully", context);
        });
      } catch (e) {
        print(e);
      }
    }
  }

  // bool checkFields(){
  //   if(dateController.value.text.isEmpty || milkController.value.text.isEmpty){
  //     showSnack("Enter all the field correctly", context);
  //     return false;
  //   }
  //
  //   return true;
  // }

  @override
  void initState(){
    // TODO: implement initState
    super.initState();
   getCowDetails();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(title: map['name'].toString()),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            LinearBar(
              placeholder: "ID",
              value: widget.docId.toString(),
            ),
            LinearBar(
              placeholder: "Breed",
              value: map['breed'].toString(),
            ),
            LinearBar(
              placeholder: "Age",
              value: map['age'].toString(),
            ),
            LinearBar(
              placeholder: "Status",
              value: map['status'].toString(),
            ),
            Container(
              clipBehavior: Clip.antiAlias,
              height: 40,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: Colors.amber.shade200),
              child: MaterialButton(
                onPressed: () {
                  showModalBottomSheet(
                      context: context,
                      builder: (context) {
                        return Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            children: [
                              Center(
                                child: Text(
                                  "Add Today's Milk",
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              TextField(
                                decoration: InputDecoration(
                                    label: Text("Enter the date"),
                                    hintText: "10/10/2024",
                                    border: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(12))),
                                controller: dateController,
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              TextField(
                                decoration: InputDecoration(
                                    label: Text("Enter milk"),
                                    border: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(12))),
                                controller: milkController,
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              MaterialButton(
                                onPressed: addTodayMilk,
                                child: Text("add"),
                              )
                            ],
                          ),
                        );
                      });
                },
                child: Text("Add Today's milk"),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Expanded(
              child: Container(
                clipBehavior: Clip.antiAlias,
                decoration: BoxDecoration(
                    color: Colors.blue.shade200,
                    borderRadius: BorderRadius.circular(24)),
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
                    xValueMapper: (int index) => list[index]['date'],
                    yValueMapper: (int index) => list[index]['milkCount'],
                    dataCount: list.length,
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

import 'dart:developer';
import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:diaryfarm/models/more_details.dart';
import 'package:diaryfarm/shelterdata.dart';
import 'package:flutter/material.dart';

class BoxModel extends StatefulWidget {
  const BoxModel(
      {super.key,
      required this.name,
      required this.status,
      required this.docId});

  final String name;
  final String status;
  final String docId;

  @override
  State<BoxModel> createState() => _BoxModelState();
}

class _BoxModelState extends State<BoxModel> {
  bool isExpanded = false;

  Widget setStatus(String status) {
    if (status == "normal") {
      return Icon(
        Icons.currency_yen_sharp,
        color: Colors.yellow.shade900,
      );
    } else {
      return Icon(
        Icons.pregnant_woman_outlined,
        color: Colors.yellow.shade900,
      );
    }
  }

  Future<void> changeStatus(String currentStatus) async {
    if (currentStatus == "normal") {
      currentStatus = "pregnent";
    } else {
      currentStatus = "normal";
    }

    await FirebaseFirestore.instance
        .collection("Cows")
        .doc(widget.docId)
        .update({'status': currentStatus});
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        elevation: 3,
        clipBehavior: Clip.antiAlias,
        child: ExpansionTile(
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Name : ${widget.name}",
                style: TextStyle(
                  fontSize: 20,
                ),
              ),
              setStatus(widget.status)
            ],
          ),
          expandedCrossAxisAlignment: CrossAxisAlignment.start,
          leading: Icon(Icons.arrow_circle_right_outlined),
          backgroundColor: Colors.green.shade200,
          clipBehavior: Clip.antiAlias,
          iconColor: Colors.black,
          childrenPadding: EdgeInsets.all(16),
          collapsedBackgroundColor: Colors.red.shade100,
          dense: true,
          maintainState: true,
          children: [
            Text(
              "Id : ${widget.docId}",
              style: TextStyle(
                fontSize: 18,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "Change Status",
                  style: TextStyle(
                    fontSize: 18,
                  ),
                ),
                MaterialButton(
                    onPressed: () {
                      changeStatus(widget.status);
                    },
                    child: Container(
                      decoration: BoxDecoration(
                          color: Colors.green,
                          borderRadius: BorderRadius.circular(16)),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 10),
                        child: const Text(
                          "Change",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, color: Colors.white),
                        ),
                      ),
                    ))
              ],
            ),
            Center(
              child: TextButton(
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => MoreDetails(docId: widget.docId,)));
                },
                child: Text("More", style: TextStyle(color: Colors.yellow, fontWeight: FontWeight.bold, fontSize: 14),),
              ),
            )
          ],
        ),
      ),
    );
    // return GestureDetector(
    //   onDoubleTap: (){
    //     setState(() {
    //       isExpanded = !isExpanded;
    //     });
    //   },
    //   child: Container(
    //     height: isExpanded? 120: 50,
    //     decoration: BoxDecoration(
    //       border: Border.all(color: Colors.grey,),
    //       borderRadius: BorderRadius.circular(16),
    //       color: Colors.deepPurpleAccent.shade100
    //     ),
    //     clipBehavior: Clip.antiAlias,
    //     child: Column(
    //       children: [
    //         Text("Name : ${widget.name}", style: TextStyle(fontSize: 22),),
    //         Text("Age : ${widget.age}", style: TextStyle(fontSize: 20)),
    //         Text("Breed : ${widget.breed}", style: TextStyle(fontSize: 20)),
    //         Text("Status: ${widget.status}", style: TextStyle(fontSize: 20))
    //       ],
    //     ),
    //   ),
    // );
  }
}

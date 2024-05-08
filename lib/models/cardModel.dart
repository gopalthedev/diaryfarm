import 'package:flutter/material.dart';

class CardModel extends StatefulWidget {
  const CardModel({super.key, required this.dataLine, required this.dataValue});
  final String dataLine;
  final double dataValue;
  @override
  State<CardModel> createState() => _CardModelState();
}

class _CardModelState extends State<CardModel> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        height: 120,
        width: MediaQuery.of(context).size.width/2-50,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          gradient: LinearGradient(
            colors: [Colors.green, Colors.green.shade200],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter
          ),
        ),

        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(widget.dataLine, style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),overflow: TextOverflow.ellipsis,),
                const Spacer(),
                Text("${widget.dataValue}", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold))
              ],
            ),
          ),
        ),
      ),
    );
  }
}

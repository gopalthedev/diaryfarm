import 'package:flutter/material.dart';

class LinearBar extends StatefulWidget {
  const LinearBar({super.key, required this.placeholder, required this.value});

  final String placeholder;
  final String value;

  @override
  State<LinearBar> createState() => _LinearBarState();
}

class _LinearBarState extends State<LinearBar> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        height: 50,
        width: MediaQuery.of(context).size.width - 50,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            gradient: LinearGradient(
                colors: [Colors.green, Colors.yellow.shade300]
            )
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(widget.placeholder + ": ", style: TextStyle(color: Colors.black, fontSize: 18),),
              Text(widget.value, style: TextStyle(color: Colors.black, fontSize: 18)),
            ],
          ),
        ),
      ),
    );
  }
}

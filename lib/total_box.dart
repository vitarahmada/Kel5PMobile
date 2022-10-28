import 'package:flutter/material.dart';

class TotalBox extends StatelessWidget {
  final String title;
  final String amount;
  const TotalBox({Key? key, required this.title, required this.amount})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Text(
            title,
            style: TextStyle(fontSize: 12, color: Colors.black),
          ),
          SizedBox(
            height: 4,
          ),
          Text(
            amount,
            style: TextStyle(fontSize: 20, color: Colors.black),
          ),
        ],
      ),
    );
  }
}

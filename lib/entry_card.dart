import 'package:flutter/material.dart';

class EntryCard extends StatelessWidget {
  final String title;
  final String amount;
  final String type;
  const EntryCard(
      {Key? key,
      required this.title,
      required this.amount,
      required this.type});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 14),
      child: Card(
        child: ListTile(
          title: Text(
            title,
            style: TextStyle(fontSize: 16, color: Colors.black),
          ),
          trailing: Text(
            amount,
            style: TextStyle(
                fontSize: 20, color: type == "cr" ? Colors.green : Colors.red),
          ),
        ),
      ),
    );
  }
}

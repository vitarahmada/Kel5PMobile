//import 'dart:html';

import 'package:catatankeuangan/entry_card.dart';
import 'package:catatankeuangan/total_box.dart';
import 'package:flutter/material.dart';

import 'add_data.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey,
      appBar: AppBar(
        title: Text("Catatan Keuangan"),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(MaterialPageRoute(builder: (context) => const AddData()));
        },
        child: Icon(Icons.add),
      ),
      body: Column(
        // SUB MENU
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 14, left: 14, right: 14),
            child: Card(
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    TotalBox(title: "Pemasukan", amount: "0"),
                    SizedBox(
                      height: 26,
                      child: VerticalDivider(
                        thickness: 1,
                        width: 1,
                        color: Colors.grey,
                      ),
                    ),
                    TotalBox(title: "Pengeluaran", amount: "0"),
                    SizedBox(
                      height: 26,
                      child: VerticalDivider(
                        thickness: 1,
                        width: 1,
                        color: Colors.grey,
                      ),
                    ),
                    TotalBox(title: "Saldo", amount: "0")
                  ],
                ),
              ),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          EntryCard(title: "Makanan", amount: "20000", type: "cr"),
          EntryCard(title: "Uang Saku", amount: "100000", type: "dr"),
        ],
      ),
    );
  }
}

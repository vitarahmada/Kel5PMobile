//import 'dart:html';

import 'package:catatankeuangan/entry_card.dart';
import 'package:catatankeuangan/total_box.dart';
import 'package:flutter/material.dart';

import 'add_data.dart';
import 'data.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  double totalIncome = 0;
  double totalExpenses = 0;
  double totalBalance = 0;

  calculate() {
    totalIncome = 0;
    totalExpenses = 0;
    totalBalance = 0;
    dataList.forEach((element) {
      if (element.type == 'cr') {
        totalIncome += element.amount;
      } else {
        totalExpenses += element.amount;
      }

      setState(() {
        totalBalance = totalIncome - totalExpenses;
      });
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    calculate();
  }

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
                    TotalBox(title: "Pemasukan", amount: '$totalIncome'),
                    SizedBox(
                      height: 26,
                      child: VerticalDivider(
                        thickness: 1,
                        width: 1,
                        color: Colors.grey,
                      ),
                    ),
                    TotalBox(title: "Pengeluaran", amount: '$totalExpenses'),
                    SizedBox(
                      height: 26,
                      child: VerticalDivider(
                        thickness: 1,
                        width: 1,
                        color: Colors.grey,
                      ),
                    ),
                    TotalBox(title: "Saldo", amount: '$totalBalance')
                  ],
                ),
              ),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Expanded(
              child:RefreshIndicator(
                onRefresh: () {
                  calculate();
                  return Future.delayed(Duration(seconds: 1));
                },
                child: ListView.builder(
                    itemCount: dataList.length,
                    itemBuilder: ((context, index) => EntryCard(
                        title: dataList[index].title,
                        amount: dataList[index].amount.toString(),
                        type: dataList[index].type))),
              )
          )
        ],
      ),
    );
  }
}
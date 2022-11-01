import 'package:catatankeuangan/data.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'transaction.dart';

class AddData extends StatefulWidget {
  const AddData({Key? key}) : super(key: key);

  @override
  State<AddData> createState() => _AddDataState();
}

class _AddDataState extends State<AddData> {
  String type = 'dr'; // cr = income, dr = expense

  //controller
  TextEditingController amountCont = TextEditingController();
  TextEditingController titleCont = TextEditingController();

  ShowToastMsg(String msg, {Color c = Colors.red}) {
    Fluttertoast.showToast(
        msg: msg,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Add Income / Expenses'),
        ),
        body: Column(children: [
          Padding(
              padding: const EdgeInsets.only(top: 14, left: 14, right: 14),
              child: TextFormField(
                controller: amountCont,
                decoration: InputDecoration(
                  hintText: 'Enter Amount',
                ),
                keyboardType: TextInputType.number,
              )),
          Padding(
              padding: const EdgeInsets.all(14),
              child: TextFormField(
                controller: titleCont,
                decoration: InputDecoration(
                  hintText: 'Enter Title',
                ),
                keyboardType: TextInputType.text,
              )),
          SizedBox(
            width: 14,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Type :'),
              SizedBox(
                width: 14,
              ),
              GestureDetector(
                onTap: () {
                  type = 'cr';
                  setState(() {});
                },
                child: Chip(
                    backgroundColor:
                    type == 'cr' ? Colors.orange : Colors.grey[200],
                    label: Text('Income')),
              ),
              SizedBox(
                width: 14,
              ),
              GestureDetector(
                onTap: () {
                  type = 'dr';
                  setState(() {});
                },
                child: Chip(
                    backgroundColor:
                    type == 'dr' ? Colors.orange : Colors.grey[200],
                    label: Text('Expense')),
              )
            ],
          ),
          SizedBox(
            width: 14,
          ),
          Row(mainAxisAlignment: MainAxisAlignment.center, children: [
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: ElevatedButton(
                onPressed: () {
                  if (amountCont.text.isEmpty) {
                    ShowToastMsg('Enter Valid Amount');
                    return;
                  }
                  if (titleCont.text.isEmpty) {
                    ShowToastMsg('Enter Valid Title');
                    return;
                  }

                  dataList.add(Transaction(titleCont.text.trim(),
                      double.parse(amountCont.text.trim()), type));

                  ShowToastMsg('Saved!', c: Colors.green);
                },
                child:
                Container(width: 100, child: Center(child: Text('Save'))),
              ),
            )
          ])
        ]));
  }
}
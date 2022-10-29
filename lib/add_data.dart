import 'package:flutter/material.dart';

class AddData extends StatefulWidget {
  const AddData({Key? key}) : super(key: key);

  @override
  State<AddData> createState() => _AddDataState();
}

class _AddDataState extends State<AddData> {
  String type = 'dr'; // cr = income, dr = expense

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Income / Expenses'),
      )
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 14, left: 14, right: 14),
            child: TextFormField(
              decoration: InputDecoration(
                hintText: 'Enter Amount',
              )
              keyboardType: TextInputType.number,
            )
          ),

          Padding(
            padding: const EdgeInsets.only(top: 14, left: 14, right: 14),
            child: TextFormField(
              decoration: InputDecoration(
                hintText: 'Enter Title',
              )
              keyboardType: TextInputType.text,
            )
          ),

          SizedBox(
            heigth: 14,
          )

          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Type :'),
              SizedBox(width: 14,),
              GestureDetector(
                onTap: (){
                  type = 'cr';
                  setState() {

                  }
                },
                child: Chip(
                  backgroundColor: type == 'cr' ? Colors.orange : Colors.grey[200],
                  label: Text('Income')),
              )
              SizedBox(width: 14,),
              GestureDetector(
                onTap: (){
                  type = 'dr';
                  setState() {

                  }
                },
                child: Chip(
                  backgroundColor: type == 'dr' ? Colors.orange : Colors.grey[200],
                  label: Text('Expense')),
              )
              
            ],
          )

          SizedBox(width: 14,),

          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: () {},
                child: Container(width: 100, child: Text('Save')),
              )
            ]
          )
        ]
      )
    )
  }
}
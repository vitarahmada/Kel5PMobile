/* import 'package:flutter/material.dart';
import 'package:catatankeuangan/data.dart';

class AddData extends StatefulWidget {
  const AddData ({Key? key}) : super(key: key);

  @override
  State<AddData> createState() => _AddDataState();
}

class _AddDataState extends State<AddData> {
  DatabaseInstance databaseInstance = DatabaseInstance();
  TextEditingController nameController = TextEditingController();
  TextEditingController totalController = TextEditingController();
  int _value = 1;

  @override
  void initState() {
    databaseInstance.database();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Create"),
      ),
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Nama"),
            TextField(
              controller: nameController,
            ),
            SizedBox(
              height: 20,
            ),
            Text("Tipe Transaksi"),
            ListTile(
              title: Text("Pemasukan"),
              leading: Radio(
                  groupValue: _value,
                  value: 1,
                  onChanged: (value) {
                    setState(() {
                      _value = int.parse(value.toString());
                    });
                  }),
            ),
            ListTile(
              title: Text("Pengeluaran"),
              leading: Radio(
                  groupValue: _value,
                  value: 2,
                  onChanged: (value) {
                    setState(() {
                      _value = int.parse(value.toString());
                    });
                  }),
            ),
            SizedBox(
              height: 20,
            ),
            Text("Total"),
            TextField(
              controller: totalController,
            ),
            SizedBox(
              height: 30,
            ),
            ElevatedButton(
                onPressed: () async {
                  int idInsert = await databaseInstance.insert({
                    'name': nameController.text,
                    'type': _value,
                    'total': totalController.text,
                    'created_at': DateTime.now().toString(),
                    'updated_at': DateTime.now().toString(),
                  });
                  print("sudah masuk : " + idInsert.toString());
                  Navigator.pop(context);
                },
                child: Text("Simpan")),
          ],
        ),
      )),
    );
  }
} */

//import 'dart:html';

import 'package:flutter/material.dart';
import 'main.dart';
import 'databaseHelper.dart';

class FormWishlist extends StatefulWidget {
  const FormWishlist({Key? key}) : super(key: key);

  @override
  State<FormWishlist> createState() => _FormWishlistState();
}

class _FormWishlistState extends State<FormWishlist> {
  List<Map<String, dynamic>> _daftar_ = [];

  void _refreshWishlist() async {
    final data = await SQLHelper.getItems();
    setState(() {
      _daftar_ = data;
    });
  }

  @override
  void initState() {
    super.initState();
    _refreshWishlist(); // Loading the wishlist when the app starts
  }

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _totalController = TextEditingController();
  final TextEditingController _createdAtController = TextEditingController();
  int type = 1;

  void list(int? id) async {
    final dftrWishlist = _daftar_.firstWhere((element) => element['id'] == id);
    _nameController.text = dftrWishlist['name'];
    _totalController.text = dftrWishlist['total'];
    type = dftrWishlist['type'];
    _createdAtController.text = dftrWishlist['createAt'];
  }

  // Insert a new wishlist to the database
  Future<void> _addItem() async {
    int total = int.parse(_totalController.text);
    await SQLHelper.createItem(
      _nameController.text,
      total,
      type,
      _createdAtController.text,
    );
    _refreshWishlist();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Catatan Keuangan'),
        ),
        body: Card(
            margin: const EdgeInsets.fromLTRB(20, 10, 20, 10),
            child: Column(children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  controller: _nameController,
                  decoration: InputDecoration(
                      labelText: 'name',
                      hintText: 'name of transaction',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      )),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  controller: _totalController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                      labelText: 'total',
                      hintText: 'total of transaction',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      )),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  controller: _createdAtController,
                  keyboardType: TextInputType.datetime,
                  decoration: InputDecoration(
                      labelText: 'creat at',
                      hintText: 'date of input the transaction',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      )),
                ),
              ),
              Text("Tipe Transaksi"),
              Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Type :'),
              SizedBox(
                width: 14,
              ),
              GestureDetector(
                onTap: () {
                  type = 1;
                  setState(() {});
                },
                child: Chip(
                    backgroundColor:
                    type == 1 ? Colors.orange : Colors.grey[200],
                    label: Text('Income')),
              ),
              SizedBox(
                width: 14,
              ),
              GestureDetector(
                onTap: () {
                  type = 2;
                  setState(() {});
                },
                child: Chip(
                    backgroundColor:
                    type == 2 ? Colors.orange : Colors.grey[200],
                    label: Text('Expense')),
              )
            ],
          ),
                  ElevatedButton(
                    onPressed: () async {
                      await _addItem();

                      // Clear the text fields
                      _nameController.text = '';
                      _totalController.text = '';
                      _createdAtController.text = '';

                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => MyApp()));
                    },
                    child: const Text('Create'),
                  ),
                ]),
              )
            );
    //),
    //);
  }
}

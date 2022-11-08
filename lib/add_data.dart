import 'package:flutter/material.dart';
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
}
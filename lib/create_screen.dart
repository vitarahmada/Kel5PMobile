import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'database_instance.dart';

List<String> list = <String>['Gaji', 'Pemberian', 'Bonus', 'Makanan', 'Pakaian', 'Hiburan'];

class CreateScreen extends StatefulWidget {
  const CreateScreen({Key? key}) : super(key: key);

  @override
  State<CreateScreen> createState() => _CreateScreenState();
}

class _CreateScreenState extends State<CreateScreen> {
  DatabaseInstance databaseInstance = DatabaseInstance();
  
  String formattedDateCreated = (DateFormat.yMd().add_jm().format(DateTime.now()));
  String formattedDateUpdated = (DateFormat.yMd().add_jm().format(DateTime.now()));
  TextEditingController ketController = TextEditingController();
  TextEditingController totalController = TextEditingController();
  int _value = 1;
  String dropdownValue = list.first;

  @override
  void initState() {
    // implementasi initState
    databaseInstance.database();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: Text("Create"),
            elevation: 10,
            ),
        body: SingleChildScrollView(
          child: SafeArea(
              child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 20,
                ),
                Text("Kategori"),
                DropdownButton<String>(
                  value: dropdownValue,
                  icon: const Icon(Icons.arrow_downward),
                  elevation: 16,
                  style: const TextStyle(color: Colors.black),
                  underline: Container(
                    height: 2,
                    color: Color.fromARGB(255, 1, 100, 5),
                  ),
                  onChanged: (String? value) {
                    setState(() {
                      dropdownValue = value!;
                    });
                  },
                  items: list.map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
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
                Text("Jumlah"),
                TextField(
                  controller: totalController,
                ),
                SizedBox(
                  height: 20,
                ),
                Text("Keterangan"),
                TextField(
                  controller: ketController,
                ),
                SizedBox(
                  height: 20,
                ),
                ElevatedButton(
                    onPressed: () async {
                      color:
                      Colors.black;
                      int total = int.parse(totalController.text);
                      await databaseInstance.insert({
                        'ket' : ketController.text,
                        'kategori': dropdownValue,
                        'type': _value,
                        'total': total,
                        'created_at': formattedDateCreated,
                        'updated_at': formattedDateUpdated,
                      });
                      setState((){});
                      //print("sudah masuk : " + idInsert.toString());
                      Navigator.pop(context);
                    },
                    child: Text("Simpan")),
              ],
            ),
          )),
        ));
  }
}

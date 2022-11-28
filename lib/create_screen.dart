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
            title: const Text("Create"),
            elevation: 10,
            ),
        body: SingleChildScrollView(
          child: SafeArea(
              child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 20,
                ),
                const Text("Jumlah"),
                TextField(
                  controller: totalController,
                ),
                const SizedBox(
                  height: 20,
                ),
                const Text("Kategori"),
                DropdownButton<String>(
                  value: dropdownValue,
                  icon: const Icon(Icons.arrow_drop_down, color: Color.fromARGB(255, 188, 206, 248)),
                  elevation: 16,
                  style: const TextStyle(color: Colors.black),
                  underline: Container(
                    height: 2,
                    width: 5,
                    color: const Color.fromARGB(255, 1, 100, 5),
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
                const SizedBox(
                  height: 20,
                ),
                const Text("Tipe Transaksi"),
                ListTile(
                  title: const Text("Pemasukan"),
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
                  title: const Text("Pengeluaran"),
                  leading: Radio(
                      groupValue: _value,
                      value: 2,
                      onChanged: (value) {
                        setState(() {
                          _value = int.parse(value.toString());
                        });
                      }),
                ),
                const SizedBox(
                  height: 20,
                ),
                const Text("Keterangan"),
                TextField(
                  controller: ketController,
                ),
                const SizedBox(
                  height: 20,
                ),
                ElevatedButton(
                    onPressed: () async {
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
                    child: const Text("Simpan")),
              ],
            ),
          )),
        ));
  }
}

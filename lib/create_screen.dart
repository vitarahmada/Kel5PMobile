import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'database_instance.dart';

List<String> list = <String>[
  'Gaji',
  'Pemberian',
  'Bonus',
  'Makanan',
  'Pakaian',
  'Hiburan'
];

class CreateScreen extends StatefulWidget {
  const CreateScreen({Key? key}) : super(key: key);

  @override
  State<CreateScreen> createState() => _CreateScreenState();
}

class _CreateScreenState extends State<CreateScreen> {
  DatabaseInstance databaseInstance = DatabaseInstance();

  TextEditingController date = TextEditingController();
  TextEditingController ketController = TextEditingController();
  TextEditingController totalController = TextEditingController();
  int _value = 1;
  String dropdownValue = list.first;

  @override
  void initState() {
    // implementasi initState
    databaseInstance.database();
    date.text = "";
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
                Text("Tanggal : "),
                TextField(
                  controller: date,
                  
                    decoration: const InputDecoration(
                      icon: Icon(Icons.calendar_today),
                      labelText: "Masukkan Tanggal",
                    ),
                    readOnly: true,
                    onTap: () async {
                      DateTime? pickedDate = await showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime(2000),
                          lastDate: DateTime(2100));
                      if (pickedDate != null) {
                        String formattedDate =DateFormat.yMd().format(pickedDate);
                        setState(() {
                          date.text = formattedDate.toString();
                        });
                      } else {
                        print("not selected");
                      }
                    }
                ),
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
                  icon: const Icon(Icons.arrow_drop_down_outlined),
                  elevation: 16,
                  style: const TextStyle(color: Colors.black),
                  underline: Container(
                    height: 2,
                    width: 10,
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
                const Text("Keterangan"),
                TextField(
                  controller: ketController,
                ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text('Type :'),
                    const SizedBox(
                      width: 14,
                    ),
                    GestureDetector(
                      onTap: () {
                        _value = 1;

                        setState(() {});
                      },
                      child: Chip(
                          backgroundColor:
                              _value == 1 ? Colors.blueGrey : Colors.grey[200],
                          label: const Text('Income')),
                    ),
                    const SizedBox(
                      width: 14,
                    ),
                    GestureDetector(
                      onTap: () {
                        _value = 2;
                        setState(() {});
                      },
                      child: Chip(
                          backgroundColor:
                              _value == 2 ? Colors.blueGrey : Colors.grey[200],
                          label: const Text('Expense')),
                    )
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                ElevatedButton(
                    onPressed: () async {
                      Colors.black;
                      int total = int.parse(totalController.text);
                      await databaseInstance.insert({
                        'ket': ketController.text,
                        'kategori': dropdownValue,
                        'type': _value,
                        'total': total,
                        'created_at': date.text,
                        'updated_at': date.text,
                      });
                      setState(() {});
                      //print("sudah masuk : " + idInsert.toString());
                      // ignore: use_build_context_synchronously
                        print(date.text);
                      Navigator.pop(context);
                    },
                    child: const Text("Simpan")),
              ],
            ),
          )),
        ));
  }
}

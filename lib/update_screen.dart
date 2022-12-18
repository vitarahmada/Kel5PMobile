import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'database_instance.dart';
import 'transaksi_model.dart';

List<String> list = <String>[
  'Gaji',
  'Pemberian',
  'Bonus',
  'Makanan',
  'Pakaian',
  'Hiburan'
];

class UpdateScreen extends StatefulWidget {
  final TransaksiModel transaksiMmodel;
  const UpdateScreen({Key? key, required this.transaksiMmodel})
      : super(key: key);

  @override
  State<UpdateScreen> createState() => _UpdateScreenState();
}

class _UpdateScreenState extends State<UpdateScreen> {
  DatabaseInstance databaseInstance = DatabaseInstance();

  TextEditingController date = TextEditingController();
  TextEditingController ketController = TextEditingController();
  TextEditingController totalController = TextEditingController();
  String dropdownValue = list.first;
  int _value = 1;

  @override
  void initState() {
    // implementasi initState
    databaseInstance.database();
    date.text = widget.transaksiMmodel.updatedAt.toString();
    dropdownValue = widget.transaksiMmodel.kategori!;
    ketController.text = widget.transaksiMmodel.ket!;
    totalController.text = widget.transaksiMmodel.total.toString();
    _value = widget.transaksiMmodel.type!;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Update"),
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
              Text(
                "Tanggal : ",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              TextField(
                  controller: date,
                  decoration: const InputDecoration(
                    icon: Icon(Icons.calendar_today),
                    labelText: "Masukkan Tanggal",
                  ),
                  readOnly: true,
                  onTap: () async {
                    int thnPicked = int.parse(date.text.split('/')[2]);
                    int blnPicked = int.parse(date.text.split('/')[0]);
                    int dayPicked = int.parse(date.text.split('/')[1]);

                    DateTime? pickedDate = await showDatePicker(
                        context: context,
                        initialDate:
                            DateTime(thnPicked, blnPicked, dayPicked),
                        firstDate: DateTime(2000),
                        lastDate: DateTime(2100));
                    if (pickedDate != null) {
                      String formattedDate =
                          DateFormat.yMd().format(pickedDate);
                      setState(() {
                        date.text = formattedDate.toString();
                        //untuk cek
                        print(date.text);
                      });
                    } else {
                      //untuk cek
                      print("not selected");
                      print((date.text).split('/')[0]);
                    }
                  }),
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
                  Text('Type :'),
                  SizedBox(
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
                        label: Text('Income')),
                  ),
                  SizedBox(
                    width: 14,
                  ),
                  GestureDetector(
                    onTap: () {
                      _value = 0;
                      setState(() {});
                    },
                    child: Chip(
                        backgroundColor:
                            _value == 0 ? Colors.blueGrey : Colors.grey[200],
                        label: Text('Expense')),
                  )
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              ElevatedButton(
                  onPressed: () async {
                    int total = int.parse(totalController.text);
                    await databaseInstance
                        .update(widget.transaksiMmodel.id!.toInt(), {
                      'ket': ketController.text,
                      'kategori': dropdownValue,
                      'type': _value,
                      'total': total,
                      'updated_at': date.text,
                    });
                    // print("sudah masuk : " + idInsert.toString());
                    // ignore: use_build_context_synchronously
                    Navigator.pop(context);
                  },
                  child: const Text("Simpan")),
            ],
          ),
        )),
      ),
    );
  }
}

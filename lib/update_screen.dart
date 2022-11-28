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

  String formattedDateUpdated =
      (DateFormat.yMd().add_jm().format(DateTime.now()));
  TextEditingController ketController = TextEditingController();
  TextEditingController totalController = TextEditingController();
  String dropdownValue = list.first;
  int _value = 1;

  @override
  void initState() {
    // implementasi initState
    databaseInstance.database();
    formattedDateUpdated = widget.transaksiMmodel.updatedAt!;
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
              const Text("Kategori"),
              DropdownButton<String>(
                value: dropdownValue,
                icon: const Icon(Icons.arrow_downward),
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
              const Text("Jumlah"),
              TextField(
                controller: totalController,
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
                    int total = int.parse(totalController.text);
                    await databaseInstance
                        .update(widget.transaksiMmodel.id!.toInt(), {
                      'ket': ketController.text,
                      'kategori': dropdownValue,
                      'type': _value,
                      'total': total,
                      'updated_at': formattedDateUpdated,
                    });
                    // print("sudah masuk : " + idInsert.toString());
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

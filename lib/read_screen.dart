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

class ReadScreen extends StatefulWidget {
  final TransaksiModel transaksiMmodel;
  const ReadScreen({Key? key, required this.transaksiMmodel}) : super(key: key);

  @override
  State<ReadScreen> createState() => _ReadScreenState();
}

class _ReadScreenState extends State<ReadScreen> {
  DatabaseInstance databaseInstance = DatabaseInstance();

  TextEditingController date = TextEditingController();
  TextEditingController ketController = TextEditingController();
  TextEditingController totalController = TextEditingController();
  TextEditingController kategori = TextEditingController();
  int _value = 1;

  @override
  void initState() {
    // implementasi initState
    databaseInstance.database();
    date.text = widget.transaksiMmodel.updatedAt!;
    kategori.text = widget.transaksiMmodel.kategori!;
    ketController.text = widget.transaksiMmodel.ket!;
    totalController.text = widget.transaksiMmodel.total.toString();
    _value = widget.transaksiMmodel.type!;

    //formattedDateUpdated.split('/')[0];

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        //title: Text("${_bulan(formattedDateUpdated)}"),
        title: Text("Read"),
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
                "Tanggal : ${date.text}"),
              const SizedBox(
                height: 20,
              ),
              Text("Jumlah "),
              TextField(
                controller: totalController,
                readOnly: true,
              ),
              const SizedBox(
                height: 20,
              ),
              const Text("Kategori"),
              TextField(
                controller: kategori,
                readOnly: true,
              ),
              const SizedBox(
                height: 20,
              ),
              const Text("Keterangan"),
              TextField(
                controller: ketController,
                readOnly: true,
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
                  Chip(
                        backgroundColor:
                            _value == 1 ? Colors.blueGrey : Colors.grey[200],
                        label: Text('Income')),
                  SizedBox(
                    width: 14,
                  ),
                  Chip(
                        backgroundColor:
                            _value == 0 ? Colors.blueGrey : Colors.grey[200],
                        label: Text('Expense')),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
            ],
          ),
        )),
      ),
    );
  }
}

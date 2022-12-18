import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'database_instance.dart';

List<String> bulan = <String>[
  'January',
  'February',
  'March',
  'April',
  'May',
  'June',
  'July',
  'August',
  'September',
  'October',
  'November',
  'December'
];

class LaporanPerBulan extends StatefulWidget {
  const LaporanPerBulan({Key? key}) : super(key: key);

  @override
  State<LaporanPerBulan> createState() => _LaporanPerBulanState();
}

class _LaporanPerBulanState extends State<LaporanPerBulan> {
  DatabaseInstance? databaseInstance;

  String list_bulan = bulan.first;
  String bulan_ = '';
  String formattedDateUpdated = (DateFormat.yMd().format(DateTime.now()));

  Future _refresh() async {
    setState(() {});
  }

  @override
  void initState() {
    databaseInstance = DatabaseInstance();
    super.initState();
    initDatabase();
  }

  Future initDatabase() async {
    await databaseInstance!.database();
    setState(() {});
  }

  showAlertDialog(BuildContext contex, int idTransaksi) {
    AlertDialog alertDialog = AlertDialog(
      title: const Text("Peringatan!"),
      content: const Text("Apakah Anda yakin ingin menghapus?"),
      actions: <Widget>[
        TextButton(
          onPressed: () {
            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                content: Text('Deleting is cancelled!'),
                duration: Duration(seconds: 1)));
            Navigator.pop(context);
          },
          child: const Text('Tidak'),
        ),
        TextButton(
            onPressed: () async {
              DatabaseInstance().hapus(idTransaksi);
              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                content: Text('Successfully deleted a wishlist!'),
                duration: Duration(seconds: 1),
              ));
              Navigator.of(contex, rootNavigator: true).pop();
              _refresh();
            },
            child: const Text('Ya')),
      ],
    );

    showDialog(
        context: contex,
        builder: (BuildContext context) {
          return alertDialog;
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Laporan"),
          elevation: 5.0,
        ),
        body: RefreshIndicator(
            onRefresh: _refresh,
            child: Column(children: [
              Flexible(
                  flex: 1,
                  child: Row(children: [
                    Flexible(
                      flex: 3,
                      fit: FlexFit.tight,
                      child: Container(
                        color: const Color.fromARGB(255, 188, 206, 248),
                        child: Column(
                          children: [
                            const Padding(padding: EdgeInsets.all(3)),
                            Flexible(
                              flex: 2,
                              child: Center(
                                child: DropdownButton<String>(
                                  value: list_bulan,
                                  icon: Icon(Icons.arrow_drop_down_outlined),
                                  elevation: 16,
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 14.0,
                                      fontWeight: FontWeight.w700),
                                  underline: Container(
                                    height: 2,
                                    width: 10,
                                    color: Color.fromARGB(255, 1, 100, 5),
                                  ),
                                  onChanged: (String? value) {
                                    list_bulan = value!;

                                    if (list_bulan == bulan[0]) {
                                      bulan_ = '1';
                                      setState(() {});
                                    } else if (list_bulan == bulan[1]) {
                                      bulan_ = '2';
                                      setState(() {});
                                    } else if (list_bulan == bulan[2]) {
                                      bulan_ = '3';
                                      setState(() {});
                                    } else if (list_bulan == bulan[3]) {
                                      bulan_ = '4';
                                      setState(() {});
                                    } else if (list_bulan == bulan[4]) {
                                      bulan_ = '5';
                                      setState(() {});
                                    } else if (list_bulan == bulan[5]) {
                                      bulan_ = '6';
                                      setState(() {});
                                    } else if (list_bulan == bulan[6]) {
                                      bulan_ = '7';
                                      setState(() {});
                                    } else if (list_bulan == bulan[7]) {
                                      bulan_ = '8';
                                      setState(() {});
                                    } else if (list_bulan == bulan[8]) {
                                      bulan_ = '9';
                                      setState(() {});
                                    } else if (list_bulan == bulan[9]) {
                                      bulan_ = '10';
                                      setState(() {});
                                    } else if (list_bulan == bulan[10]) {
                                      bulan_ = '11';
                                      setState(() {});
                                    } else if (list_bulan == bulan[11]) {
                                      bulan_ = '12';
                                      setState(() {});
                                    }
                                  },
                                  items: bulan.map<DropdownMenuItem<String>>(
                                          (String value) {
                                        return DropdownMenuItem<String>(
                                          value: value,
                                          child: Text(value),
                                        );
                                      }).toList(),
                                ),
                              ),
                            ),
                            Flexible(
                              flex: 1,
                              child: FutureBuilder(
                                  future:
                                  databaseInstance?.saldoPerBulan(bulan_),
                                  builder: (context, snapshot) {
                                    if (snapshot.connectionState ==
                                        ConnectionState.waiting) {
                                      return const Text("-");
                                    } else {
                                      if (snapshot.hasData) {
                                        return Text(
                                            "Saldo : Rp. ${snapshot.data.toString()}");
                                      } else {
                                        return const Text("");
                                      }
                                    }
                                  }),
                            ),
                            Flexible(
                                flex: 1,
                                child: FutureBuilder(
                                    future: databaseInstance
                                        ?.totalPemasukanPerBulan(bulan_),
                                    builder: (context, snapshot) {
                                      if (snapshot.connectionState ==
                                          ConnectionState.waiting) {
                                        return const Text("-");
                                      } else {
                                        if (snapshot.hasData) {
                                          return Text(
                                              "Total pemasukan : Rp. ${snapshot.data.toString()}");
                                        } else {
                                          return const Text("");
                                        }
                                      }
                                    })),
                            Flexible(
                              flex: 1,
                              child: FutureBuilder(
                                  future: databaseInstance
                                      ?.totalPengeluaranPerBulan(bulan_),
                                  builder: (context, snapshot) {
                                    if (snapshot.connectionState ==
                                        ConnectionState.waiting) {
                                      return const Text("-");
                                    } else {
                                      if (snapshot.hasData) {
                                        return Text(
                                            "Total pengeluaran : Rp. ${snapshot.data.toString()}");
                                      } else {
                                        return const Text("");
                                      }
                                    }
                                  }),
                            ),
                            const Padding(padding: EdgeInsets.all(3)),
                          ],
                        ),
                      ),
                    )
                  ])),
              const Padding(padding: EdgeInsets.all(5)),
              const Flexible(
                  flex: 1,
                  child: Text(
                    "History",
                    style: TextStyle(fontSize: 30),
                  )),
              const Padding(padding: EdgeInsets.all(5)),
              Flexible(
                flex: 4,
                child: FutureBuilder(
                    future: databaseInstance!.getPerBulan(bulan_),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Text("Loading");
                      } else {
                        if (snapshot.hasData) {
                          return ListView.builder(
                              itemCount: snapshot.data!.length,
                              itemBuilder: (context, index) {
                                return Card(
                                    margin:
                                    const EdgeInsets.fromLTRB(20, 5, 20, 5),
                                    child: ListTile(
                                        leading: SizedBox(
                                          width: 50,
                                          child: snapshot.data![index]
                                          ['type'] ==
                                              1
                                              ? IconButton(
                                            icon: const Icon(
                                                Icons.download),
                                            color: Colors.green,
                                            onPressed: () {},
                                          )
                                              : IconButton(
                                            icon:
                                            const Icon(Icons.upload),
                                            color: Colors.redAccent,
                                            onPressed: () {},
                                          ),
                                        ),
                                        tileColor: const Color.fromARGB(
                                            255, 188, 206, 248),
                                        title: Text(
                                            "${snapshot.data![index]['kategori']} : ${snapshot.data![index]['total']}"),
                                        subtitle: Text(
                                            "${snapshot.data![index]['updated_at']}")));
                              });
                        } else {
                          return const Text("Tidak ada data");
                        }
                      }
                    }),
              )
            ])));
    /* ]))
        ]),
      ),
    ); */
  }
}
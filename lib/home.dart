import 'package:flutter/material.dart';
import 'package:catatankeuangan/data.dart';
import 'package:catatankeuangan/transaction.dart';
import 'package:catatankeuangan/add_data.dart';
//import 'package:catatankeuangan/update_data.dart';

/* void main() {
  runApp(Home());
}

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Kelola Duitku",
      home: MyHomePage(),
    );
  }
} */

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  DatabaseInstance? databaseInstance;

  Future _refresh() async {
    setState(() {});
  }

  @override
  void initState() {
    databaseInstance = DatabaseInstance();
    initDatabase();
    super.initState();
  }

  Future initDatabase() async {
    await databaseInstance!.database();
    setState(() {});
  }

  showAlertDialog(BuildContext contex, int idTransaksi) {
    Widget okButton = FloatingActionButton(
      child: Text("Yakin"),
      onPressed: () {
        //delete disini
        databaseInstance!.hapus(idTransaksi);
        Navigator.of(contex, rootNavigator: true).pop();
        setState(() {});
      },
    );

    AlertDialog alertDialog = AlertDialog(
      title: Text("Peringatan !"),
      content: Text("Anda yakin akan menghapus ?"),
      actions: [okButton],
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
        title: Text(" "),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              Navigator.of(context)
                  .push(MaterialPageRoute(builder: (context) => AddData()))
                  .then((value) {
                setState(() {});
              });
            },
          )
        ],
      ),
      body: RefreshIndicator(
        onRefresh: _refresh,
        child: SafeArea(
            child: Column(
          children: [
            SizedBox(
              height: 20,
            ),
            FutureBuilder(
                future: databaseInstance!.totalPemasukan(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Text("-");
                  } else {
                    if (snapshot.hasData) {
                      return Text(
                          "Total pemasukan : Rp. ${snapshot.data.toString()}");
                    } else {
                      return Text("");
                    }
                  }
                }),
            SizedBox(
              height: 20,
            ),
            FutureBuilder(
                future: databaseInstance!.totalPengeluaran(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Text("-");
                  } else {
                    if (snapshot.hasData) {
                      return Text(
                          "Total pengeluaran : Rp. ${snapshot.data.toString()}");
                    } else {
                      return Text("");
                    }
                  }
                }),
            FutureBuilder<List<TransaksiModel>>(
                future: databaseInstance!.getAll(),
                builder: (context, snapshot) {
                  print('HASIL : ' + snapshot.data.toString());
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Text("Loading");
                  } else {
                    if (snapshot.hasData) {
                      return Expanded(
                        child: ListView.builder(
                            itemCount: snapshot.data!.length,
                            itemBuilder: (context, index) {
                              return ListTile(
                                  title: Text(snapshot.data![index].name!),
                                  subtitle: Text(
                                      snapshot.data![index].total!.toString()),
                                  leading: snapshot.data![index].type == 1
                                      ? Icon(
                                          Icons.download,
                                          color: Colors.green,
                                        )
                                      : Icon(
                                          Icons.upload,
                                          color: Colors.red,
                                        ),
                                  trailing: Wrap(
                                    children: [
                                      IconButton(
                                          onPressed: () {
                                            /* Navigator.of(context)
                                                .push(MaterialPageRoute(
                                                    builder: (context) =>
                                                        UpdateScreen(
                                                          transaksiMmodel:
                                                              snapshot
                                                                  .data![index],
                                                        )))
                                                .then((value) {
                                              setState(() {});
                                            }); */
                                          },
                                          icon: Icon(
                                            Icons.edit,
                                            color: Colors.grey,
                                          )),
                                      SizedBox(
                                        width: 20,
                                      ),
                                      IconButton(
                                          onPressed: () {
                                            showAlertDialog(context,
                                                snapshot.data![index].id!);
                                          },
                                          icon: Icon(Icons.delete,
                                              color: Colors.red))
                                    ],
                                  ));
                            }),
                      );
                    } else {
                      return Text("Tidak ada data");
                    }
                  }
                }),
                FloatingActionButton(
            child: const Icon(Icons.add),
            foregroundColor: Colors.black,
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return AddData();
              }));
            })
          ],
          
        )),
      ),
    );
  }
}
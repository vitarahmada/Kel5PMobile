import 'package:catatankeuangan/laporan.dart';
import 'package:catatankeuangan/read_screen.dart';
import 'package:flutter/material.dart';
import 'database_instance.dart';
import 'create_screen.dart';
import 'update_screen.dart';
import 'about.dart';


enum MenuItem {
  laporan,
  about
}

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
              databaseInstance!.hapus(idTransaksi);
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
          title: const Text("Catatan Keuangan"),
          elevation: 5.0,
          actions: [PopupMenuButton(
              onSelected: (value) {
                if (value == MenuItem.laporan) {
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => LaporanPerBulan(),
                  ));
                }
                else if (value == MenuItem.about) {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => AboutUs()
                  ));
                }
              },
              itemBuilder: ((context) => [
                const PopupMenuItem(
                    value: MenuItem.laporan,
                    child: Text("Laporan")),
                const PopupMenuItem(
                    value: MenuItem.about,
                    child: Text("About"))
              ]))],
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
                          const Padding(padding: EdgeInsets.all(10)),
                          Flexible(
                            flex: 1,
                            child: FutureBuilder(
                                future: databaseInstance!.saldo(),
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
                                  future: databaseInstance!.totalPemasukan(),
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
                                future: databaseInstance!.totalPengeluaran(),
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
                          const Padding(padding: EdgeInsets.all(10)),
                        ],
                      ),
                    ),
                  )
                ])),
            const Padding(padding: EdgeInsets.all(3)),
            const Flexible(
                flex: 1,
                child: Text(
                  "History",
                  style: TextStyle(fontSize: 30),
                )),
            Flexible(
                flex: 4,
                child: FutureBuilder(
                    future: databaseInstance!.getAll(),
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
                                      onTap: () {
                                        Navigator.of(context).push(
                                            MaterialPageRoute(
                                                builder: (context) {
                                                  return ReadScreen(transaksiMmodel: snapshot.data![index],);
                                                })); /**/
                                      },
                                      leading: SizedBox(
                                        width: 50,
                                        child: snapshot.data![index].type == 1
                                            ? IconButton(
                                          icon:
                                          const Icon(Icons.download),
                                          color: Colors.green,
                                          onPressed: () {},
                                        )
                                            : IconButton(
                                          icon: const Icon(Icons.upload),
                                          color: Colors.redAccent,
                                          onPressed: () {},
                                        ),
                                      ),
                                      tileColor: const Color.fromARGB(
                                          255, 188, 206, 248),
                                      title: Text(
                                          "${snapshot.data![index].kategori!} : ${snapshot.data![index].total}"),
                                      subtitle: Text((snapshot
                                          .data![index].updatedAt
                                          .toString())),
                                      trailing: SizedBox(
                                        width: 70,
                                        child: Row(
                                          children: [
                                            Flexible(
                                                flex: 1,
                                                child: IconButton(
                                                    icon:
                                                    const Icon(Icons.edit),
                                                    onPressed: () {
                                                      Navigator.of(context)
                                                          .push(
                                                          MaterialPageRoute(
                                                              builder:
                                                                  (context) =>
                                                                  UpdateScreen(
                                                                    transaksiMmodel:
                                                                    snapshot.data![index],
                                                                  )))
                                                          .then((value) {
                                                        setState(() {});
                                                      });
                                                    })),
                                            Flexible(
                                              flex: 1,
                                              child: IconButton(
                                                  icon:
                                                  const Icon(Icons.delete),
                                                  onPressed: () {
                                                    showAlertDialog(
                                                        context,
                                                        snapshot
                                                            .data![index].id!);
                                                  }),
                                            ),
                                          ],
                                        ),
                                      )),
                                );
                              });
                        } else {
                          return const Text("Tidak ada data");
                        }
                      }
                    })),
          ]),
        ),
        floatingActionButton: FloatingActionButton(
            foregroundColor: Colors.black,
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return const CreateScreen();
              }));
            },
            child: const Icon(Icons.add)));
  }
}

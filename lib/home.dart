import 'package:flutter/material.dart';
import './components/indonesia.dart';
import './components/world.dart';
import 'package:provider/provider.dart';
import './providers/corona_provider.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height; //Kita ambil ukuran layar

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.pinkAccent,
        title: const Text('Lawan Covid-19'),
      ),
      // penerapan refresh indicator agar ketika layar ditarik kebawah, akan otomatis refresh
      body: RefreshIndicator(
        // menggunakan attributenya yaitu onfresh
        // dan akan mengambil fungsi getdata yang sudah dibuat pada corona_provider
        onRefresh: () =>
            Provider.of<CoronaProvider>(context, listen: false).getData(),
        child: Container(
          margin: const EdgeInsets.all(10),
          // ketika apps dibuka, maka fungsi future builder akan dijalankan
          child: FutureBuilder(
            future:
                Provider.of<CoronaProvider>(context, listen: false).getData(),
            builder: (context, snapshot) {
              // jika masih loading
              if (snapshot.connectionState == ConnectionState.waiting) {
                // maka tampilkan loading indikator
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
              //SELAIN ITU MAKA AKAN KITA TAMPILKAN WIDGET UNTUK DATA
              //KITA GUNAKAN CONSUMER UNTUK MENGAMBIL DATA DARI CORONA PROVIDER
              return Consumer<CoronaProvider>(
                builder: (context, data, _) {
                  // dima ada dua buah column
                  return Column(
                    children: <Widget>[
                      // yang pertama adalah data indonesia yang widgetnya kita pisahkan sendiri
                      Flexible(
                        flex: 1,
                        child: Indonesia(
                          height: height,
                          data: data,
                        ),
                      ),
                      // dan yang kedua adalah widget untuk menampilkan data dunia dengan cara yang sama
                      Flexible(
                        flex: 1,
                        child: World(
                          height: height,
                          data: data,
                        ),
                      )
                    ],
                  );
                },
              );
            },
          ),
        ),
      ),
    );
  }
}

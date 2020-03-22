import 'package:flutter/material.dart';
import '../widgets/summary_card.dart';

class Indonesia extends StatelessWidget {
  final double height;
  final data;

  // terima data dari component indonesia di home.dart
  Indonesia({this.height, this.data});

  @override
  Widget build(BuildContext context) {
    // pisahkan lagi menjadi dua kolom
    return Column(
      children: <Widget>[
        // bagian pertama adalah headingnya
        Padding(
          padding: const EdgeInsets.only(top: 10.0, bottom: 5.0),
          child: const Text(
            'Laporan Jumlah Kasus Di Indonesia',
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),
        ),

        Divider(),
        // bagian ini adalah masing-masing datanya
        Expanded(
          flex: 2,
          child: GridView.count(
            childAspectRatio: height / 350,
            crossAxisCount: 2,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
            children: <Widget>[
              SummaryCard(
                total: data.summary.confirmed.toString(),
                label: 'Terkonfirmasi',
                color: Colors.yellowAccent[100],
                size: 35,
              ),
              SummaryCard(
                total: data.summary.activeCare.toString(),
                label: 'Dalam Perawatan',
                color: Colors.purple[100],
                size: 35,
              ),
              SummaryCard(
                total: data.summary.recovered.toString(),
                label: 'Sembuh',
                color: Colors.greenAccent[100],
                size: 35,
              ),
              SummaryCard(
                total: data.summary.deaths.toString(),
                label: 'Menginggal',
                color: Colors.red[100],
                size: 35,
              ),
            ],
          ),
        ),
      ],
    );
  }
}

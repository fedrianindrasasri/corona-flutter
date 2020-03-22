import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import './indonesia_model.dart';
import './world_model.dart';

class CoronaProvider with ChangeNotifier {
  IndonesiaModel summary; //State untuk menampung data di indonesia
  WorldModel world; //state untuk menampung data dunia
  String updated; //state untuk menampung waktu pembaharuan

  //fungsi ini akan menjalankan api call untuk mengambil data
  Future<void> getData() async {
    // bagian ini akan mengambil data dari indoensia
    final url = 'https://kawalcovid19.harippe.id/api/summary';
    final response = await http.get(url);
    // convert data yang diterima
    final result = json.decode(response.body) as Map<String, dynamic>;
    // lalu masukkan kedalam state summart dengan format berdasarkan indonesimodel
    summary = IndonesiaModel(
      confirmed: result['confirmed']['value'],
      recovered: result['recovered']['value'],
      deaths: result['deaths']['value'],
      activeCare: result['activeCare']['value'],
    );

    // simpan data pembaharuan kedalam state updated
    updated = result['metadata']['lastUpdatedAt'];

    final worldPositive = 'https://api.kawalcorona.com/positif/';
    final responsePositive = await http.get(worldPositive);
    final resultPositive = json.decode(responsePositive.body);

    final worldRecovered = 'https://api.kawalcorona.com/sembuh/';
    final responseRecovered = await http.get(worldRecovered);
    final resultRecovered = json.decode(responseRecovered.body);

    final worldDeaths = 'https://api.kawalcorona.com/meninggal/';
    final responseDeaths = await http.get(worldDeaths);
    final resultDeaths = json.decode(responseDeaths.body);

    world = WorldModel(
      confirmed: resultPositive['value'],
      deaths: resultRecovered['value'],
      recovered: resultDeaths['value'],
    );
    notifyListeners(); //INFORMASIKAN BAHWA TERJADI PERUBAHAN STATE AGAR WIDGET DIRENDER ULANG
  }
}

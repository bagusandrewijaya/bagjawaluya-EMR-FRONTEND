import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:sibagjaapps/models/M_DetailsPsikiatri.dart';

import '../apiservices/S_PKP_API_Service.dart';

class ProviderPKP extends ChangeNotifier {
  APIPKP _service = APIPKP();
  DateTime _selectedYMD = DateTime.now();
  DateTime _selectedTime = DateTime.now();
  TextEditingController PJ = TextEditingController();
  TextEditingController Sejak = TextEditingController();

  TextEditingController Faktor = TextEditingController();
  TextEditingController HalusanisasiDengar = TextEditingController();
  TextEditingController HalusanisasiLihat = TextEditingController();
  TextEditingController Waham = TextEditingController();
  TextEditingController Curiga = TextEditingController();
  TextEditingController Lainnya = TextEditingController();
  TextEditingController TD = TextEditingController();
  TextEditingController nadi = TextEditingController();
  TextEditingController Suhu = TextEditingController();
  TextEditingController Pernafasan = TextEditingController();
  TextEditingController LainLain = TextEditingController();
  TextEditingController gafskor = TextEditingController();
  Map<String, bool> _checkboxValues = {
    'Tangan diikat': false,
    'Ekspresi muka tegang': false,
    'Kontak verbal inkoherent': false,
    'Murung': false,
    'Sedih': false,
    'Cemas': false,
    'Perilaku tak wajar': false,
  };
  Map<String, bool> _checkGejala = {
    "tidak bisa tidur": false,
    "marah marah": false,
    "Mudah Tersinggung": false,
    "Impulsif": false,
    "Merusak Alat-Alat RT": false,
    "Mengancam": false,
    "Mengganggu Lingkungan": false,
    "Mengancam Atau Percobaan Melakukan Bunuh Diri": false,
    "Menurung Diri": false,
    "Bicara Terbatas": false,
    "Malas": false,
    "Tidak Mampu Merawat Diri": false,
    "mengumpulkan barang bekas": false,
    "keluyuran": false,
    "tertawa sendiri": false,
    "makan berlebih": false,
    "makan kurang nafsu": false,
    "orientasi WTO terganggu": false,
  };
  Map<String, TextEditingController> controllers = {
    "tkd": TextEditingController(),
    "penampilan": TextEditingController(),
    "kesadaran": TextEditingController(),
    "prilaku": TextEditingController(),
    "pembicaraan": TextEditingController(),
    "sikap": TextEditingController(),
    "afek": TextEditingController(),
    "ekspresi-afektif": TextEditingController(),
    "keserasian": TextEditingController(),
    "empati": TextEditingController(),
    "pendidikan": TextEditingController(),
    "konsentrasi": TextEditingController(),
    "orientasi": TextEditingController(),
    "daya-ingat": TextEditingController(),
    "bakat-kreatif": TextEditingController(),
    "pikiran-abstrak": TextEditingController(),
    "kemampuan-menolong-diri-sendiri": TextEditingController(),
    "halusinasi-dan-ilusi": TextEditingController(),
    "depersonalisasi-dan-derealisasi": TextEditingController(),
    "arus-pikir": TextEditingController(),
    "isi-pikir": TextEditingController(),
    "pengendali-impuls": TextEditingController(),
    "daya-nilai": TextEditingController(),
    "persepsi": TextEditingController(),
    "insight": TextEditingController(),
    "taraf-dipercaya": TextEditingController(),
  };

Map<String, TextEditingController> controllersiii={
'keadaan-umum' : TextEditingController(),
'bentuk-badan' : TextEditingController(),
'gangguan-khusus' : TextEditingController(),
'urat-syaraf' : TextEditingController(),
'motorik':TextEditingController(),
'sesabilitas' : TextEditingController(),
'susunan-syaraf-vegetatif': TextEditingController(),
'fungsi-luhur' : TextEditingController(),
'gangguan-khusus2' : TextEditingController(),
'wawancara-psikiatri-tambahan':TextEditingController(),
'wawancara-dengan-anggota-keluarga' : TextEditingController(),
'evaluasi-sosial' : TextEditingController(),
'test-psikologi' : TextEditingController(),
'pemeriksaan-lainnya': TextEditingController(),
'aksis-I' : TextEditingController(),
'aksis-II':TextEditingController(),
'aksis-III':TextEditingController(),
'aksis-IV':TextEditingController(),
'aksis-V':TextEditingController()
};

  Map<String, bool> get checkGejala => _checkGejala;
  DateTime get selectedYMD => _selectedYMD;
  DateTime get selectedTime => _selectedTime;
  String? id;
  Map<String, bool> get checkboxValues => _checkboxValues;
  List<MDetailsPsikiatri> _data = [];
  ProviderPKP(idforms) {
    id = idforms;
    notifyListeners();
    print(id);
    if (id != '-') {
      fetch();
    }
  }

 void fetch() async {
  _data = await _service.FetchDataDetails(id.toString());
  notifyListeners();

  _checkboxValues = {
    'Tangan diikat': _data[0].tanganDiikat == "1",
    'Ekspresi muka tegang': _data[0].ekspresiMukaTegang == "1",
    'Kontak verbal inkoherent': _data[0].kontakVerbalInkoherent == "1",
    'Murung': _data[0].murung == "1",
    'Sedih': _data[0].sedih == "1",
    'Cemas': _data[0].cemas == "1",
    'Perilaku tak wajar': _data[0].perilakuTakWajar == "1",
  };

  // Pastikan untuk mengecek null sebelum mengakses _data[0]
 
    Map<String, bool> _tmp =
        Map<String, bool>.from(jsonDecode(_data[0].gejala!));
        
           
     Map<String, String> statusMentalMap = Map<String, String>.from(jsonDecode(_data[0].statusMental.toString()));

      Map<String, String> pemeriksaanLanjutanMap = Map<String, String>.from( jsonDecode(_data[0].pemeriksaanLanjutan.toString()));
 _selectedYMD = DateTime.parse(_data[0].tglMasuk.toString());
 _selectedTime = DateTime.parse(_data[0].jamMasuk.toString());
   PJ = TextEditingController(text: _data[0].dibawaOleh);
   Sejak = TextEditingController(text: _data[0].tglDibawa);
   Faktor = TextEditingController(text:  _data[0].faktor);
   HalusanisasiDengar = TextEditingController(text:  _data[0].halusinasiDengar);
   HalusanisasiLihat = TextEditingController(text:  _data[0].halusinasiLihat);
   Waham = TextEditingController(text:  _data[0].wahan);
   Curiga = TextEditingController(text:  _data[0].curiga);
   Lainnya = TextEditingController(text:  _data[0].keadaanLain);
   TD = TextEditingController(text:  _data[0].tekananDarah);
   nadi = TextEditingController(text:  _data[0].nadi);
   Suhu = TextEditingController(text:  _data[0].suhu);
   Pernafasan = TextEditingController(text:  _data[0].pernafasan);
   LainLain = TextEditingController(text:  _data[0].pemeriksaanLain);
   gafskor = TextEditingController(text: _data[0].gaf_skor);
  statusMentalMap.forEach((key, value) {
    if (controllers.containsKey(key)) {
      controllers[key]!.text = value;
    }
  });
  pemeriksaanLanjutanMap.forEach((key, value) {
    if (controllersiii.containsKey(key)) {
      controllersiii[key]!.text = value;
    }
  });
   if (_data.isNotEmpty) {
    _checkboxValues.forEach((key, value) {
      _checkboxValues[key] ??= false;
    });
  }
    _checkGejala = _tmp;
  notifyListeners();
  print(_checkboxValues);
}

  void ChangeDate(time) {
    _selectedYMD = time;
    notifyListeners();
  }

  List<String> get selectedItems {
    List<String> selected = [];
    _checkGejala.forEach((key, value) {
      if (value) {
        selected.add(key);
      }
    });
    return selected;
  }

  void changedItem2(String key, bool? value) {
    _checkGejala[key] = value ?? false; // Jika value null, atur ke false

    // Jika item sudah ada dalam daftar selectedItems, hapus item tersebut
    if (selectedItems.contains(key)) {
      selectedItems.remove(key);
    } else {
      // Jika item belum ada dalam daftar selectedItems, tambahkan item tersebut
      selectedItems.add(key);
    }
    print(_checkGejala.toString());
    notifyListeners();
  }

  void ChangeTime(time) {
    _selectedTime = time;
    notifyListeners();
  }

  void changedItem(String key, bool? value) {
    _checkboxValues[key] = value!;
    notifyListeners();
  }

  void tapped(Norekam, gejala,pemeriksaanlanjutaniii, context) {
    if (id == '-') {
      postData(Norekam, gejala,pemeriksaanlanjutaniii, context);
    } else {
     PutDat(Norekam, gejala,pemeriksaanlanjutaniii, context);
    }
  }
void PutDat(Norekam, gejala, pemeriksaanlanjutaniii,context) async{

  _service.PutPKP(
     _selectedYMD.toString(),
      _selectedTime.toString(),
        PJ.text,
        Sejak.text,
        json.encode(_checkGejala),
        Faktor.text.isEmpty ? "-" : Faktor.text,
        _checkboxValues['Tangan diikat'],
        _checkboxValues['Ekspresi muka tegang'],
        _checkboxValues['Kontak verbal inkoherent'],
        _checkboxValues['Murung'],
        _checkboxValues['Sedih'],
        _checkboxValues['Cemas'],
        _checkboxValues['Perilaku tak wajar'],
        HalusanisasiDengar.text.isEmpty ? "-" : HalusanisasiDengar.text,
        HalusanisasiLihat.text.isEmpty ? "-" : HalusanisasiLihat.text,
        Waham.text.isEmpty ? "-" : Waham.text,
        Curiga.text.isEmpty ? "-" : Curiga.text,
        Lainnya.text.isEmpty ? "-" : Lainnya.text,
        TD.text.isEmpty ? "-" : TD.text,
        nadi.text.isEmpty ? "-" : nadi.text,
        Suhu.text.isEmpty ? "-" : Suhu.text,
        Pernafasan.text.isEmpty ? "-" : Pernafasan.text,
        LainLain.text.isEmpty ? "-" : LainLain.text,
        jsonEncode(gejala),
        id.toString(),
        context,
        pemeriksaanlanjutaniii,
        gafskor.text.isEmpty ? "-" :  gafskor.text 
        );
}
  void postData(Norekam, gejala,pemeriksaanlanjutaniii, context) async {
      String jsonString = jsonEncode(pemeriksaanlanjutaniii);
    await _service.PostPKP(
        _selectedYMD.toString(),
        _selectedTime.toString(),
        PJ.text,
        Sejak.text,
        json.encode(_checkGejala),
        Faktor.text.isEmpty ? "-" : Faktor.text,
        _checkboxValues['Tangan diikat'],
        _checkboxValues['Ekspresi muka tegang'],
        _checkboxValues['Kontak verbal inkoherent'],
        _checkboxValues['Murung'],
        _checkboxValues['Sedih'],
        _checkboxValues['Cemas'],
        _checkboxValues['Perilaku tak wajar'],
        HalusanisasiDengar.text.isEmpty ? "-" : HalusanisasiDengar.text,
        HalusanisasiLihat.text.isEmpty ? "-" : HalusanisasiLihat.text,
        Waham.text.isEmpty ? "-" : Waham.text,
        Curiga.text.isEmpty ? "-" : Curiga.text,
        Lainnya.text.isEmpty ? "-" : Lainnya.text,
        TD.text.isEmpty ? "-" : TD.text,
        nadi.text.isEmpty ? "-" : nadi.text,
        Suhu.text.isEmpty ? "-" : Suhu.text,
        Pernafasan.text.isEmpty ? "-" : Pernafasan.text,
        LainLain.text.isEmpty ? "-" : LainLain.text,
        Norekam.toString(),
        "Bagus Andre Wijaya",
        jsonEncode(gejala),
        context,
        jsonEncode(pemeriksaanlanjutaniii),
      gafskor.text.isEmpty ? "-" :  gafskor.text 
        );
  }
}

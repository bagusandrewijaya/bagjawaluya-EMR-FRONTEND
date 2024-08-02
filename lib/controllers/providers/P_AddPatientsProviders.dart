import 'dart:async';
import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:sibagjaapps/controllers/apiservices/S_AddPatientsApiService.dart';
import 'package:sibagjaapps/controllers/apiservices/S_DetailsPatients.dart';
import 'package:sibagjaapps/models/M_detailsPatients.dart';
import 'package:toastification/toastification.dart';

class AddPatientsProviders extends ChangeNotifier {
  ApiDetailsPatients _service2 = ApiDetailsPatients();
  List<DetailsPatients> _dataz = [];
  AddPatientsApiService _service = AddPatientsApiService();
  TextEditingController _name = TextEditingController();
  TextEditingController _alamat = TextEditingController();
  TextEditingController _alamatk = TextEditingController();
  TextEditingController _RiwayatMedis = TextEditingController();
  TextEditingController _namayah = TextEditingController();
  TextEditingController _namaibu = TextEditingController();
  TextEditingController _ktp = TextEditingController();
  TextEditingController _kontak = TextEditingController();
  TextEditingController _penjamin = TextEditingController();
  TextEditingController _saldoawal = TextEditingController();
  TextEditingController _dateController = TextEditingController();
  TextEditingController _pekerjaan = TextEditingController();
  TextEditingController _pekerjaank = TextEditingController();
  TextEditingController _agama = TextEditingController();
  TextEditingController _tanggalmasuk = TextEditingController();
  TextEditingController _suku = TextEditingController();
  TextEditingController _pendidikan = TextEditingController();
  TextEditingController _hubungan = TextEditingController();
  String _selectedGender = 'Laki-Laki';
  String get selectedGender => _selectedGender;
  String jk = 'L';
  String NoRM = '-';
  bool isLoading = false;
  TextEditingController get nama => _name;
  TextEditingController get namayah => _namayah;
  TextEditingController get namaibu => _namaibu;
  TextEditingController get alamat => _alamat;
  TextEditingController get alamatk => _alamatk;
  TextEditingController get kontak => _kontak;
  TextEditingController get ktp => _ktp;
  TextEditingController get dateController => _dateController;
  TextEditingController get riwayatMedis => _RiwayatMedis;
  TextEditingController get penjamin => _penjamin;
  TextEditingController get saldoawal => _saldoawal;
  TextEditingController get pekerjaan => _pekerjaan;
  TextEditingController get pekerjaank => _pekerjaank;
  TextEditingController get agama => _agama;
  TextEditingController get tanggalmasuk => _tanggalmasuk;
  TextEditingController get suku => _suku;
  TextEditingController get pendidikan => _pendidikan;
  TextEditingController get hubungan => _hubungan;
  Color _avatarColor = Colors.grey;
  Map<String, TextEditingController> controllers = {
    'keluhan-utama-dan-alasan-terapi': TextEditingController(),
    'riwayat-gangguan-sebelumnya': TextEditingController(),
    'riwayat-gangguan-sekarang': TextEditingController(),
    'psikologi': TextEditingController(),
    'riwayat-keluarga': TextEditingController(),
    'kondisi-saat-ini': TextEditingController()
  };

  Color get avatarColor => _avatarColor;

  void updateAvatarColor() {
    // Ambil nama dari controller
    String firstName = _name.text;
    // Ubah nama depan menjadi kode ASCII
    int hashCode = firstName.runes.fold(0, (prev, code) => prev + code);
    // Gunakan kode ASCII untuk menentukan komponen warna (RGB)
    Random random = Random(hashCode);
    int red = random.nextInt(256);
    int green = random.nextInt(256);
    int blue = random.nextInt(256);
    // Tetapkan warna yang dihasilkan ke _avatarColor
    _avatarColor = Color.fromARGB(255, red, green, blue);
    notifyListeners();
  }

  AddPatientsProviders(nrm) {

    NoRM = nrm;
    fetchdata();
    notifyListeners();
  }

  fetchdata() async {
    isLoading = true;
    notifyListeners();
    if (NoRM != '-') {
      _dataz = await _service2.FetchDataDetails(NoRM);
      var i = _dataz[0];

      if(i.jenisKelamin == "L"){
        _selectedGender = "Laki-Laki";
        jk = 'L';
        notifyListeners();
      }else{
          _selectedGender = "Perempuan";
          jk = "P";
           notifyListeners();
      }
      _name = TextEditingController(text: i.namaPasien);
      _alamat = TextEditingController(text: i.alamat);
      _alamatk = TextEditingController(text: i.alamatKeluarga);
      _RiwayatMedis = TextEditingController(text: i.riwayatMedis);
      _namayah = TextEditingController(text: i.namaayah);
      _namaibu = TextEditingController(text: i.namaibu);
      _ktp = TextEditingController(text: i.ktp);
      _kontak = TextEditingController(text: i.kontak);
      _dateController = TextEditingController(text: i.tanggalLahir);
      _pekerjaan = TextEditingController(text: i.pekerjaan);
      _pekerjaank = TextEditingController(text: i.pekerjaanKeluarga);
      _agama = TextEditingController(text: i.agama);
      _tanggalmasuk = TextEditingController(text: i.tglMasuk);
      _suku = TextEditingController(text: i.suku);
      _pendidikan = TextEditingController(text: i.pendidikan);
      _hubungan = TextEditingController(text: i.hubungan);

      Map<String, String> latarbelakangfromdb =
          Map<String, String>.from(jsonDecode(i.latarBelakang.toString()));
      latarbelakangfromdb.forEach((key, value) {
        if (controllers.containsKey(key)) {
          controllers[key]!.text = value;
        }
      });

    }
     isLoading = false;

      notifyListeners();
  }

  Future<void> selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(1900),
        lastDate: DateTime(2100),
        builder: (context, child) {
          return Theme(
              data: Theme.of(context).copyWith(
                // override MaterialApp ThemeData
                colorScheme: ColorScheme.light(
                  primary: const Color.fromARGB(255, 76, 130,
                      175), //header and selced day background color
                  onPrimary: Colors.white, // titles and
                  onSurface: Colors.black, // Month days , years
                ),
                textButtonTheme: TextButtonThemeData(
                  style: TextButton.styleFrom(
                    primary: Colors.black, // ok , cancel    buttons
                  ),
                ),
              ),
              child: child!);
        });
    if (picked != null && picked != DateTime.now()) {
      _dateController.text = "${picked.toLocal()}".split(' ')[0];
      notifyListeners();
    }
  }

  Future<void> selectDate2(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(1900),
        lastDate: DateTime(2100),
        builder: (context, child) {
          return Theme(
              data: Theme.of(context).copyWith(
                // override MaterialApp ThemeData
                colorScheme: ColorScheme.light(
                  primary: const Color.fromARGB(255, 76, 130,
                      175), //header and selced day background color
                  onPrimary: Colors.white, // titles and
                  onSurface: Colors.black, // Month days , years
                ),
                textButtonTheme: TextButtonThemeData(
                  style: TextButton.styleFrom(
                    primary: Colors.black, // ok , cancel    buttons
                  ),
                ),
              ),
              child: child!);
        });
    if (picked != null && picked != DateTime.now()) {
      _tanggalmasuk.text = "${picked.toLocal()}".split(' ')[0];
      print("${picked.toLocal()}".split(' ')[0]);
      notifyListeners();
    }
  }

  void notifyUpdate() {
    notifyListeners();
  }

  void changevalueGender(stringvalue) {
    _selectedGender = stringvalue;
    if (stringvalue == 'Laki-Laki') {
      jk = 'L';
      notifyListeners();
    } else {
      jk = 'P';
      notifyListeners();
    }
  }

  void PostPatient(context) async {
     isLoading = true;
    notifyListeners();
      if (_name.text.isEmpty ||
          _alamat.text.isEmpty ||
          _alamatk.text.isEmpty ||
          _RiwayatMedis.text.isEmpty ||
          _namayah.text.isEmpty ||
          _kontak.text.isEmpty ||
          _dateController.text.isEmpty) {
        toastification.show(
          type: ToastificationType.warning,
          style: ToastificationStyle.flat,
          context: context, // optional if you use ToastificationWrapper
          title: Text('lengkapi datanya'),
          autoCloseDuration: const Duration(seconds: 5),
        );
      }
      Map<String, String> dataMentalStatus = {};
      controllers.forEach((key, controller) {
        dataMentalStatus[key] = controller.text;
        notifyListeners();
      });

      print(jsonEncode(jsonEncode(dataMentalStatus)));
      print("${NoRM}");
      if (NoRM == '-') {
        _service.postPatients(
            _name.text,
            jk,
            _alamat.text,
            _RiwayatMedis.text,
            _dateController.text,
            _namayah.text,
            _kontak.text,
            _alamatk.text,
            '00',
            '00',
            context,
            _namaibu.text,
            _ktp.text,
            _pekerjaan.text,
            _agama.text,
            _pekerjaank.text,
            jsonEncode(jsonEncode(dataMentalStatus)),
            tanggalmasuk.text,
            suku.text,
            pendidikan.text,
            hubungan.text);
                Future.delayed(Duration(seconds: 2)).then((value) {
                    isLoading = false;
                      notifyListeners();
                },);
  
      } else {
        _service.putPatients(
            nama: _name.text,
            jk: jk,
            alamat: _alamat.text,
            RwayatM: _RiwayatMedis.text,
            tgllhir: _dateController.text,
            namaK: _namayah.text,
            kontak: _kontak.text,
            alamatK: _alamatk.text,
            context: context,
            namaibu: _namaibu.text,
            ktp: _ktp.text,
            pekerjaan: _pekerjaan.text,
            agama: _agama.text,
            pekerjaank: _pekerjaank.text,
            latarBelakang: jsonEncode(jsonEncode(dataMentalStatus)),
            tanggalmasuk: tanggalmasuk.text,
            suku: suku.text,
            pendidikan: pendidikan.text,
            hubungan: _hubungan.text,
            rm: NoRM);

            print("${NoRM}");
      
    Future.delayed(Duration(seconds: 2)).then((value) {
                    isLoading = false;
                      notifyListeners();
                },);
  
    }
  }
}

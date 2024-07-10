import 'package:fluent_ui/fluent_ui.dart' as ft;
import 'package:flutter/material.dart';
import 'package:sibagjaapps/controllers/apiservices/S_APIFetchUsers.dart';
import '../../models/M_Pengguna.dart';

class ProviderPengguna extends ChangeNotifier {
  List<M_Pengguna> _allData = []; // Store all data
  List<M_Pengguna> filteredData = []; // Filtered data to be displayed
  String idUsers ='';
  String selectedDropdown = '--';
  
  String selectedDropdownForInsert = '--';
  TextEditingController finderbyname = TextEditingController();
  List<String> dropdown = ['--','Administrator', 'Keperawatan', 'Pelayanan'];
  APIPengguna _service = APIPengguna();
bool isloading = false;

//DISNI CONTROLLER TEXTNYA
TextEditingController namaLkp = TextEditingController();
TextEditingController username = TextEditingController();
TextEditingController notlpn = TextEditingController();
TextEditingController alamat = TextEditingController();
TextEditingController password = TextEditingController();
TextEditingController retypePasswd =  TextEditingController();

  ProviderPengguna(){
    FetchData();
    finderbyname.addListener(_applyFilter);
  }

  void changeDropdown(String idxDrop) {
    selectedDropdown = idxDrop;
    _applyFilter();
    notifyListeners();
  }

  void selectedUserId(String idxUsers) {
    idUsers = idxUsers;
    notifyListeners();
  }

  void FetchData() async {
    filteredData.clear();
    notifyListeners();
    _allData = await _service.FetchDataUsers();
    _applyFilter(); // Apply initial filter
    notifyListeners();
  }

  void _applyFilter() {
    filteredData = _allData.where((user) {
      bool matchesDescription = selectedDropdown == '--' || 
        user.deskripsi?.toLowerCase() == selectedDropdown.toLowerCase();
      
      bool matchesName = finderbyname.text.isEmpty ||
        user.nama?.toLowerCase().contains(finderbyname.text.toLowerCase()) == true;

      return matchesDescription && matchesName;
    }).toList();

    notifyListeners();
  }

  @override
  void dispose() {
    finderbyname.removeListener(_applyFilter);
    finderbyname.dispose();
    super.dispose();
  }


void Post(context) async {
  String levelValue = '0';
  if (selectedDropdownForInsert == '--' ||
      username.text.isEmpty ||
      password.text.isEmpty) { // Check if any required field is empty
    await ft.displayInfoBar(context, duration: const Duration(seconds: 5),
        builder: (context, close) {
      return ft.InfoBar(
        style: ft.InfoBarThemeData(),
        title: const Text('Maaf :/'),
        content: const Text('Pastikan semua kolom diisi'),
        action: IconButton(
          icon: const Icon(ft.FluentIcons.clear),
          onPressed: close,
        ),
        severity: ft.InfoBarSeverity.error,
      );
    });
  } else if (password.text != retypePasswd.text) { // Check if password and retype password do not match
    await ft.displayInfoBar(context, duration: const Duration(seconds: 5),
        builder: (context, close) {
      return ft.InfoBar(
        style: ft.InfoBarThemeData(),
        title: const Text('Maaf :/'),
        content: const Text('Password dan konfirmasi password tidak sesuai'),
        action: IconButton(
          icon: const Icon(ft.FluentIcons.clear),
          onPressed: close,
        ),
        severity: ft.InfoBarSeverity.error,
      );
    });
  } else {
    if (selectedDropdownForInsert.toLowerCase() == 'administrator') {
      levelValue = '1';
    } else if (selectedDropdownForInsert.toLowerCase() == 'keperawatan') {
      levelValue = '2';
    } else if (selectedDropdownForInsert.toLowerCase() == 'pelayanan') {
      levelValue = '3';
    }

    if (levelValue == '0') {
      await ft.displayInfoBar(context, duration: const Duration(seconds: 5),
          builder: (context, close) {
        return ft.InfoBar(
          style: ft.InfoBarThemeData(),
          title: const Text('Maaf :/'),
          content: const Text('Level Tidak Valid'),
          action: IconButton(
            icon: const Icon(ft.FluentIcons.clear),
            onPressed: close,
          ),
          severity: ft.InfoBarSeverity.error,
        );
      });
    } else {
      int i = await _service.createUser(
        username: username.text,
        password: password.text,
        level: levelValue,
        nama: namaLkp.text,
        notlpn: notlpn.text,
        alamat: alamat.text,
      );

      if (i == 201) {
        await ft.displayInfoBar(context, duration: const Duration(seconds: 5),
            builder: (context, close) {
          return ft.InfoBar(
            style: ft.InfoBarThemeData(),
            title: const Text('Berhasil :)'),
            content: const Text('User Baru Telah Ditambahkan'),
            action: IconButton(
              icon: const Icon(ft.FluentIcons.clear),
              onPressed: close,
            ),
            severity: ft.InfoBarSeverity.success,
          );
        });
       
        username.clear();
        password.clear();
        namaLkp.clear();
        notlpn.clear();
        alamat.clear();
         FetchData();
        Navigator.pop(context);
      }
    }
  }
}


  void changelevelpengguna(lvl) {
    selectedDropdownForInsert = lvl;
    print("${lvl}");
    notifyListeners();
  }
}
import 'dart:convert';

import 'package:fluent_ui/fluent_ui.dart';
import 'package:sibagjaapps/controllers/apiservices/S_catatanDokter.dart';
import 'package:sibagjaapps/models/M_TableCtd.dart';
import 'package:sibagjaapps/utils/classLogerInit.dart';

class CatatanDokterNotifier extends ChangeNotifier {
  APICTDService _service = APICTDService();
  Map<String, TableRowData> _tableRowsMap = {};
  Map<String, TableRowData> get tableRowsMap => _tableRowsMap;
  int _idCounter = 0;
  List<Map<String, dynamic>> tmptable = [];
  String? idForms;
  CatatanDokterNotifier(idz){
    print(idz);
    if ( idz != '-') {
      idForms = idz;
      notifyListeners();
      print(idForms);
      loadFromtmp(idForms);
    }
    
  }

void loadFromtmp(idctd) async {
  tmptable = await _service.getCatatanByID(idctd);

  notifyListeners();
  for (var item in tmptable) {
    final idz =  (_idCounter++).toString();  // Use API ID if available
    _tableRowsMap[idz] = TableRowData(
      id: idz,
     
      tanggal: item['tanggal'] ?? '',
      pesan: item['pesan'] ?? '',
      obat: item['obat'] ?? '',
    );
  }

  notifyListeners();
}

void removeTableRow(String idz, context) async {
  if (idz.isNotEmpty) {  // Check if idz is not empty
    showDialog<String>(
      context: context,
      builder: (context) => ContentDialog(
        title: const Text('Hapus Permanen'),
        content: Text(
          'Jika Kamu Menghapus Data Tidak Dapat Pulihkan Kembali ',
        ),
        actions: [
          Button(
            child: const Text('Hapus'),
            onPressed: () async {
              _tableRowsMap.remove(idz);
              List<dynamic> dynamicArray = _tableRowsMap.values.map((data) => {  // Include API ID if available
                'tanggal': data.tanggal,
                'pesan': data.pesan,
                'obat': data.obat,
              }).toList();
         
              await _service.putCTD(idForms, "bagus andre w", jsonEncode(jsonEncode(dynamicArray)).toString(), context);
              Navigator.pop(context, 'User deleted file');
              notifyListeners();
            },
          ),
          FilledButton(
            child: const Text('Batal'),
            onPressed: () => Navigator.pop(context, 'User canceled dialog'),
          ),
        ],
      ),
    );
  } else {
    print('Invalid ID: $idz');
  }
}


  void addTableRow(String tanggal, String pesan, String obat,rm,ctx)async {
    final idz = (_idCounter++).toString();
    _tableRowsMap[idz] = TableRowData(
      id: idz,
      tanggal: tanggal,
      pesan: pesan,
      obat: obat,
    );
  List<dynamic> dynamicArray = _tableRowsMap.values.map((data) => {
    'tanggal': data.tanggal,
    'pesan': data.pesan,
    'obat': data.obat,
  }).toList();
notifyListeners();
  if (idForms == null || idForms == '') {
   

  idForms = await _service.PostCTD(rm,"bagus andre w",jsonEncode(jsonEncode(dynamicArray)).toString(),ctx);
  notifyListeners();
  print(dynamicArray);
  }else{

 await _service.putCTD(idForms,"bagus andre w",jsonEncode(jsonEncode(dynamicArray)).toString(),ctx);

  }
    notifyListeners();
  }
}
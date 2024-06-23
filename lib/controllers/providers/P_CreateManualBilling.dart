import 'package:flutter/material.dart';
import 'package:sibagjaapps/controllers/apiservices/S_CreateManualBilling.dart';
import 'package:uuid/uuid.dart';

class CreateManualBilling extends ChangeNotifier {
  APICreateManualBilling _service = APICreateManualBilling();
  TextEditingController namaLayanan = TextEditingController();
  TextEditingController hargaLayanan = TextEditingController();
  TextEditingController totalBulanan = TextEditingController();
  TextEditingController totalObat = TextEditingController();
  TextEditingController totalBiayaDiluar = TextEditingController();
  List<Map<String, dynamic>> listdata = [];
  String parentuid = '';
  int total = 0; 
  int totalbiaya =0;
  var uuid = Uuid();

  CreateManualBilling() {
    parentuid = uuid.v4();
    notifyListeners();
  }

  void updateTotal() {
  
    if (totalBiayaDiluar.text.isNotEmpty) {
      total = int.tryParse(totalBiayaDiluar.text.replaceAll('RP. ', '').replaceAll('.', ''),)!;
    } else if (listdata.isNotEmpty) {
       total = listdata.fold(0, (sum, item) => sum + int.parse(item['harga']));
    }else{
      total = 0;
    }
   print("totalnya ${total}");
    
    notifyListeners();
  }

  void TambahData(BuildContext context) {
    if (namaLayanan.text.isEmpty || hargaLayanan.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Nama layanan dan harga harus diisi!'),
          duration: Duration(seconds: 2),
        ),
      );
    } else {
      Map<String, dynamic> data = {
        'idTagihanFK': parentuid,
        'namaLayanan': namaLayanan.text,
        'harga': hargaLayanan.text.replaceAll('RP. ', '').replaceAll('.', ''),
        'idKEY': uuid.v4()
      };

      listdata.add(data);
      updateTotal(); // Memperbarui total setelah menambah data
      
      print(listdata);
      namaLayanan.clear();
      hargaLayanan.clear();
     notifyUpdate();
    }
  }

  void clearvar(){

      totalBiayaDiluar.clear();
      listdata.clear();
      notifyUpdate();
  }
  void notifyUpdate() {
 

    updateTotal();
       totalbiaya = total + int.parse(totalObat.text.replaceAll('RP. ', '').replaceAll('.', '')) + int.parse(totalBulanan.text.replaceAll('RP. ', '').replaceAll('.', ''));
    notifyListeners();
  }
  void removeItemByIdKey(String idKey) {
    listdata.removeWhere((item) => item['idKEY'] == idKey);
    updateTotal(); // Memperbarui total setelah menghapus data
    notifyUpdate();
  }
}
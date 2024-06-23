import 'package:fluent_ui/fluent_ui.dart';
import 'package:sibagjaapps/models/M_ListButton.dart';
import 'package:intl/intl.dart';

import '../../models/M_billingList.dart';
import '../apiservices/S_billingHomes.dart';

class ProviderBilling extends ChangeNotifier {
  ApiBillingHomes _service = ApiBillingHomes();
  List<ButtonListKeuangan> _data = [];
  List<ButtonListKeuangan> get data => _data;
  List<MBillingList> _billing = [];
 List<MBillingList> get billing =>_billing;
    DateTime startDate = DateTime.now();
    String tanggalAwal ='';
      String tanggalAkhir ='';
  ProviderBilling() {
    startDate = DateTime.now().subtract(Duration(days: 7));
    DateTime now = DateTime.now();
    tanggalAwal = "${startDate.toString().substring(0, 10)}";
    tanggalAkhir = " ${now.toString().substring(0, 10)}";
   
    FetchData();
  }

  void FetchData() async {
    _data = await _service.FetchDataButton();
    _billing = await _service.FetchDatarequest(tanggalAwal,tanggalAkhir);
    notifyListeners();
  }




void changeDatePicker(String value) {
  final DateFormat formatterYYYYMMDD = DateFormat('yyyy-MM-dd');
  final DateFormat formatterDDMMYYYY = DateFormat('dd/MM/yyyy');
  
  List<String> dates = value.split(' - '); // Memisahkan input berdasarkan " - "
  
  if (dates.length != 2) {
    throw FormatException('Format input tidak valid, harus ada dua tanggal yang dipisahkan oleh " - "');
  }
  
  DateTime startDate, endDate;
  
  // Fungsi untuk mengubah tanggal dari string ke DateTime
  DateTime parseDate(String dateStr) {
    if (dateStr.contains('-')) {
      return formatterYYYYMMDD.parse(dateStr);
    } else if (dateStr.contains('/')) {
      return formatterDDMMYYYY.parse(dateStr);
    } else {
      throw FormatException('Format tanggal tidak dikenali');
    }
  }
  
  // Memparsing tanggal awal dan akhir
  startDate = parseDate(dates[0].trim());
  endDate = parseDate(dates[1].trim());
  
  // Mengonversi tanggal ke format 'yyyy-MM-dd'
   tanggalAwal = formatterYYYYMMDD.format(startDate);
   tanggalAkhir = formatterYYYYMMDD.format(endDate);
  notifyListeners();
  FetchData();
  print('Tanggal awal: $tanggalAwal');
  print('Tanggal akhir: $tanggalAkhir');
}
}

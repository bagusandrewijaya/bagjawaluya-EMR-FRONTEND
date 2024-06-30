import 'package:flutter/foundation.dart';
import 'package:sibagjaapps/controllers/apiservices/S_ReportBilling.dart';
import 'package:sibagjaapps/models/M_bilingReport.dart';
import 'package:intl/intl.dart';
class ProviderReportBilling extends ChangeNotifier {
  ReportBillingService _service = ReportBillingService();
  List<M_BillingReport> _billing = [];
  List<M_BillingReport> get billing => _billing;
  String tanggalAwal ='';
      String tanggalAkhir ='';
      String Norekam = '';
      String status= '';
  ProviderReportBilling() {
      FetchAllBilling();
  }

  FetchAllBilling() async {
    _billing = await _service.fetchReport(
      tanggalAwal: tanggalAwal,
      tanggalAkhir: tanggalAkhir,
      status: status.toString(),
      noRekam: Norekam
    );
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
  FetchAllBilling();
  print('Tanggal awal: $tanggalAwal');
  print('Tanggal akhir: $tanggalAkhir');
}
  
  void clearButton() {
    tanggalAwal = '';
    tanggalAkhir = '';
    Norekam = '';
      FetchAllBilling();
    notifyListeners();
  }

void setname(name){
Norekam = name;
notifyListeners();
}
void setype(name){
status = name;
print("statunys $status");
notifyListeners();
}


}

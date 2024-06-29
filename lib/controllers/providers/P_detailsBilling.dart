import 'package:fluent_ui/fluent_ui.dart';
import 'package:sibagjaapps/controllers/apiservices/S_DetailsBilling.dart';
import 'package:sibagjaapps/controllers/apiservices/S_DetailsPatients.dart';
import 'package:sibagjaapps/models/M_DetailsTagiham.dart';
import 'package:sibagjaapps/models/M_ModelTagihanDiluar.dart';
import 'package:sibagjaapps/models/M_Payments.dart';
import 'package:sibagjaapps/models/M_billingListObat.dart';
import 'package:sibagjaapps/models/M_detailsPatients.dart';
import 'package:toastification/toastification.dart';

class ProvidersDetailsBilling extends ChangeNotifier {
  APIDetailsBilling _service = APIDetailsBilling();
  ApiDetailsPatients ApiPatients = ApiDetailsPatients();
  List<ModelsDetailsTagihan> _data = [];
  List<DetailsPatients> _patients = [];
  List<ModelTagihanDiluar> _tagihan = [];
List<ModelBillingObat> _tagihanObat = [];
List<M_PaymentsBilling> _payments = [];
List<M_PaymentsBilling> get payment => _payments;
  List<DetailsPatients> get patients => _patients;
  List<ModelsDetailsTagihan> get data => _data;
  List<ModelTagihanDiluar> get tagihan => _tagihan;
    List<ModelBillingObat> get tagihanObat => _tagihanObat;
  String idtagihan = '';
  TextEditingController layanan = TextEditingController();
  TextEditingController harga = TextEditingController();
    TextEditingController namaobat = TextEditingController();
  TextEditingController hargaobat = TextEditingController();
  ProvidersDetailsBilling(idtagihanz) {
    idtagihan = idtagihanz;
    FetchData(idtagihan);
    FetchPayment();
    notifyListeners();
  }
FetchPayment()async{

  _payments = await _service.FetchPayments(idBilling: idtagihan);
  print(_payments);
  notifyListeners();
}
  FetchData(idTagihanz) async {
    _data = await _service.FetchBilling(idTagihanz);
    notifyListeners();
    _patients = await ApiPatients.FetchDataDetails(_data[0].noRMFK!);
    notifyListeners();
    _tagihan = await _service.FetchBillingDiluarLayanan(idTagihanz);
    notifyListeners();
    _tagihanObat = await _service.FetchBillingObat(idTagihanz);
    notifyListeners();
  }

  DeleteLayanan(idKey) async {
    int a = await _service.DeletePaketLayanan(idKey);

    if (a == 201) {
      FetchData(idtagihan);
      notifyListeners();
      FetchPayment();
    }

 
  }

    Deleteobat(idKey) async {
    int a = await _service.DeleteObat(idKey);

    if (a == 201) {
      FetchData(idtagihan);
      notifyListeners();
      FetchPayment();
    }

 
  }

     ADDpaketLayanan(idKey,context) async {
      print( idKey);
         int a = await _service.ADDPaketLayanan(
          amount: harga.text.replaceAll('RP. ', '').replaceAll('.', ''), idlayanan: idKey, namaLayanan: layanan.text, context: context);
      if (a == 201) {
      harga.clear();
      layanan.clear();
        FetchData(idtagihan);
        FetchPayment();
        notifyListeners();
           toastification.show(
          type: ToastificationType.success,
          style: ToastificationStyle.flat,
          context: context,
          title: Text('Berhasil'),
          description: Text("paket disimpan"),
          autoCloseDuration: const Duration(seconds: 5),
        );
        Navigator.pop(context);
      }else{
        await displayInfoBar(context, builder: (context, close) {
  return InfoBar(
    title: const Text('Maaf :/'),
    content: const Text(
        'Sepertinya Ada masukan/input yang kurang lengkap'),
    action: IconButton(
      icon: const Icon(FluentIcons.clear),
      onPressed: close,
    ),
    severity: InfoBarSeverity.warning,
  );
});
      }
    }


     ADDPembiayaanObat(idKey,context) async {
      print( idKey);
         int a = await _service.ADDPembiayaanObat(
          amount: hargaobat.text.replaceAll('RP. ', '').replaceAll('.', ''), idlayanan: idKey, namaLayanan: namaobat.text, context: context);
      if (a == 201) {
      hargaobat.clear();
      namaobat.clear();
        FetchData(idtagihan);
        FetchPayment();
        notifyListeners();
           toastification.show(
          type: ToastificationType.success,
          style: ToastificationStyle.flat,
          context: context,
          title: Text('Berhasil'),
          description: Text("paket disimpan"),
          autoCloseDuration: const Duration(seconds: 5),
        );
        Navigator.pop(context);
      }else{
           await displayInfoBar(context, builder: (context, close) {
  return InfoBar(
    title: const Text('Maaf :/'),
    content: const Text(
        'Sepertinya Ada masukan/input yang kurang lengkap'),
    action: IconButton(
      icon: const Icon(FluentIcons.clear),
      onPressed: close,
    ),
    severity: InfoBarSeverity.warning,
  );
});
      }
    }


    
}

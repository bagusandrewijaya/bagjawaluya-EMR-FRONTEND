

import 'package:fluent_ui/fluent_ui.dart';

import 'package:sibagjaapps/controllers/apiservices/S_BillingInformation.dart';
import 'package:sibagjaapps/models/M_BankList.dart';

class BillingSetMasterProvider extends ChangeNotifier {
  
  billingInformationService _service = billingInformationService();
  TextEditingController harga = TextEditingController();
  TextEditingController polatagihan = TextEditingController();
  TextEditingController namabank = TextEditingController();
    TextEditingController norekening = TextEditingController();
    List<M_BankInformation> banklist = [];
    TextEditingController namaakun = TextEditingController();
    BillingSetMasterProvider(){
      FetchMasterBilling();
    }

void FetchMasterBilling()async {
 harga.text = await _service.FetchHargaBulanan();

 polatagihan.text = await _service.FetchTanggalTerbitTagihan();
banklist = await _service.FetchAllBank();

notifyListeners();
}



FunctionAddBank(context) async {
  if (namabank.text.isEmpty || namaakun.text.isEmpty || norekening.text.isEmpty) {
    await displayInfoBar(context, duration: const Duration(seconds: 5),
      builder: (context, close) {
        return InfoBar(
          style: InfoBarThemeData(),
          title: const Text('Error'),
          content: const Text('Nama bank,nama rekening dan nama akun tidak boleh kosong'),
          action: IconButton(
            icon: const Icon(FluentIcons.clear),
            onPressed: close,
          ),
          severity: InfoBarSeverity.error,
        );
      });
  } else {
    int i = await _service.AddBankAccount(
      bankName: namabank.text,
      accountName: namaakun.text,
      bankNumber: norekening.text
    );

    if (i == 201) {
      await displayInfoBar(context, duration: const Duration(seconds: 5),
        builder: (context, close) {
          return InfoBar(
            style: InfoBarThemeData(),
            title: const Text(' :)'),
            content: const Text('Berhasil Menambah Bank Account'),
            action: IconButton(
              icon: const Icon(FluentIcons.clear),
              onPressed: close,
            ),
            severity: InfoBarSeverity.success,
          );
        });
          FetchMasterBilling();
    }
  }
}
}
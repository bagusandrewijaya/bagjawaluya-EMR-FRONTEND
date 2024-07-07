import 'package:fluent_ui/fluent_ui.dart';

import 'package:sibagjaapps/controllers/apiservices/S_BillingInformation.dart';
import 'package:sibagjaapps/models/M_BankList.dart';

class BillingSetMasterProvider extends ChangeNotifier {
  billingInformationService _service = billingInformationService();
  TextEditingController harga = TextEditingController();

  TextEditingController namabank = TextEditingController();
  TextEditingController norekening = TextEditingController();
  List<M_BankInformation> banklist = [];
  List fontSizes = <String>[
    '1',
    '2',
    '3',
    '4',
    '5',
    '6',
    '7',
    '8',
    '9',
    '10',
    '11',
    '12',
    '13',
    '14',
    '15',
    '16',
    '17',
    '18',
    '19',
    '20',
    '21',
    '22',
    '23',
    '24',
    '25',
    '26',
    '27',
    '28',
    '29',
    '30',
  ];
  String _tanggalTerbit = "1";
  String get tanggalTerbit => _tanggalTerbit;
  TextEditingController namaakun = TextEditingController();
  BillingSetMasterProvider() {
    FetchMasterBilling();
  }

  void FetchMasterBilling() async {
    harga.text = await _service.FetchHargaBulanan();

    _tanggalTerbit = await _service.FetchTanggalTerbitTagihan();
    print(_tanggalTerbit);
    banklist = await _service.FetchAllBank();
    notifyListeners();
  }

  changeTanggal(String day) {
    _tanggalTerbit = day;
    notifyListeners();
  }

  FunctionAddBank(context) async {
    if (namabank.text.isEmpty ||
        namaakun.text.isEmpty ||
        norekening.text.isEmpty) {
      await displayInfoBar(context, duration: const Duration(seconds: 5),
          builder: (context, close) {
        return InfoBar(
          style: InfoBarThemeData(),
          title: const Text('Error'),
          content: const Text(
              'Nama bank,nama rekening dan nama akun tidak boleh kosong'),
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
          bankNumber: norekening.text);

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

  FunctionEditMaster(context) async {
    int i = await _service.UpdateBillingMaster(
      biayaharian: harga.text.replaceAll('RP. ', '').replaceAll('.', ''),
      siklusTagihan: tanggalTerbit,
    );

    if (i == 201) {
      await displayInfoBar(context, duration: const Duration(seconds: 5),
          builder: (context, close) {
        return InfoBar(
          style: InfoBarThemeData(),
          title: const Text(' :)'),
          content: const Text('Berhasil merubah billing'),
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


  UpdateStatusBank(id,status,context)async{
    int i = await _service.UpdateStatusBank(idRek: id, status: status);

    if (i == 201) {
      await displayInfoBar(context, duration: const Duration(seconds: 5),
          builder: (context, close) {
        return InfoBar(
          style: InfoBarThemeData(),
          title: const Text(' :)'),
          content: const Text('Berhasil merubah status Bank Account'),
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

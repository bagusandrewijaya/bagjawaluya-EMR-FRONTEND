import 'package:fluent_ui/fluent_ui.dart';
import 'package:sibagjaapps/models/M_ListButton.dart';

import '../../models/M_billingList.dart';
import '../apiservices/S_billingHomes.dart';

class ProviderBilling extends ChangeNotifier {
  ApiBillingHomes _service = ApiBillingHomes();
  List<ButtonListKeuangan> _data = [];
  List<ButtonListKeuangan> get data => _data;
  List<MBillingList> _billing = [];
  List<MBillingList> get billing => _billing;

  ProviderBilling(){
    FetchData();
  }

  void FetchData() async {
    _data = await _service.FetchDataButton();
     _billing = await _service.FetchDatarequest();
    notifyListeners();
  }
}

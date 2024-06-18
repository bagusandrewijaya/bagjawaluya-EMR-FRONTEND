import 'package:fluent_ui/fluent_ui.dart';
import 'package:sibagjaapps/controllers/apiservices/S_DetailsBilling.dart';
import 'package:sibagjaapps/controllers/apiservices/S_DetailsPatients.dart';
import 'package:sibagjaapps/models/M_DetailsTagiham.dart';
import 'package:sibagjaapps/models/M_ModelTagihanDiluar.dart';
import 'package:sibagjaapps/models/M_detailsPatients.dart';

class ProvidersDetailsBilling extends ChangeNotifier {
  APIDetailsBilling _service = APIDetailsBilling();
  ApiDetailsPatients ApiPatients = ApiDetailsPatients();
  List<ModelsDetailsTagihan> _data = [];
  List<DetailsPatients> _patients = [];
  List<ModelTagihanDiluar> _tagihan = [];

  List<DetailsPatients> get patients => _patients;
  List<ModelsDetailsTagihan> get data => _data;
  List<ModelTagihanDiluar> get tagihan => _tagihan;
  String idtagihan = '';
  ProvidersDetailsBilling(idtagihanz) {
    FetchData(idtagihanz);
    idtagihan = idtagihanz;
    FetchData(idtagihan);
    notifyListeners();
  }

  FetchData(idTagihanz) async {
    _data = await _service.FetchBilling(idTagihanz);
       notifyListeners();
    _patients = await ApiPatients.FetchDataDetails(_data[0].noRM!);
       notifyListeners();
    _tagihan = await _service.FetchBillingDiluarLayanan(idTagihanz);
    notifyListeners();
  }

  DeleteLayanan(idKey) async {
    int a = await _service.DeletePaketLayanan(idKey);

    if (a == 201) {
      FetchData(idtagihan);
      notifyListeners();
    }
  }
}

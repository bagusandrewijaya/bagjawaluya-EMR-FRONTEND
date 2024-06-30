import 'package:fluent_ui/fluent_ui.dart';
import 'package:sibagjaapps/controllers/apiservices/S_FindPatientApiService.dart';
import 'package:sibagjaapps/models/M_PasienModels.dart';

class FindPatienProvider extends ChangeNotifier {
  FindPatientApiService _service = FindPatientApiService();
  List<ModelPasien> _finderName  = [];
  List<ModelPasien> _patient  = [];
  List<ModelPasien> get finderName => _finderName;
  List<ModelPasien> get patient => _patient;
  String _name = '';
 String Nameselected ='';
void fetchByName(name) async{

_name = name;
notifyListeners();
  if(name.toString().length > 2){
      _finderName = await _service.FetchData(name);
  print("panjanganya ${_finderName.length}");
  notifyListeners();
  }

}


SETname(name) {

  Nameselected  = name;
  notifyListeners();
}

void selectedName(SelectedName) async{
 _patient = await _service.FetchData(SelectedName);
  notifyListeners();
}

findWithCase() async{
  if (_name.toString().length < 3) {
    print("object");
    _patient = await _service.FetchData(_name);
      notifyListeners();

  }
   

}
}
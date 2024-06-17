import 'package:flutter/material.dart';
import 'package:sibagjaapps/controllers/apiservices/S_FetchResumeMedis.dart';
import 'package:sibagjaapps/models/M_modelsTableRekamMedis.dart';

class DataTableResumeProviders extends ChangeNotifier {
  FetchAllRekamMedis _service = FetchAllRekamMedis();
  List<MDataTableResumeMedis> data = [];

DataTableResumeProviders(rm){
fetchData(rm);

}

fetchData(rm) async{
data = await _service.FetchDataList(rm);
notifyListeners();

}
  

}
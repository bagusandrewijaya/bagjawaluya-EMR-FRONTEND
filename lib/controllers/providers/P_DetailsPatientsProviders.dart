

import 'package:flutter/material.dart';

import '../../models/M_detailsPatients.dart';
import '../apiservices/S_DetailsPatients.dart';

class ProvidersDetailsPatients extends ChangeNotifier {
  ApiDetailsPatients _service = ApiDetailsPatients();
    List<DetailsPatients> _data = [];
  TextEditingController catatanPasien = TextEditingController();

  List<DetailsPatients> get data => _data;
  String? rmTmp;
  ProvidersDetailsPatients(rm) {
    FetchData(rm);
    rmTmp  = rm;
    notifyListeners();

  }


  void FetchData(rm) async {
    _data = await _service.FetchDataDetails(rm);
    catatanPasien.text = _data[0].catatan.toString();
    notifyListeners();
  }

  void updatecataatan(context)async{
  await  _service.PutCatatan(rmTmp,catatanPasien.text,context);
  }
}


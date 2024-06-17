import 'package:flutter/material.dart';
import 'package:sibagjaapps/models/M_chartModels.dart';

import '../apiservices/S_dashboardAPIService.dart';
class DashboardProvider extends ChangeNotifier {
  List<ChartModel> _data = [];
  List<ChartModel> get data => _data;
  DashboardAPIService _service = DashboardAPIService();


DashboardProvider(){
  fetchdata();
}
fetchdata()async{
_data = await _service.FetchData();
notifyListeners();
}
}
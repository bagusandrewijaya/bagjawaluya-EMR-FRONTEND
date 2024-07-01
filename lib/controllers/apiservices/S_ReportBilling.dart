import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:sibagjaapps/models/M_bilingReport.dart';
import 'package:sibagjaapps/models/M_detailsPatients.dart';
import 'package:sibagjaapps/utils/Api_Services.dart';
import 'package:sibagjaapps/utils/classLogerInit.dart';
import 'package:sibagjaapps/utils/encryption/decryptions.dart';

import '../../models/M_ChartsPendapatan.dart';

class ReportBillingService {
  Future<List<M_BillingReport>> fetchReport({
    required String tanggalAwal,
    required String tanggalAkhir,
    required String status,
    required String noRekam,
  }) async {
    var response = await http.post(
      Uri.parse(API.BillingReport),
      headers: API.credentialsMap,
      body: {
        "tanggal_awal": tanggalAwal,
        "tanggal_akhir": tanggalAkhir,
        "status": status,
        "NoRekam": noRekam,
      },
    );

    var dataOpen = decrypt(jsonDecode(response.body)['response']);
    LOG.logger.t(dataOpen);
    List<dynamic> data = jsonDecode(dataOpen);
    List<M_BillingReport> billingReport = data.map((json) => M_BillingReport.fromJson(json)).toList();
    return billingReport;
  }

Future<List<M_ChartsBilling>> FetchBillingCharts() async {
    var response = await http.post(
      Uri.parse(API.ChartsAmount),
      headers: API.credentialsMap,
      body: {
        "id": "tanggalAwal",
  
      },
    );

    var dataOpen = decrypt(jsonDecode(response.body)['response']);
    LOG.logger.t(dataOpen);
    List<dynamic> data = jsonDecode(dataOpen);
    List<M_ChartsBilling> billingReport = data.map((json) => M_ChartsBilling.fromJson(json)).toList();
    return billingReport;
  }

}

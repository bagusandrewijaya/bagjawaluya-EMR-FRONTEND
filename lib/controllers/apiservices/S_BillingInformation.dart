import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:sibagjaapps/models/M_BankList.dart';
import 'package:sibagjaapps/models/M_BiayaPerhari.dart';
import 'package:sibagjaapps/utils/Api_Services.dart';
import 'package:sibagjaapps/utils/classLogerInit.dart';

import '../../utils/encryption/decryptions.dart';

class billingInformationService {
  Future<String> FetchHargaBulanan() async {
    final response = await http.post(Uri.parse(API.HargaBulananMaster),
        headers: API.credentialsMap, body: {});
    var dataOpen = decrypt(jsonDecode(response.body)['response']);

    return jsonDecode(dataOpen)['biayaPerHari'];
  }

  Future<String> FetchTanggalTerbitTagihan() async {
    final response = await http.post(Uri.parse(API.SiklusTanggal),
        headers: API.credentialsMap, body: {});
    var dataOpen = decrypt(jsonDecode(response.body)['response']);

    return jsonDecode(dataOpen)['tgl_siklus'];
  }

  Future<List<M_BankInformation>> FetchAllBank() async {
    final response = await http.post(Uri.parse(API.functionListBankAccount),
        headers: API.credentialsMap, body: {});
    var dataOpen = decrypt(jsonDecode(response.body)['response']);

    LOG.logger.t(dataOpen);
    List<dynamic> data = jsonDecode(dataOpen);
    List<M_BankInformation> banklist =
        data.map((json) => M_BankInformation.fromJson(json)).toList();
    return banklist;
  }


  Future<int> UpdateBillingMaster({
    required String biayaharian,
    required String siklusTagihan
  }) async {
final response = await http.post(Uri.parse(API.UpdateBillingMaster),
        headers: API.credentialsMap,
        body: {
          "biayaharian": biayaharian,
          "siklusTagihan" : siklusTagihan
        
        });

    LOG.logger.t(jsonDecode(response.body));
    return response.statusCode;

  }

  Future<int> AddBankAccount(
      {required String bankName,
      required String accountName,
      required String bankNumber}) async {
    final response = await http.post(Uri.parse(API.functionAddBankAccount),
        headers: API.credentialsMap,
        body: {
          "bankAccount": bankName,
          "accountname": bankNumber ,
          "accountnumber": accountName
        });

    LOG.logger.t(jsonDecode(response.body));
    return response.statusCode;
  }

    Future<int> UpdateStatusBank(
      {required String idRek,
      required String status}) async {
    final response = await http.post(Uri.parse(API.UpdateStatusBank),
        headers: API.credentialsMap,
        body: {
          "idRek": idRek,
          "status": status 
        });

    LOG.logger.t(jsonDecode(response.body));
    return response.statusCode;
  }
}

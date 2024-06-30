import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:sibagjaapps/models/M_DetailsTagiham.dart';
import 'package:sibagjaapps/models/M_ModelTagihanDiluar.dart';
import 'package:sibagjaapps/models/M_Payments.dart';
import 'package:sibagjaapps/models/M_billingListObat.dart';
import 'package:sibagjaapps/utils/Api_Services.dart';
import 'package:sibagjaapps/utils/classLogerInit.dart';
import 'package:sibagjaapps/utils/encryption/decryptions.dart';
import 'package:toastification/toastification.dart';

class APIDetailsBilling {
  Future<List<ModelsDetailsTagihan>> FetchBilling(idTagihan) async {
    final response = await http.post(Uri.parse(API.DetailsBilling),
        headers: API.credentialsMap, body: {"idTagihan": idTagihan});

    if (response.statusCode == 200) {
      var dataOpen = decrypt(jsonDecode(response.body)['response']);

      List<dynamic> data = jsonDecode(dataOpen);

      List<ModelsDetailsTagihan> Users =
          data.map((json) => ModelsDetailsTagihan.fromJson(json)).toList();
      return Users;
    } else {
      return [];
    }
  }

  Future<List<M_PaymentsBilling>> FetchPayments(
      {required String idBilling}) async {
    final response = await http.post(Uri.parse(API.FetchPaymentIdBilling),
        headers: API.credentialsMap, body: {"idBilling": idBilling});

    if (response.statusCode == 200) {
      var dataOpen = decrypt(jsonDecode(response.body)['response']);
      LOG.logger.t(dataOpen);
      // Ensure the decrypted data is parsed as a List
      List<dynamic> data = jsonDecode(dataOpen);

      List<M_PaymentsBilling> payments =
          data.map((json) => M_PaymentsBilling.fromJson(json)).toList();
      return payments;
    } else {
      return [];
    }
  }

  Future<List<ModelTagihanDiluar>> FetchBillingDiluarLayanan(idTagihan) async {
    final response = await http.post(Uri.parse(API.DetailsPaketLayananDiluar),
        headers: API.credentialsMap, body: {"idTagihan": idTagihan});

    if (response.statusCode == 200) {
      var dataOpen = decrypt(jsonDecode(response.body)['response']);
      List<dynamic> data = jsonDecode(dataOpen);

      List<ModelTagihanDiluar> Users =
          data.map((json) => ModelTagihanDiluar.fromJson(json)).toList();
      return Users;
    } else {
      return [];
    }
  }

  Future<List<ModelBillingObat>> FetchBillingObat(idTagihan) async {
    final response = await http.post(Uri.parse(API.FetchBillingObat),
        headers: API.credentialsMap, body: {"idTagihan": idTagihan});

    if (response.statusCode == 200) {
      var dataOpen = decrypt(jsonDecode(response.body)['response']);
      List<dynamic> data = jsonDecode(dataOpen);

      List<ModelBillingObat> Users =
          data.map((json) => ModelBillingObat.fromJson(json)).toList();
      return Users;
    } else {
      return [];
    }
  }

  Future<int> ADDPaketLayanan(
      {required String idlayanan,
      required String amount,
      required String namaLayanan,
      required BuildContext context}) async {
    final response = await http.post(Uri.parse(API.CreatePaketLayanan),
        headers: API.credentialsMap,
        body: {
          "idTagihanFK": idlayanan,
          "harga": amount,
          "namaTagihan": namaLayanan
        });
    LOG.logger.t(jsonDecode(response.body));
    return response.statusCode;
  }

  Future<int> DeletePaketLayanan(idlayanan) async {
    final response = await http.post(Uri.parse(API.DeletePaketDiluarLayanan),
        headers: API.credentialsMap, body: {"idKEY": idlayanan});

    return response.statusCode;
  }

  Future<int> DeleteObat(idlayanan) async {
    final response = await http.post(Uri.parse(API.DeletePembiayaanObat),
        headers: API.credentialsMap, body: {"idKEY": idlayanan});

    return response.statusCode;
  }

  Future<int> ADDPembiayaanObat(
      {required String idlayanan,
      required String amount,
      required String namaLayanan,
      required BuildContext context}) async {
    final response = await http.post(Uri.parse(API.CreatePembiayaanObat),
        headers: API.credentialsMap,
        body: {
          "idTagihanFK": idlayanan,
          "harga": amount,
          "namaObat": namaLayanan
        });
    return response.statusCode;
  }

  Future<int> AddpaymentOnBilling(
      {required String idlayanan,
      required String amount,
      required String deskripsi,
      required String flagging,
      required BuildContext context}) async {
    final response = await http.post(Uri.parse(API.AddPaymentOnBilling),
        headers: API.credentialsMap,
        body: {
          "idBilling": idlayanan,
          "flagging": flagging,
          "amount": amount,
          'deskripsi': deskripsi
        });
        LOG.logger.t(jsonDecode(response.body));
    return response.statusCode;
  }
}

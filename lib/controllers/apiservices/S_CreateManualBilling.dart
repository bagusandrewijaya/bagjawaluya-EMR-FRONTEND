import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:sibagjaapps/utils/Api_Services.dart';
import 'package:toastification/toastification.dart';



class APICreateManualBilling {
  
  Future<String> CreatePayment({
required String RM,
required String idTagihan,
required String totalObat,
required String totalBiayaDiluar,
required String biayaBulanan,
required BuildContext context

  })async{
    final response = await http.post(Uri.parse(API.CreateManualBilling),headers: API.credentialsMap,body: {
      "rm" :RM ,
      "idTagihan" : idTagihan,
      "tagihanBulanan" : totalBiayaDiluar,
      "tagihanObat" : totalObat,
      "biayaDiluarLayanan" :  biayaBulanan

    });

 toastification.show(
        type: ToastificationType.success,
        style: ToastificationStyle.flat,
        context: context, // optional if you use ToastificationWrapper
        title: Text('pembayaran Berhasil Dibuat'),
        description: Text('Halaman Cetak Pembayaran Akan Segera Dimuat'),
        autoCloseDuration: const Duration(seconds: 5),
      );
    return jsonDecode(response.body)['metadata']['message'];
  }
}
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:http/http.dart' as http;
import 'package:sibagjaapps/utils/Api_Services.dart';
import 'package:sibagjaapps/utils/classLogerInit.dart';
import 'package:toastification/toastification.dart';

class AddPatientsApiService {
  postPatients(
      nama,
      jk,
      alamat,
      RwayatM,
      tgllhir,
      namaK,
      kontak,
      alamatK,
      saldopenjamin,
      saldoawal,
      context,
      namaibu,
      ktp,
      pekerjaan,
      agama,
      pekerjaank,
      latarBelakang,
      tanggalmasuk,
      suku,
      pendidikan,
      hubungan) async {
    final response = await http
        .post(Uri.parse(API.AddPatients), headers: API.credentialsMap, body: {
      "nama": nama,
      "jenis_kelamin": jk,
      "alamat": alamat,
      "riwayat_medis": RwayatM,
      "tanggal_lahir": tgllhir,
      "namaayah": namaK,
      "namaibu": namaibu,
      "kontak": kontak,
      "alamatkeluarga": alamatK,
      "saldopenjamin": saldopenjamin,
      "saldoawal": saldoawal,
      "pekerjaan": pekerjaan,
      "agama": agama,
      "pekerjaank": pekerjaank,
      'ktp': ktp,
      'latarBelakang': latarBelakang,
      "tanggalmasuk": tanggalmasuk,
      "suku": suku,
      "pendidikan": pendidikan,
      "hubungan": hubungan
    });

    if (response.statusCode == 201) {
      toastification.show(
        type: ToastificationType.success,
        style: ToastificationStyle.flat,
        context: context, // optional if you use ToastificationWrapper
        title: Text('pasien berhasil di tambah!'),
        autoCloseDuration: const Duration(seconds: 5),
      );
    } else {
      LOG.logger.t(jsonDecode(response.body));
      toastification.show(
        type: ToastificationType.error,
        style: ToastificationStyle.flat,
        context: context, // optional if you use ToastificationWrapper
        title: Text('gagal menambah!'),
        autoCloseDuration: const Duration(seconds: 5),
      );
    }
  }


Future<void> putPatients({
  required String nama,
  required String jk,
  required String alamat,
  required String RwayatM,
  required String tgllhir,
  required String namaK,
  required String kontak,
  required String alamatK,
  required BuildContext context,
  required String namaibu,
  required String ktp,
  required String pekerjaan,
  required String agama,
  required String pekerjaank,
  required String latarBelakang,
  required String tanggalmasuk,
  required String suku,
  required String pendidikan,
  required String hubungan,
  required String rm
}) async {


  final response = await http.post(Uri.parse(API.UpdatePatient), headers: API.credentialsMap, body: {
    "nama": nama,
    "jenis_kelamin": jk,
    "alamat": alamat,
    "riwayat_medis": RwayatM,
    "tanggal_lahir": tgllhir,
    "namaayah": namaK,
    "namaibu": namaibu,
    "kontak": kontak,
    "alamatkeluarga": alamatK,
    "pekerjaan": pekerjaan,
    "agama": agama,
    "pekerjaank": pekerjaank,
    'ktp': ktp,
    'latarBelakang': latarBelakang,
    "tanggalmasuk": tanggalmasuk,
    "suku": suku,
    "pendidikan": pendidikan,
    "hubungan": hubungan,
    "NoRM" : rm
  });
   LOG.logger.t(jsonDecode(response.body));
  if (response.statusCode == 200) {
    toastification.show(
      type: ToastificationType.success,
      style: ToastificationStyle.flat,
      context: context, // optional if you use ToastificationWrapper
      title: Text('pasien berhasil Update'),
      autoCloseDuration: const Duration(seconds: 5),
    );
    Navigator.pop(context);
  } else {
 
    toastification.show(
      type: ToastificationType.error,
      style: ToastificationStyle.flat,
      context: context, // optional if you use ToastificationWrapper
      title: Text('gagal menambah!'),
      autoCloseDuration: const Duration(seconds: 5),
    );
  }
}

}

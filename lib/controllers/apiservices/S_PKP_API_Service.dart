import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:sibagjaapps/models/M_DetailsPsikiatri.dart';
import 'package:sibagjaapps/utils/Api_Services.dart';
import 'package:sibagjaapps/utils/classLogerInit.dart';
import 'package:sibagjaapps/utils/encryption/decryptions.dart';
import 'package:toastification/toastification.dart';

class APIPKP {
  Future<void> PostPKP(
    String tgl_masuk, String jam_masuk, String dibawa_oleh, String tgl_dibawa,
    String gejala, String faktor, bool? tangan_diikat, bool? ekspresi_muka_tegang,
    bool? kontak_verbal_inkoherent, bool? murung, bool? sedih, bool? cemas,
    bool? perilaku_tak_wajar, String halusinasi_dengar, String halusinasi_lihat,
    String  wahan, String curiga, String keadaan_lain, String tekanan_darah,
    String nadi, String suhu, String pernafasan, String pemeriksaan_lain,
    String RM, String PJ,statusmental,context,pemeriksaantahaptiga,gaf_skor) async {
    final response = await http.post(
      Uri.parse(API.Insertpsikiatri),
      headers: API.credentialsMap,
      body: {
        "tgl_masuk": tgl_masuk,
        "jam_masuk": jam_masuk,
        "dibawa_oleh": dibawa_oleh,
        "tgl_dibawa": tgl_dibawa,
        "gejala": gejala,
        "faktor": faktor,
        "tangan_diikat": tangan_diikat == true ? '1' : '0',
        "ekspresi_muka_tegang": ekspresi_muka_tegang == true ? '1' : '0',
        "kontak_verbal_inkoherent": kontak_verbal_inkoherent == true ? '1' : '0',
        "murung": murung == true ? '1' : '0',
        "sedih": sedih == true ? '1' : '0',
        "cemas": cemas == true ? '1' : '0',
        "perilaku_tak_wajar": perilaku_tak_wajar == true ? '1' : '0',
        "halusinasi_dengar": halusinasi_dengar,
        "halusinasi_lihat": halusinasi_lihat,
        "wahan": wahan,
        "curiga": curiga,
        "keadaan_lain": keadaan_lain.isEmpty ? "kosong" : keadaan_lain,
        "tekanan_darah": tekanan_darah,
        "nadi": nadi,
        "suhu": suhu,
        "pernafasan": pernafasan,
        "pemeriksaan_lain": pemeriksaan_lain,
        "RM": RM,
        "PJ": PJ,
        'statusmental' : statusmental,
        "pemeriksaantahaptiga" :pemeriksaantahaptiga,
        "gaf_skor" : gaf_skor
      },
    );

    try {
            LOG.logger.t(jsonDecode(response.body));
          if (response.statusCode == 201) {
      toastification.show(
        type: ToastificationType.success,
        style: ToastificationStyle.flat,
  context: context, // optional if you use ToastificationWrapper
  title: Text('Pengkajian Keperawatan Psikiatri Berhasil Di ditambah'),
  autoCloseDuration: const Duration(seconds: 5),
);
      Navigator.pop(context);
    }else{
      
        toastification.show(
        type: ToastificationType.error,
        style: ToastificationStyle.flat,
  context: context, // optional if you use ToastificationWrapper
  title: Text('Gagal Menyimpan Data'),
  description: Text(jsonDecode(response.body)['metadata']['message']),
  autoCloseDuration: const Duration(seconds: 5),
);
    }
    } catch (e) {
      LOG.logger.t(e);
    }
  }

  Future<List<MDetailsPsikiatri>> FetchDataDetails(String id)async{
      var response = await http.post(Uri.parse(API.GetDetailPsikiatri),headers:  API.credentialsMap,body: {
        "ID" : id
      });
 var dataOpen = decrypt(jsonDecode(response.body)['response']);
      LOG.logger.t(dataOpen);
      List<dynamic> data = jsonDecode(dataOpen);
      List<MDetailsPsikiatri> patients = data.map((json) => MDetailsPsikiatri.fromJson(json)).toList();
      return patients;
  }



  Future<void> PutPKP(
    String tgl_masuk,
     String jam_masuk,
      String dibawa_oleh, 
      String tgl_dibawa,
    String gejala,
     String faktor,
      bool? tangan_diikat,
       bool? ekspresi_muka_tegang,
    bool? kontak_verbal_inkoherent,
     bool? murung, 
     bool? sedih, 
     bool? cemas,
    bool? perilaku_tak_wajar,
     String halusinasi_dengar,
      String halusinasi_lihat,
    String wahan, String curiga, 
    String keadaan_lain, 
    String tekanan_darah,
    String nadi, String suhu, 
    String pernafasan, 
    String pemeriksaan_lain,
     String statusmental, 
     String id_psikiatri, context,pemeriksaantahaptiga,gaf_skor) async {
    
    final response = await http.post(
      Uri.parse(API.UpdatePsikiatri),
      headers: API.credentialsMap,
      body: {
        "tgl_masuk": tgl_masuk,
        "jam_masuk": jam_masuk,
        "dibawa_oleh": dibawa_oleh,
        "tgl_dibawa": tgl_dibawa,
        "gejala": gejala,
        "faktor": faktor,
        "tangan_diikat": tangan_diikat == true ? '1' : '0',
        "ekspresi_muka_tegang": ekspresi_muka_tegang == true ? '1' : '0',
        "kontak_verbal_inkoherent": kontak_verbal_inkoherent == true ? '1' : '0',
        "murung": murung == true ? '1' : '0',
        "sedih": sedih == true ? '1' : '0',
        "cemas": cemas == true ? '1' : '0',
        "perilaku_tak_wajar": perilaku_tak_wajar == true ? '1' : '0',
        "halusinasi_dengar": halusinasi_dengar,
        "halusinasi_lihat": halusinasi_lihat,
        "wahan": wahan,
        "curiga": curiga,
        "keadaan_lain": keadaan_lain.isEmpty ? "kosong" : keadaan_lain,
        "tekanan_darah": tekanan_darah,
        "nadi": nadi,
        "suhu": suhu,
        "pernafasan": pernafasan,
        "pemeriksaan_lain": pemeriksaan_lain,
        "statusmental": statusmental,
        "uuid": id_psikiatri,
        "pemeriksaantahaptiga" :pemeriksaantahaptiga,
        "gaf_skor" : gaf_skor
      },
    );
  LOG.logger.t(jsonDecode(response.body));

    try {
   
      if (response.statusCode == 200) {
        toastification.show(
          type: ToastificationType.success,
          style: ToastificationStyle.flat,
          context: context,
          title: Text('Pengkajian Keperawatan Psikiatri Berhasil Di update'),
          autoCloseDuration: const Duration(seconds: 5),
        );
        Navigator.pop(context);
      } else {
        toastification.show(
          type: ToastificationType.error,
          style: ToastificationStyle.flat,
          context: context,
          title: Text('Gagal Menyimpan Data'),
          description: Text(jsonDecode(response.body)['metadata']['message']),
          autoCloseDuration: const Duration(seconds: 5),
        );
      }
    } catch (e) {
      LOG.logger.t(e);
    }
  }


}

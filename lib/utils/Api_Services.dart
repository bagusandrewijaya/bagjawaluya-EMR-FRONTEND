// ignore: file_names
import 'dart:convert';

String baseUrl = 'https://api.vpscloudtrx.online/';
String username = "2cJIKtu0W1PUROin";
String password = "CxdhrHuOSueSDr6A";
String basicAuth = 'Basic ${base64Encode(utf8.encode('$username:$password'))}';

class API {
//header request
/////////////////
  static Map<String, String> credentialsMap = {
    'Authorization': basicAuth,
  };

//all endpoin
////////////////
  static String auth = '${baseUrl}LoginApi';
  static String AddPatients = '${baseUrl}AddPatients';
  static String ChartDataJumlah = '${baseUrl}ChartDataJumlah';
  static String GETPatientUseName = '${baseUrl}GETPatientUseName';
  static String Insertpsikiatri = '${baseUrl}Insertpsikiatri';
  static String GetUserForUpdate = '${baseUrl}GetUserForUpdate';
  static String ResumeMedis = '${baseUrl}ResumeMedis';
  static String GetDetailPsikiatri = '${baseUrl}GetDetailPsikiatri';
  static String PsikiatriDocs = '${baseUrl}PsikiatriDocs';
  static String InsertCtd = '${baseUrl}InsertCtd';
  static String UpdateCtd = '${baseUrl}UpdateCtd';
  static String GetCtdById = '${baseUrl}GetCtdById';
  static String CetakCTD = '${baseUrl}CetakCTD';
  static String UpdatePsikiatri = '${baseUrl}UpdatePsikiatri';
  static String UpdateCatatanPasien = '${baseUrl}UpdateCatatanPasien';
  static String CetakInfo = '${baseUrl}CetakInfo?norekam=';
  static String UpdatePatient = '${baseUrl}UpdatePatient';
  static String BillingGet = '${baseUrl}BillingGet';
  static String GetListCard = '${baseUrl}GetListCard';
  static String DetailsBilling = '${baseUrl}DetailsBilling';
  static String DetailsPaketLayananDiluar = '${baseUrl}DetailsPaketLayananDiluar';
  static String DeletePaketDiluarLayanan = '${baseUrl}DeletePaketDiluarLayanan';
  static String CreateManualBilling = '${baseUrl}CreateManualBilling';
  static String CreatePaketLayanan = '${baseUrl}CreatePaketLayanan';
  static String CreatePembiayaanObat = '${baseUrl}CreatePembiayaanObat';
  static String FetchBillingObat = '${baseUrl}FetchBillingObat';
  static String DeletePembiayaanObat = '${baseUrl}DeletePembiayaanObat';

  
}

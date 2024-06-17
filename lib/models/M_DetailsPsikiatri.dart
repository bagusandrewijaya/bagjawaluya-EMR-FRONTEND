class MDetailsPsikiatri {
  String? no;
  String? idKeluarga;
  String? namaPasien;
  String? tanggalLahir;
  String? jenisKelamin;
  String? alamat;
  String? riwayatMedis;
  String? createdAt;
  String? updateAt;
  String? noRMFK;
  String? idPsikiatri;
  String? tglMasuk;
  String? jamMasuk;
  String? dibawaOleh;
  String? tglDibawa;
  String? gejala;
  String? statusMental;
  String? faktor;
  String? tanganDiikat;
  String? ekspresiMukaTegang;
  String? kontakVerbalInkoherent;
  String? murung;
  String? sedih;
  String? cemas;
  String? perilakuTakWajar;
  String? halusinasiDengar;
  String? halusinasiLihat;
  String? wahan;
  String? curiga;
  String? keadaanLain;
  String? tekananDarah;
  String? nadi;
  String? suhu;
  String? pernafasan;
  String? pemeriksaanLain;
  String? createAt;
  String? updateAt2;
  String? pemeriksaanLanjutan;
  String? gaf_skor;

  MDetailsPsikiatri(
      {this.no,
      this.idKeluarga,
      this.namaPasien,
      this.tanggalLahir,
      this.jenisKelamin,
      this.alamat,
      this.riwayatMedis,
      this.createdAt,
      this.updateAt,
      this.noRMFK,
      this.idPsikiatri,
      this.tglMasuk,
      this.jamMasuk,
      this.dibawaOleh,
      this.tglDibawa,
      this.gejala,
      this.statusMental,
      this.faktor,
      this.tanganDiikat,
      this.ekspresiMukaTegang,
      this.kontakVerbalInkoherent,
      this.murung,
      this.sedih,
      this.cemas,
      this.perilakuTakWajar,
      this.halusinasiDengar,
      this.halusinasiLihat,
      this.wahan,
      this.curiga,
      this.keadaanLain,
      this.tekananDarah,
      this.nadi,
      this.suhu,
      this.pernafasan,
      this.pemeriksaanLain,
      this.createAt,
      this.updateAt2,
      this.pemeriksaanLanjutan,
      this.gaf_skor
      });

  MDetailsPsikiatri.fromJson(Map<String, dynamic> json) {
    no = json['no'];
    idKeluarga = json['IdKeluarga'];
    namaPasien = json['NamaPasien'];
    tanggalLahir = json['TanggalLahir'];
    jenisKelamin = json['JenisKelamin'];
    alamat = json['Alamat'];
    riwayatMedis = json['RiwayatMedis'];
    createdAt = json['CreatedAt'];
    updateAt = json['UpdateAt'];
    noRMFK = json['NoRMFK'];
    idPsikiatri = json['id_psikiatri'];
    tglMasuk = json['tgl_masuk'];
    jamMasuk = json['jam_masuk'];
    dibawaOleh = json['dibawa_oleh'];
    tglDibawa = json['tgl_dibawa'];
    gejala = json['gejala'];
    statusMental = json['status_mental'];
    faktor = json['faktor'];
    tanganDiikat = json['tangan_diikat'];
    ekspresiMukaTegang = json['ekspresi_muka_tegang'];
    kontakVerbalInkoherent = json['kontak_verbal_inkoherent'];
    murung = json['murung'];
    sedih = json['sedih'];
    cemas = json['cemas'];
    perilakuTakWajar = json['perilaku_tak_wajar'];
    halusinasiDengar = json['halusinasi_dengar'];
    halusinasiLihat = json['halusinasi_lihat'];
    wahan = json['wahan'];
    curiga = json['curiga'];
    keadaanLain = json['keadaan_lain'];
    tekananDarah = json['tekanan_darah'];
    nadi = json['nadi'];
    suhu = json['suhu'];
    pernafasan = json['pernafasan'];
    pemeriksaanLain = json['pemeriksaan_lain'];
    createAt = json['create_at'];
    updateAt2 = json['update_at'];
    pemeriksaanLanjutan = json['pemeriksaantahaptiga'];
    gaf_skor = json['gaf_skor'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['no'] = this.no;
    data['IdKeluarga'] = this.idKeluarga;
    data['NamaPasien'] = this.namaPasien;
    data['TanggalLahir'] = this.tanggalLahir;
    data['JenisKelamin'] = this.jenisKelamin;
    data['Alamat'] = this.alamat;
    data['RiwayatMedis'] = this.riwayatMedis;
    data['CreatedAt'] = this.createdAt;
    data['UpdateAt'] = this.updateAt;
    data['NoRMFK'] = this.noRMFK;
    data['id_psikiatri'] = this.idPsikiatri;
    data['tgl_masuk'] = this.tglMasuk;
    data['jam_masuk'] = this.jamMasuk;
    data['dibawa_oleh'] = this.dibawaOleh;
    data['tgl_dibawa'] = this.tglDibawa;
    data['gejala'] = this.gejala;
    data['status_mental'] = this.statusMental;
    data['faktor'] = this.faktor;
    data['tangan_diikat'] = this.tanganDiikat;
    data['ekspresi_muka_tegang'] = this.ekspresiMukaTegang;
    data['kontak_verbal_inkoherent'] = this.kontakVerbalInkoherent;
    data['murung'] = this.murung;
    data['sedih'] = this.sedih;
    data['cemas'] = this.cemas;
    data['perilaku_tak_wajar'] = this.perilakuTakWajar;
    data['halusinasi_dengar'] = this.halusinasiDengar;
    data['halusinasi_lihat'] = this.halusinasiLihat;
    data['wahan'] = this.wahan;
    data['curiga'] = this.curiga;
    data['keadaan_lain'] = this.keadaanLain;
    data['tekanan_darah'] = this.tekananDarah;
    data['nadi'] = this.nadi;
    data['suhu'] = this.suhu;
    data['pernafasan'] = this.pernafasan;
    data['pemeriksaan_lain'] = this.pemeriksaanLain;
    data['create_at'] = this.createAt;
    data['update_at'] = this.updateAt2;
    data['pemeriksaantahaptiga'] = this.pemeriksaanLanjutan;
    data['gaf_skor'] = this.gaf_skor;
    return data;
  }
}

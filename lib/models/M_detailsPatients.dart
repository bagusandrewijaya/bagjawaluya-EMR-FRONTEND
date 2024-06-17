class DetailsPatients {
  String? noRM;
  String? tglMasuk;
  String? namaPasien;
  String? tanggalLahir;
  String? umurSekarang;
  String? jenisKelamin;
  String? alamat;
  String? riwayatMedis;
  String? agama;
  String? pekerjaan;
  String? latarBelakang;
  String? suku;
  String? pendidikan;
  String? kontak;
  String? alamatKeluarga;
  String? namaibu;
  String? namaayah;
  String? ktp;
  String? pekerjaanKeluarga;
  String? hubungan;
  String? catatan;
  String? status;

  DetailsPatients(
      {this.noRM,
      this.tglMasuk,
      this.namaPasien,
      this.tanggalLahir,
      this.umurSekarang,
      this.jenisKelamin,
      this.alamat,
      this.riwayatMedis,
      this.agama,
      this.pekerjaan,
      this.latarBelakang,
      this.suku,
      this.pendidikan,
      this.kontak,
      this.alamatKeluarga,
      this.namaibu,
      this.namaayah,
      this.ktp,
      this.pekerjaanKeluarga,
      this.hubungan,
      this.catatan,
      this.status});

  DetailsPatients.fromJson(Map<String, dynamic> json) {
    noRM = json['NoRM'];
    tglMasuk = json['tgl_masuk'];
    namaPasien = json['NamaPasien'];
    tanggalLahir = json['TanggalLahir'];
    umurSekarang = json['UmurSekarang'];
    jenisKelamin = json['JenisKelamin'];
    alamat = json['Alamat'];
    riwayatMedis = json['RiwayatMedis'];
    agama = json['agama'];
    pekerjaan = json['pekerjaan'];
    latarBelakang = json['latarBelakang'];
    suku = json['suku'];
    pendidikan = json['pendidikan'];
    kontak = json['Kontak'];
    alamatKeluarga = json['AlamatKeluarga'];
    namaibu = json['namaibu'];
    namaayah = json['namaayah'];
    ktp = json['ktp'];
    pekerjaanKeluarga = json['pekerjaanKeluarga'];
    hubungan = json['hubungan'];
    catatan = json['catatan'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['NoRM'] = this.noRM;
    data['tgl_masuk'] = this.tglMasuk;
    data['NamaPasien'] = this.namaPasien;
    data['TanggalLahir'] = this.tanggalLahir;
    data['UmurSekarang'] = this.umurSekarang;
    data['JenisKelamin'] = this.jenisKelamin;
    data['Alamat'] = this.alamat;
    data['RiwayatMedis'] = this.riwayatMedis;
    data['agama'] = this.agama;
    data['pekerjaan'] = this.pekerjaan;
    data['latarBelakang'] = this.latarBelakang;
    data['suku'] = this.suku;
    data['pendidikan'] = this.pendidikan;
    data['Kontak'] = this.kontak;
    data['AlamatKeluarga'] = this.alamatKeluarga;
    data['namaibu'] = this.namaibu;
    data['namaayah'] = this.namaayah;
    data['ktp'] = this.ktp;
    data['pekerjaanKeluarga'] = this.pekerjaanKeluarga;
    data['hubungan'] = this.hubungan;
    data['catatan'] = this.catatan;
    data['status'] = this.status;
    return data;
  }
}

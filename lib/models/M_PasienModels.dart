class ModelPasien {
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

  ModelPasien(
      {this.no,
      this.idKeluarga,
      this.namaPasien,
      this.tanggalLahir,
      this.jenisKelamin,
      this.alamat,
      this.riwayatMedis,
      this.createdAt,
      this.updateAt,
      this.noRMFK});

  ModelPasien.fromJson(Map<String, dynamic> json) {
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
    return data;
  }
}
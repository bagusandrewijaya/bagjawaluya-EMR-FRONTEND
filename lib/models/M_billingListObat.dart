class ModelBillingObat {
  String? id;
  String? idKEY;
  String? idTagihanFK;
  String? namaObat;
  String? harga;
  String? no;
  String? idTagihan;
  String? noRMFK;
  String? tagihanBulanan;
  String? jumlahHari;
  String? tagihanObat;
  String? tagihanDiluarLayanan;
  String? typePayment;
  String? statusPaid;
  String? batasBayar;
  String? approvedBy;
  String? createdAt;
  String? updateAt;
  String? flaggingType;

  ModelBillingObat(
      {this.id,
      this.idKEY,
      this.idTagihanFK,
      this.namaObat,
      this.harga,
      this.no,
      this.idTagihan,
      this.noRMFK,
      this.tagihanBulanan,
      this.jumlahHari,
      this.tagihanObat,
      this.tagihanDiluarLayanan,
      this.typePayment,
      this.statusPaid,
      this.batasBayar,
      this.approvedBy,
      this.createdAt,
      this.updateAt,
      this.flaggingType});

  ModelBillingObat.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    idKEY = json['idKEY'];
    idTagihanFK = json['idTagihanFK'];
    namaObat = json['namaObat'];
    harga = json['harga'];
    no = json['no'];
    idTagihan = json['idTagihan'];
    noRMFK = json['NoRMFK'];
    tagihanBulanan = json['tagihanBulanan'];
    jumlahHari = json['jumlah_hari'];
    tagihanObat = json['tagihanObat'];
    tagihanDiluarLayanan = json['tagihanDiluarLayanan'];
    typePayment = json['type_payment'];
    statusPaid = json['statusPaid'];
    batasBayar = json['batas_bayar'];
    approvedBy = json['approved_by'];
    createdAt = json['CreatedAt'];
    updateAt = json['UpdateAt'];
    flaggingType = json['flagging_type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['idKEY'] = this.idKEY;
    data['idTagihanFK'] = this.idTagihanFK;
    data['namaObat'] = this.namaObat;
    data['harga'] = this.harga;
    data['no'] = this.no;
    data['idTagihan'] = this.idTagihan;
    data['NoRMFK'] = this.noRMFK;
    data['tagihanBulanan'] = this.tagihanBulanan;
    data['jumlah_hari'] = this.jumlahHari;
    data['tagihanObat'] = this.tagihanObat;
    data['tagihanDiluarLayanan'] = this.tagihanDiluarLayanan;
    data['type_payment'] = this.typePayment;
    data['statusPaid'] = this.statusPaid;
    data['batas_bayar'] = this.batasBayar;
    data['approved_by'] = this.approvedBy;
    data['CreatedAt'] = this.createdAt;
    data['UpdateAt'] = this.updateAt;
    data['flagging_type'] = this.flaggingType;
    return data;
  }
}

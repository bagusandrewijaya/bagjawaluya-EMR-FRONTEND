class ModelsDetailsTagihan {
  String? no;
  String? idTagihan;
  String? noRMFK;
  String? tagihanBulanan;
  Null? tagihanObat;
  String? tagihanDiluarLayanan;
  Null? typePayment;
  String? statusPaid;
  String? batasBayar;
  Null? approvedBy;
  String? createdAt;
  String? updateAt;
  String? flaggingType;
  String? noRM;
  String? tglMasuk;
  String? total;

  ModelsDetailsTagihan(
      {this.no,
      this.idTagihan,
      this.noRMFK,
      this.tagihanBulanan,
      this.tagihanObat,
      this.tagihanDiluarLayanan,
      this.typePayment,
      this.statusPaid,
      this.batasBayar,
      this.approvedBy,
      this.createdAt,
      this.updateAt,
      this.flaggingType,
      this.noRM,
      this.tglMasuk,
      this.total});

  ModelsDetailsTagihan.fromJson(Map<String, dynamic> json) {
    no = json['no'];
    idTagihan = json['idTagihan'];
    noRMFK = json['NoRMFK'];
    tagihanBulanan = json['tagihanBulanan'];
    tagihanObat = json['tagihanObat'];
    tagihanDiluarLayanan = json['tagihanDiluarLayanan'];
    typePayment = json['type_payment'];
    statusPaid = json['statusPaid'];
    batasBayar = json['batas_bayar'];
    approvedBy = json['approved_by'];
    createdAt = json['CreatedAt'];
    updateAt = json['UpdateAt'];
    flaggingType = json['flagging_type'];
    noRM = json['NoRM'];
    tglMasuk = json['tgl_masuk'];
    total = json['total'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['no'] = this.no;
    data['idTagihan'] = this.idTagihan;
    data['NoRMFK'] = this.noRMFK;
    data['tagihanBulanan'] = this.tagihanBulanan;
    data['tagihanObat'] = this.tagihanObat;
    data['tagihanDiluarLayanan'] = this.tagihanDiluarLayanan;
    data['type_payment'] = this.typePayment;
    data['statusPaid'] = this.statusPaid;
    data['batas_bayar'] = this.batasBayar;
    data['approved_by'] = this.approvedBy;
    data['CreatedAt'] = this.createdAt;
    data['UpdateAt'] = this.updateAt;
    data['flagging_type'] = this.flaggingType;
    data['NoRM'] = this.noRM;
    data['tgl_masuk'] = this.tglMasuk;
    data['total'] = this.total;
    return data;
  }
}

class ModelsDetailsTagihan {
  String? total;
  String? totalDibayarkan;
  String? totalBelumDibayarkan;
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

  ModelsDetailsTagihan(
      {this.total,
      this.totalDibayarkan,
      this.totalBelumDibayarkan,
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

  ModelsDetailsTagihan.fromJson(Map<String, dynamic> json) {
    total = json['total'];
    totalDibayarkan = json['totalDibayarkan'];
    totalBelumDibayarkan = json['totalBelumDibayarkan'];
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
    data['total'] = this.total;
    data['totalDibayarkan'] = this.totalDibayarkan;
    data['totalBelumDibayarkan'] = this.totalBelumDibayarkan;
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

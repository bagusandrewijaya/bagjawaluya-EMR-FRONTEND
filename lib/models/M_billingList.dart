class MBillingList {
  String? namaPasien;
  String? createdAt;
  String? batasBayar;
  String? statusPaid;
  String? total;
  String? idTagihan;

  MBillingList(
      {this.namaPasien,
      this.createdAt,
      this.batasBayar,
      this.statusPaid,
      this.total,
      this.idTagihan
      });

  MBillingList.fromJson(Map<String, dynamic> json) {
    namaPasien = json['NamaPasien'];
    createdAt = json['CreatedAt'];
    batasBayar = json['batas_bayar'];
    statusPaid = json['statusPaid'];
    total = json['total'];
    idTagihan = json['idTagihan'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['NamaPasien'] = this.namaPasien;
    data['CreatedAt'] = this.createdAt;
    data['batas_bayar'] = this.batasBayar;
    data['statusPaid'] = this.statusPaid;
    data['total'] = this.total;
    data['idTagihan'] = this.idTagihan;
    return data;
  }
}

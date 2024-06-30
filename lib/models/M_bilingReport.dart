class M_BillingReport {
  String createdAt;
  String idTagihan;
  String namaPasien;
  String tanggalTerakhirPayment;
  String total;
  String totalDibayarkan;
  String totalBelumDibayarkan;
  String statusPaid;
  String approvedBy;

  M_BillingReport(
      {String? createdAt,
      String? idTagihan,
      String? namaPasien,
      String? tanggalTerakhirPayment,
      String? total,
      String? totalDibayarkan,
      String? totalBelumDibayarkan,
      String? statusPaid,
      String? approvedBy})
      : createdAt = createdAt ?? 'kosong',
        idTagihan = idTagihan ?? 'kosong',
        namaPasien = namaPasien ?? 'kosong',
        tanggalTerakhirPayment = tanggalTerakhirPayment ?? 'kosong',
        total = total ?? 'kosong',
        totalDibayarkan = totalDibayarkan ?? 'kosong',
        totalBelumDibayarkan = totalBelumDibayarkan ?? 'kosong',
        statusPaid = statusPaid ?? 'kosong',
        approvedBy = approvedBy ?? 'kosong';

  M_BillingReport.fromJson(Map<String, dynamic> json)
      : createdAt = json['CreatedAt'] ?? 'kosong',
        idTagihan = json['idTagihan'] ?? 'kosong',
        namaPasien = json['NamaPasien'] ?? 'kosong',
        tanggalTerakhirPayment = json['tanggalTerakhirPayment'] ?? 'kosong',
        total = json['total'] ?? 'kosong',
        totalDibayarkan = json['totalDibayarkan'] ?? 'kosong',
        totalBelumDibayarkan = json['totalBelumDibayarkan'] ?? 'kosong',
        statusPaid = json['statusPaid'] ?? 'kosong',
        approvedBy = json['approved_by'] ?? 'kosong';

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['CreatedAt'] = createdAt;
    data['idTagihan'] = idTagihan;
    data['NamaPasien'] = namaPasien;
    data['tanggalTerakhirPayment'] = tanggalTerakhirPayment;
    data['total'] = total;
    data['totalDibayarkan'] = totalDibayarkan;
    data['totalBelumDibayarkan'] = totalBelumDibayarkan;
    data['statusPaid'] = statusPaid;
    data['approved_by'] = approvedBy;
    return data;
  }
}

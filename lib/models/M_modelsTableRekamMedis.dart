class MDataTableResumeMedis {
  String? namaPasien;
  String? no;
  String? noRMFK;
  String? parentRM;
  String? namaPemeriksaan;
  String? penanggungJawab;
  String? type;
  String? createdAt;
  String? updateAt;

  MDataTableResumeMedis(
      {this.namaPasien,
      this.no,
      this.noRMFK,
      this.parentRM,
      this.namaPemeriksaan,
      this.penanggungJawab,
      this.type,
      this.createdAt,
      this.updateAt});

  MDataTableResumeMedis.fromJson(Map<String, dynamic> json) {
    namaPasien = json['NamaPasien'];
    no = json['no'];
    noRMFK = json['NoRMFK'];
    parentRM = json['ParentRM'];
    namaPemeriksaan = json['NamaPemeriksaan'];
    penanggungJawab = json['PenanggungJawab'];
    type = json['type'];
    createdAt = json['CreatedAt'];
    updateAt = json['UpdateAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['NamaPasien'] = this.namaPasien;
    data['no'] = this.no;
    data['NoRMFK'] = this.noRMFK;
    data['ParentRM'] = this.parentRM;
    data['NamaPemeriksaan'] = this.namaPemeriksaan;
    data['PenanggungJawab'] = this.penanggungJawab;
    data['type'] = this.type;
    data['CreatedAt'] = this.createdAt;
    data['UpdateAt'] = this.updateAt;
    return data;
  }
}

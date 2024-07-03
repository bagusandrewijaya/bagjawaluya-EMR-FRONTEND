class M_BiayaPerhari {
  String? id;
  String? biayaPerHari;
  String? createdAt;
  String? updatedAt;

  M_BiayaPerhari({this.id, this.biayaPerHari, this.createdAt, this.updatedAt});

  M_BiayaPerhari.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    biayaPerHari = json['biayaPerHari'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['biayaPerHari'] = this.biayaPerHari;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}

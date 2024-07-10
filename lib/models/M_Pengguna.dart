class M_Pengguna {
  String? userId;
  String? nama;
  String? username;
  String? notlpn;
  String? alamat;
  String? deskripsi;
  String? status;
  String? createAt;

  M_Pengguna(
      {this.userId,
      this.nama,
      this.username,
      this.notlpn,
      this.alamat,
      this.deskripsi,
      this.status,
      this.createAt});

  M_Pengguna.fromJson(Map<String, dynamic> json) {
    userId = json['user_id'];
    nama = json['nama'];
    username = json['username'];
    notlpn = json['notlpn'];
    alamat = json['alamat'];
    deskripsi = json['deskripsi'];
    status = json['status'];
    createAt = json['create_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['user_id'] = this.userId;
    data['nama'] = this.nama;
    data['username'] = this.username;
    data['notlpn'] = this.notlpn;
    data['alamat'] = this.alamat;
    data['deskripsi'] = this.deskripsi;
    data['status'] = this.status;
    data['create_at'] = this.createAt;
    return data;
  }
}

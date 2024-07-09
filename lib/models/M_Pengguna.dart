class M_Pengguna {
  String? userId;
  String? nama;
  String? username;
  String? deskripsi;
  String? status;
  String? createAt;

  M_Pengguna(
      {this.userId,
      this.nama,
      this.username,
      this.deskripsi,
      this.status,
      this.createAt});

  M_Pengguna.fromJson(Map<String, dynamic> json) {
    userId = json['user_id'];
    nama = json['nama'];
    username = json['username'];
    deskripsi = json['deskripsi'];
    status = json['status'];
    createAt = json['create_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['user_id'] = this.userId;
    data['nama'] = this.nama;
    data['username'] = this.username;
    data['deskripsi'] = this.deskripsi;
    data['status'] = this.status;
    data['create_at'] = this.createAt;
    return data;
  }
}

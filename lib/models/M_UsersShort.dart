class ModelsUsersShort {
  String? userId;
  String? username;
  String? password;
  String? level;
  String? status;
  String? createAt;
  String? updateAt;

  ModelsUsersShort(
      {this.userId,
      this.username,
      this.password,
      this.level,
      this.status,
      this.createAt,
      this.updateAt});

  ModelsUsersShort.fromJson(Map<String, dynamic> json) {
    userId = json['user_id'];
    username = json['username'];
    password = json['password'];
    level = json['level'];
    status = json['status'];
    createAt = json['create_at'];
    updateAt = json['update_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['user_id'] = this.userId;
    data['username'] = this.username;
    data['password'] = this.password;
    data['level'] = this.level;
    data['status'] = this.status;
    data['create_at'] = this.createAt;
    data['update_at'] = this.updateAt;
    return data;
  }
}
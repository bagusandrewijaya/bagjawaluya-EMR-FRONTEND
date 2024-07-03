class M_BankInformation {
  String? id;
  String? accountNumber;
  String? accountName;
  String? bankName;
  String? status;
  String? createdAt;
  String? updatedAt;

  M_BankInformation(
      {this.id,
      this.accountNumber,
      this.accountName,
      this.bankName,
      this.status,
      this.createdAt,
      this.updatedAt});

  M_BankInformation.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    accountNumber = json['account_number'];
    accountName = json['account_name'];
    bankName = json['bank_name'];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['account_number'] = this.accountNumber;
    data['account_name'] = this.accountName;
    data['bank_name'] = this.bankName;
    data['status'] = this.status;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}

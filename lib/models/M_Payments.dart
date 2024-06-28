class M_PaymentsBilling {
  String? id;
  String? deskripsi;
  String? fRKIdTagihan;
  String? amount;
  String? createat;
  String? updateat;

  M_PaymentsBilling(
      {this.id, this.fRKIdTagihan, this.amount, this.createat, this.updateat});

  M_PaymentsBilling.fromJson(Map<String, dynamic> json) {
    id = json['id'];
  deskripsi = json['deskripsi'];
    fRKIdTagihan = json['FRKIdTagihan'];
    amount = json['amount'];
    createat = json['createat'];
    updateat = json['updateat'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['deskripsi'] = this.deskripsi;
    data['FRKIdTagihan'] = this.fRKIdTagihan;
    data['amount'] = this.amount;
    data['createat'] = this.createat;
    data['updateat'] = this.updateat;
    return data;
  }
}

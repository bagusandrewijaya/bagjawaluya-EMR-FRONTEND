class M_ChartsBilling {
  String? yearmonthday;
  String? amount;

  M_ChartsBilling({this.yearmonthday, this.amount});

  M_ChartsBilling.fromJson(Map<String, dynamic> json) {
    yearmonthday = json['yearmonthday'];
    amount = json['amount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['yearmonthday'] = this.yearmonthday;
    data['amount'] = this.amount;
    return data;
  }
}
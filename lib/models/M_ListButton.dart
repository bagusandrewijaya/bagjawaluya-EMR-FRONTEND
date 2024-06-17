class ButtonListKeuangan {
  String? title;
  String? total;

  ButtonListKeuangan({this.title, this.total});

  ButtonListKeuangan.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    total = json['total'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['title'] = this.title;
    data['total'] = this.total;
    return data;
  }
}
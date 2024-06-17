class ChartModel {
  String? jumlahLakiLaki;
  String? jumlahPerempuan;

  ChartModel({this.jumlahLakiLaki, this.jumlahPerempuan});

  ChartModel.fromJson(Map<String, dynamic> json) {
    jumlahLakiLaki = json['JumlahLakiLaki'];
    jumlahPerempuan = json['JumlahPerempuan'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['JumlahLakiLaki'] = this.jumlahLakiLaki;
    data['JumlahPerempuan'] = this.jumlahPerempuan;
    return data;
  }
}
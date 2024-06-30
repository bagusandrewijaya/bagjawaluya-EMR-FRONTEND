import 'package:flutter/material.dart';
import 'package:sibagjaapps/models/M_ChartsPendapatan.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:intl/intl.dart';
import 'dart:ui' as ui;

class PaymentReportChart extends StatelessWidget {
  final List<PaymentData> data;

  PaymentReportChart({required this.data});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SfCartesianChart(
        primaryXAxis: DateTimeAxis(
          title: AxisTitle(text: 'Bulan'),
          dateFormat: DateFormat('MMM yyyy'), // Format bulan dan tahun
          interval: 1,
          intervalType: DateTimeIntervalType.months,
          labelRotation: 45, // Rotasi label untuk menghindari tumpang tindih
        ),
        primaryYAxis: NumericAxis(
          title: AxisTitle(text: 'Jumlah Uang Masuk'),
          numberFormat: NumberFormat.currency(locale: 'id_ID', symbol: 'Rp'),
        ),
        title: ChartTitle(text: 'Pemasukan Perbulan'),
        legend: Legend(isVisible: false),
        tooltipBehavior: TooltipBehavior(enable: true),
        series: _getLineSeries(),
      ),
    );
  }

  List<CartesianSeries<PaymentData, DateTime>> _getLineSeries() {
    return <CartesianSeries<PaymentData, DateTime>>[
      LineSeries<PaymentData, DateTime>(
        dataSource: data,
        xValueMapper: (PaymentData payment, _) => payment.yearmonthday,
        yValueMapper: (PaymentData payment, _) => payment.amount,
        name: 'Uang Masuk',
        dataLabelSettings: DataLabelSettings(isVisible: true),
        markerSettings: MarkerSettings(isVisible: true),
        onCreateShader: (ShaderDetails details) {
          return ui.Gradient.linear(
            details.rect.topCenter,
            details.rect.bottomCenter,
            <Color>[
              Colors.blue,
              Colors.blue,
              Colors.green,
              Colors.green,
              Colors.red,
              Colors.red,
            ],
            <double>[0, 0.33, 0.33, 0.66, 0.66, 1],
          );
        },
      ),
    ];
  }
}


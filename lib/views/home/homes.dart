import 'package:data_table_2/data_table_2.dart';
import 'package:file_saver/file_saver.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:line_icons/line_icons.dart';
import 'package:provider/provider.dart';
import 'package:sibagjaapps/controllers/providers/P_dashboard.dart';
import 'package:sibagjaapps/utils/Api_Services.dart';
import 'package:sibagjaapps/views/components/headertitle.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:url_launcher/url_launcher.dart';

class HomeView extends StatefulWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  State<HomeView> createState() => _HomeViewState();
}
  class ChartData {
        ChartData(this.x, this.y, this.color);
            final String x;
            final double y;
            final Color color;
    }




class _HomeViewState extends State<HomeView> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
   backgroundColor: Colors.transparent,
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Selamat Datang, Bagus Andre",style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold
                    ),),
                        Row(children: [
                      
SizedBox(width: 8,),
                          GestureDetector(
                            onTap: () {
                             
                            },
                            child: Container(
                              height: 50,
                              width: 50,
                            
                            decoration: BoxDecoration(
                            color: Colors.blueAccent,
                              shape: BoxShape.circle
                            ),
                            child: Center(
                              child: Text("A",style: TextStyle(
                                color: Colors.white,fontWeight: FontWeight.bold
                              ),),
                            ),
                            ),
                          )
                        ],)
                        
                  ],
                ),
              )
            ),
            Expanded(
              flex: 8,
              child: Row(
                children: [
                  Expanded(
                    flex: 2,
                    child: Container(
                      decoration: BoxDecoration(borderRadius: BorderRadius.circular(8),
                        
                      ),
                      child: Column(
                        children: [
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                     Expanded(
                       child: GridView.builder(
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3,
                          mainAxisSpacing: 8,
                          crossAxisSpacing: 8,
                          childAspectRatio: 300 / 125,
                        ),
                        itemCount: 1,
                        itemBuilder: (context, index) {
                          return Container(
                            margin: EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(8),
                              boxShadow: [
                                BoxShadow(
                                  color: const Color.fromARGB(87, 158, 158, 158),
                                  spreadRadius: 1,
                                  blurRadius: 4,
                                  offset: Offset(0, 4),
                                )
                              ],
                            ),
                            padding: EdgeInsets.all(8),
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Jumlah Pasien',
                                    style: TextStyle(fontSize: 16.0),
                                  ),
                                  Align(
                                    alignment: Alignment.bottomRight,
                                    child: Text(
                                      "2",
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 32,
                                      ),
                                    ),
                                  )
                                ],
                              )
                          );
                        },
                                           ),
                     ),
                             
                    ],
                  )
                ),
      
       
        Expanded(
  flex: 3,
  child: Container(
    child: Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
               crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
            children: [
                  Image.asset('assets/images/unbin_big.png',scale: 6,),
                  Gap(8),
                     Image.asset('assets/images/bagjawaluya.png',scale: 6,)
            ],
          ),
            Gap(8),
          Text("INFORMASI",style: TextStyle(
            color: Colors.red
          ),),
    
          Text("Untuk mendukung pengelolaan data medis secara efisien dan terpadu."),
          Text("Dukungan aplikasi Chrome tersedia untuk Windows 10 ke atas."),
          Text("Pastikan Anda menginstal versi terbaru dari Chrome."),
        ],
      ),
    ),
  ),
)

                        ],
                      ),
                  )),
                  
                  SizedBox(width: 16,),
                   Expanded(child: Container(
                    padding: EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      color: Colors.white
                    ),
                   child: Column(
                    children: [
                           HeaderTitleGradient(text: "Mini Information",),
                      ChangeNotifierProvider(
  create: (context) => DashboardProvider(),
  child: Consumer<DashboardProvider>(
    builder: (context, provider, _) {
      List<ChartData> chartData = [
        ChartData('Laki-Laki', double.parse(provider.data.isNotEmpty ? provider.data[0].jumlahLakiLaki.toString() : '0'), Color.fromRGBO(9, 0, 136, 1)),
        ChartData('Perempuan', double.parse(provider.data.isNotEmpty ? provider.data[0].jumlahPerempuan.toString() : '0'), Color.fromRGBO(147, 0, 119, 1)),
      ];
      return provider.data.isNotEmpty ? SfCircularChart(
        tooltipBehavior: TooltipBehavior(enable: true),
        legend: Legend(isVisible: true),
        series: <CircularSeries>[
          DoughnutSeries<ChartData, String>(
            dataLabelSettings: DataLabelSettings(
              isVisible: true,
            ),
            dataSource: chartData,
            pointColorMapper: (ChartData data, _) => data.color,
            xValueMapper: (ChartData data, _) => data.x,
            yValueMapper: (ChartData data, _) => data.y
          )
        ]
      ) : SizedBox();
    }
  ),
),

                         HeaderTitleGradient(text: "Pasien Baru",),
                         Expanded(
                           child: ListView.builder(
                                     itemCount: 1, // Ganti dengan jumlah item yang Anda inginkan
                                     itemBuilder: (context, index) {
                                       return ListTile(
                                         title: Text('Annisa Sabhila'), // Menampilkan nomor item
                                         subtitle: Text('Masuk Pada Tanggal 2024/06/12  '), // Contoh teks tambahan
                                         leading: CircleAvatar(
                                           child: Text((index + 1).toString()), // Menampilkan nomor item dalam avatar lingkaran
                                         ),
                                         onTap: () {
                                           // Aksi yang ingin dilakukan ketika item diklik
                                           print('Item ${index + 1} clicked');
                                         },
                                       );
                                     },
                                   ),
                         ),
      
                    ],
                   ),
                   ))
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}


//  SingleChildScrollView(
//                 child: Column(
//                   children: [
//                     ListView.builder(
//                       shrinkWrap: true,
                     
//                       itemCount: 20,
//                       itemBuilder: (context, index) {
//                         return Container(
//                           color: Colors.amber,
//                           margin: EdgeInsets.all(19),
//                           child: Text('Item $index'),
//                         );
//                       },
//                     ),
//                     Container(
//                       height: 40,
//                       width: 199,
//                       color: Colors.red,
//                     ),
//                   ],
//                 ),
//               )
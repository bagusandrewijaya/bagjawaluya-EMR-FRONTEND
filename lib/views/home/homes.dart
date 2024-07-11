import 'package:data_table_2/data_table_2.dart';
import 'package:file_saver/file_saver.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:line_icons/line_icons.dart';
import 'package:provider/provider.dart';
import 'package:sibagjaapps/controllers/providers/P_AuthLoginProviders.dart';
import 'package:sibagjaapps/controllers/providers/P_dashboard.dart';
import 'package:sibagjaapps/utils/Api_Services.dart';
import 'package:sibagjaapps/views/components/headertitle.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:fluent_ui/fluent_ui.dart' as ft;

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
  final menuController = ft.FlyoutController();
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => AuthLoginProviders(),
      child: Consumer<AuthLoginProviders>(builder: (context, p, w) {
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
                      Text(
                        "Selamat Datang, ${p.name}",
                        style: TextStyle(
                            fontSize: 32, fontWeight: FontWeight.bold),
                      ),
                      Row(
                        children: [
                          SizedBox(
                            width: 8,
                          ),
                          ft.FlyoutTarget(
                              controller: menuController,
                              child: GestureDetector(
                                child: Container(
                                  height: 50,
                                  width: 50,
                                  decoration: BoxDecoration(
                                      color: Colors.blueAccent,
                                      shape: BoxShape.circle),
                                  child: Center(
                                    child: Text(
                                      "${p.name[0] == null ? "0" : p.name[0]}",
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                ),
                                onTap: () {
                                  menuController.showFlyout(
                                    autoModeConfiguration:
                                        ft.FlyoutAutoConfiguration(
                                      preferredMode:
                                          ft.FlyoutPlacementMode.topCenter,
                                    ),
                                    barrierDismissible: true,
                                    dismissOnPointerMoveAway: false,
                                    dismissWithEsc: true,
                                    builder: (context) {
                                      return ft.MenuFlyout(items: [
                                       
                                        ft.MenuFlyoutItem(
                                            leading: const Icon(
                                                ft.FluentIcons.sign_out),
                                            text: const Text('Logout'),
                                            onPressed: () {
                                              showDialog<String>(
                                                context: context,
                                                builder: (context) =>
                                                    ft.ContentDialog(
                                                  title: const Text('Sign Out'),
                                                  content: const Text(
                                                    'Apakah Kamu Yakin Kan Keluar Dari Aplikasi Ini?',
                                                  ),
                                                  actions: [
                                                    ft.Button(
                                                      child:
                                                          const Text('Keluar'),
                                                      onPressed: () async {
                                                        p.Logout(context);

                                                        // Delete file here
                                                      },
                                                    ),
                                                    ft.FilledButton(
                                                      child:
                                                          const Text('Batal'),
                                                      onPressed: () {
                                                        Navigator.pop(context,
                                                            'User deleted file');
                                                      },
                                                    ),
                                                  ],
                                                ),
                                              );
                                              setState(() {});
                                            }),
                                      ]);
                                    },
                                  );
                                },
                              )),
                        ],
                      )
                    ],
                  ),
                )),
                Expanded(
                  flex: 8,
                  child: Row(
                    children: [
                      Expanded(
                          flex: 2,
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Column(
                              children: [
                                // Expanded(
                                //     child: Row(
                                //   mainAxisAlignment:
                                //       MainAxisAlignment.spaceBetween,
                                //   children: [
                                //     Expanded(
                                //       child: GridView.builder(
                                //         gridDelegate:
                                //             SliverGridDelegateWithFixedCrossAxisCount(
                                //           crossAxisCount: 3,
                                //           mainAxisSpacing: 8,
                                //           crossAxisSpacing: 8,
                                //           childAspectRatio: 300 / 125,
                                //         ),
                                //         itemCount: 1,
                                //         itemBuilder: (context, index) {
                                //           return Container(
                                //               margin: EdgeInsets.all(8),
                                //               decoration: BoxDecoration(
                                //                 color: Colors.white,
                                //                 borderRadius:
                                //                     BorderRadius.circular(8),
                                //                 boxShadow: [
                                //                   BoxShadow(
                                //                     color: const Color.fromARGB(
                                //                         87, 158, 158, 158),
                                //                     spreadRadius: 1,
                                //                     blurRadius: 4,
                                //                     offset: Offset(0, 4),
                                //                   )
                                //                 ],
                                //               ),
                                //               padding: EdgeInsets.all(8),
                                //               child: Column(
                                //                 crossAxisAlignment:
                                //                     CrossAxisAlignment.start,
                                //                 mainAxisAlignment:
                                //                     MainAxisAlignment
                                //                         .spaceBetween,
                                //                 children: [
                                //                   Text(
                                //                     'Jumlah Pasien',
                                //                     style: TextStyle(
                                //                         fontSize: 16.0),
                                //                   ),
                                //                   Align(
                                //                     alignment:
                                //                         Alignment.bottomRight,
                                //                     child: Text(
                                //                       "2",
                                //                       style: TextStyle(
                                //                         color: Colors.black,
                                //                         fontWeight:
                                //                             FontWeight.bold,
                                //                         fontSize: 32,
                                //                       ),
                                //                     ),
                                //                   )
                                //                 ],
                                //               ));
                                //         },
                                //       ),
                                //     ),
                                //   ],
                                // )),
                                Expanded(
                                  flex: 3,
                                  child: Container(
                                    child: Center(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Image.asset(
                                                'assets/images/unbin_big.png',
                                                scale: 6,
                                              ),
                                              Gap(8),
                                              Image.asset(
                                                'assets/images/bagjawaluya.png',
                                                scale: 6,
                                              )
                                            ],
                                          ),
                                          Gap(8),
                                          Text(
                                            "INFORMASI",
                                            style: TextStyle(color: Colors.red),
                                          ),
                                          Text(
                                              "Untuk mendukung pengelolaan data medis secara efisien dan terpadu."),
                                          Text(
                                              "Dukungan aplikasi Chrome tersedia untuk Windows 10 ke atas."),
                                          Text(
                                              "Pastikan Anda menginstal versi terbaru dari Chrome."),
                                        ],
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          )),
                      SizedBox(
                        width: 16,
                      ),
                     
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      }),
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
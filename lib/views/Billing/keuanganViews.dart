import 'dart:convert';


import 'package:auto_size_text/auto_size_text.dart';
import 'package:data_table_2/data_table_2.dart';
import 'package:fluent_ui/fluent_ui.dart' as ft;
import 'package:flutter/material.dart';
import 'package:flutter_date_range_picker/flutter_date_range_picker.dart';

import 'package:gap/gap.dart';
import 'package:line_icons/line_icon.dart';
import 'package:line_icons/line_icons.dart';
import 'package:provider/provider.dart';
import 'package:sibagjaapps/controllers/providers/P_Billing_Views.dart';
import 'package:sibagjaapps/models/M_billingList.dart';
import 'package:sibagjaapps/views/Billing/billingPages.dart';
import 'package:sibagjaapps/views/Billing/createpembayaran.dart';
import 'package:sibagjaapps/views/Billing/masterbiaya.dart';
import 'package:go_router/go_router.dart' as ct ;
import 'package:sibagjaapps/views/Billing/BillingReport.dart';
import '../../models/M_ListButton.dart';
import 'components/SideListMenuCard.dart';
import 'components/tagihan/widgetbilinglistBelumBayar.dart';

class KeuanganModules extends StatefulWidget {
  const KeuanganModules({super.key});
  @override
  State<KeuanganModules> createState() => _KeuanganModulesState();
}

class _KeuanganModulesState extends State<KeuanganModules> {


  final List<String> titles = [
    "7 Hari Yang Lalu",
    "1 Bulan Yang Lalu",
    "3 Bulan Yang Lalu",
    "12 Bulan Yang lalu"
  ];



int i = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body:  ChangeNotifierProvider(
                create: (context) => ProviderBilling(),
                child:Consumer<ProviderBilling>(
            builder: (context,p,w) {
            return Row(
              children: [
                // Children row pertama
                 SizedBox(
              width: 280,
              child: SideMenuContainer(data2: p.data, tapindex: (int z) {
                 p.changePages(z);
                setState(() {
                  i = z;
                });
              
               },)
            ),
            if( p.data.length > 0 )
                if(i == 0)...[
             Container(
                  child: Expanded(
                    child: Padding(
                      padding: EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Expanded(
                                child: Container(
                                  padding: const EdgeInsets.symmetric(vertical: 16),
                                  child: Row(
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Row(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        children:  [
                                          Text(
                                            "Billing Pasien",
                                            style: TextStyle(
                                              color: Colors.black,
                                            ),
                                          ),
                                        ],
                                      ),
                                      Row(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        children:  [
                                          Icon(
                                            ft.FluentIcons.print,
                                            color: Colors.grey,
                                          )
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              )
                            ],
                          ),
                         
                          Expanded(
                            child: WidgetListBilling(
                              data: p.billing, 
                              titles: titles,
                              p: p,
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                )
                ]else if(i==1)...[
            Expanded(
              child: Container(
                padding: EdgeInsets.all(8),
                child: InvoiceReportPage(titles: titles,)
              ),
            )
                ]else if(i== 2)...[
             Expanded(child: CheckoutPageManual())
                ]else if(i == 3)...[
              CompanyInfoPage()
                ]else if(i == 4)...[
                  CheckoutPageManual()
                ]
              ],
            );
          }
        ),
      ),
    );
  }
}




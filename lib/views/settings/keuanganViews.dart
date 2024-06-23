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
import 'package:sibagjaapps/views/settings/components/Checkoutpages.dart';
import 'package:sibagjaapps/views/settings/components/createpembayaran.dart';
import 'package:sibagjaapps/views/settings/components/masterbiaya.dart';
import 'package:go_router/go_router.dart' as ct ;
import '../../models/M_ListButton.dart';
import 'components/SideListMenuCard.dart';
import 'components/tagihan/widgetbilinglist.dart';

class KeuanganModules extends StatefulWidget {
  const KeuanganModules({super.key});
  @override
  State<KeuanganModules> createState() => _KeuanganModulesState();
}

class _KeuanganModulesState extends State<KeuanganModules> {


  final List<String> titles = [
    "Last 7 Days",
    "Last Month",
    "Last 3 Months",
    "Last 12 Months"
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
                                        children: const [
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
                                        children: const [
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
                         
                          WidgetListBilling(
                            data: p.billing, 
                            titles: titles,
                            p: p,
                          )
                        ],
                      ),
                    ),
                  ),
                )
                ]else if(i==1)...[
            
                ]else if(i== 2)...[
             CheckoutPageManual()
                ]else if(i == 3)...[
              BillingInformationWidget(idTagihan: '',)
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




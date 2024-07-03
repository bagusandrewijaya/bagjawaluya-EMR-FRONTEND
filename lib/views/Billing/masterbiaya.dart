import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:line_icons/line_icons.dart';
import 'package:provider/provider.dart';
import 'package:sibagjaapps/controllers/providers/P_BillingInformation.dart';

import 'components/switchbtn/switchBtn.dart';

class CompanyInfoPage extends StatefulWidget {
  @override
  _CompanyInfoPageState createState() => _CompanyInfoPageState();
}

class _CompanyInfoPageState extends State<CompanyInfoPage> {
  final _formKey = GlobalKey<FormState>();
    List<Map<String, String>> items = [
    {'value': '122222', 'label': 'Apple'},
    {'value': 'banana', 'label': 'Banana'},
    {'value': 'grape', 'label': 'Grape'},
    {'value': 'orange', 'label': 'Orange'},
  ];

  // Initial Selected Value
  String? selectedValue;
 bool _switchValue = false;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => BillingSetMasterProvider(),
      child: Consumer<BillingSetMasterProvider>(
        builder: (context,p,w) {
          return Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        
                        Expanded(child:  Container(
            color: Colors.white,
            padding: EdgeInsets.all(16),
            child:  Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                        Text("Master Billing"),
                      Gap(8),
                      _buildFormRow('Harga Bulanan', p.harga, 'Tanggal billing otomatis', p.polatagihan),
                      Text("Payment Information"),
                      Gap(8),
                       Padding(
            padding: EdgeInsets.only(bottom: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Expanded(
                  child: _buildFormField("nama Bank", p.namabank),
                ),
                SizedBox(width: 16),
                Expanded(
                  child: _buildFormField("Nomor Rekening", p.norekening),
                ),
                  SizedBox(width: 16),
                     Expanded(
                  child: _buildFormField("Nama Pemilik", p.namaakun),
                ),
              
          Gap(4),
                GestureDetector(
                  onTap: () {
                    p.FunctionAddBank(context);
                  },
                  child: Container(
                    
                    alignment: Alignment.center,
                    padding: EdgeInsets.all(4),
                    decoration: BoxDecoration(color: Colors.blue,shape: BoxShape.circle),
                    child: Icon(LineIcons.plusCircle,color: Colors.white,size: 32,),),
                )
              ],
            ),
          ),
                        Text("Update Payment"),
                      Gap(8),
                      Padding(
            padding: EdgeInsets.only(bottom: 16),
            child:  SizedBox(
  height: 250,
  child: ListView.builder(
    itemCount: p.banklist.length, // Specify the number of items in the list
    padding: EdgeInsets.all(8),
    itemBuilder: (context, index) {
      return Container(
        padding: EdgeInsets.all(8),
        margin: EdgeInsets.symmetric(vertical: 4),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // Add bank name or other information here
            Expanded(
              child: Text(
                p.banklist[index].bankName!, // Assuming each bank has a 'name' property
                style: TextStyle(fontSize: 16),
              ),
            ),
            CustomSwitch(
              value: p.banklist[index].status == "1" ? true : false,
              onChanged: (value) {
                setState(() {
                  // Update the status of the bank
                  p.banklist[index].status = value ? "1" : "0";
                });
              },
            ),
          ],
        ),
      ); // Return a decorated container for each item
    },
  ),
)

          )
                    
                    ],
                  ),
               
                     _buildButtons(),
                ],
              ),
          )),
                        SizedBox(height: 16),
                     
                      ],
                    ),
            ),
          );
        }
      ),
    );
  }




 
  Widget _buildFormRow(String label1, TextEditingController controller1, String label2, TextEditingController? controller2) {
    return Padding(
      padding: EdgeInsets.only(bottom: 16),
      child: Row(
        children: [
          Expanded(
            child: _buildFormField(label1, controller1),
          ),
          SizedBox(width: 16),
          Expanded(
            child: controller2 != null ? _buildFormField(label2, controller2) : Container(),
          ),
        ],
      ),
    );
  }

  Widget _buildFormField(String label, TextEditingController controller) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(fontSize: 12, color: Colors.grey[600]),
        ),
        SizedBox(height: 4),
        TextFormField(
          controller: controller,
          decoration: InputDecoration(
            border: OutlineInputBorder(),
            contentPadding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            filled: true,
            fillColor: Color(0xFFF8F8F8),
          ),
          style: TextStyle(fontSize: 14),
        ),
      ],
    );
  }

  Widget _buildButtons() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        ElevatedButton(
          onPressed: () {
            if (_formKey.currentState!.validate()) {
              // Proses penyimpanan data
              print('Data saved');
            }
          },
          child: Text('SAVE'),
          style: ElevatedButton.styleFrom(
            backgroundColor: Color(0xFF4CAF50),
            foregroundColor: Colors.white,
            padding: EdgeInsets.symmetric(horizontal: 32, vertical: 16),
          ),
        ),
        SizedBox(width: 16),
        ElevatedButton(
          onPressed: () {
            // Logika untuk membatalkan
          },
          child: Text('Cancel'),
          style: ElevatedButton.styleFrom(
            backgroundColor: Color(0xFFE0E0E0),
            foregroundColor: Colors.black,
            padding: EdgeInsets.symmetric(horizontal: 32, vertical: 16),
          ),
        ),
      ],
    );
  }


}
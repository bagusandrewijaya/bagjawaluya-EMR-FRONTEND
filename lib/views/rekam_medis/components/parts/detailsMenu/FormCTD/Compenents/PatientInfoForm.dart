
import 'package:flutter/material.dart';

class PatientInfoForm extends StatelessWidget {
  final String rm;

  const PatientInfoForm({super.key,required this.rm});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(16.0),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(child: TextFormField(decoration: InputDecoration(labelText: 'Nama Pasien'),readOnly: true,)),
              SizedBox(width: 16),
              Expanded(child: TextFormField(decoration: InputDecoration(labelText: 'No. RM',),readOnly: true,initialValue: rm,)),
            ],
          ),
          SizedBox(height: 16),
          Row(
            children: [
              Expanded(child: TextFormField(decoration: InputDecoration(labelText: 'Umur'),readOnly: true,)),
              SizedBox(width: 16),
              Expanded(child: TextFormField(decoration: InputDecoration(labelText: 'Lk/Pr*'),readOnly: true,)),
              SizedBox(width: 16),
        
            ],
          ),
        ],
      ),
    );
  }
}

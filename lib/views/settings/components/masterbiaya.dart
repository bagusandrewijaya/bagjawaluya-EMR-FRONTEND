import 'package:flutter/material.dart';

class BillingInformationWidget extends StatefulWidget {
  const BillingInformationWidget({Key? key}) : super(key: key);

  @override
  _BillingInformationWidgetState createState() => _BillingInformationWidgetState();
}

class _BillingInformationWidgetState extends State<BillingInformationWidget> {
  final TextEditingController _nameController = TextEditingController(text: 'Gregory Muryn-Mukha');
  final TextEditingController _phoneController = TextEditingController(text: '937-909-6418');
  final TextEditingController _zipCodeController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Card(
        margin: EdgeInsets.all(16),
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildHeader(),
              SizedBox(height: 16),
              _buildTextField('Name', _nameController),
              SizedBox(height: 16),
              _buildTextField('Phone', _phoneController),
              SizedBox(height: 16),
              _buildTextField('Zip Code', _zipCodeController, hintText: 'Enter zip code'),
              SizedBox(height: 24),
              _buildSaveButton(),
              SizedBox(height: 16),
              _buildCreditCardInfo(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          'Billing Information',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        TextButton(
          onPressed: () {},
          child: Text('View Billing History', style: TextStyle(color: Colors.blue)),
        ),
      ],
    );
  }

  Widget _buildTextField(String label, TextEditingController controller, {String? hintText}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: TextStyle(fontSize: 14, color: Colors.grey[600])),
        SizedBox(height: 8),
        TextField(
          controller: controller,
          decoration: InputDecoration(
            hintText: hintText,
            border: OutlineInputBorder(),
            contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          ),
        ),
      ],
    );
  }

  Widget _buildSaveButton() {
    return Align(
      alignment: Alignment.centerRight,
      child: ElevatedButton(
        onPressed: () {},
        child: Text('Save Changes'),
        style: ElevatedButton.styleFrom(
          primary: Colors.blue,
          onPrimary: Colors.white,
        ),
      ),
    );
  }

  Widget _buildCreditCardInfo() {
    return Container(
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(4),
      ),
      child: Row(
        children: [
          Icon(Icons.credit_card, color: Colors.grey[600]),
          SizedBox(width: 12),
          Text('MasterCard ending in 4482', style: TextStyle(color: Colors.grey[800])),
          Spacer(),
          TextButton(
            onPressed: () {},
            child: Text('Edit Card', style: TextStyle(color: Colors.blue)),
          ),
        ],
      ),
    );
  }
}
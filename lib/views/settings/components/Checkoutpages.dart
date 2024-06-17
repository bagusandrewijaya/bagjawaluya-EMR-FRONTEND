import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class CheckoutPage extends StatefulWidget {
  final String? idTagihan;

  const CheckoutPage({super.key, this.idTagihan});
  @override
  State<CheckoutPage> createState() => _CheckoutPageState();
}

class _CheckoutPageState extends State<CheckoutPage> {
  String? selectedPaymentMode;
  @override
  Widget build(BuildContext context) {
    return Row(
        children: [
          Expanded(
            flex: 2,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildAddressSection(),
                SizedBox(height: 20),
                _buildCartSection(),
              ],
            ),
          ),
          SizedBox(height: 20),
          _buildOrderSummary(),
        ],
      );
  }

  Widget _buildAddressSection() {
    return Expanded(
      child: Card(
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Icon(Icons.location_on, color: Colors.blue),
                      SizedBox(width: 8),
                      Text('Address',
                          style: TextStyle(fontWeight: FontWeight.bold)),
                    ],
                  ),
                ],
              ),
              SizedBox(height: 8),
              Text('Pasien'),
              SizedBox(height: 8),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCartSection() {
    return Expanded(
      child: Card(
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('List Biaya Di Luar',
                      style: TextStyle(fontWeight: FontWeight.bold)),
                  Text('2 items'),
                ],
              ),
              SizedBox(height: 16),
              _buildCartItem('Roko', 'L', '₹1,012.00', '₹1,265.00',
                  'Est. Delivery by 3 Jul 2023'),
              Divider(),
              _buildCartItem('Yogurt', 'L', '₹800.00', '₹1,400.00',
                  'Est. Delivery by 3 Jul 2023'),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCartItem(String name, String size, String price,
      String originalPrice, String delivery) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 60,
          height: 60,
          color: Colors.grey[300],
          // You can add an image here
        ),
        SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(name, style: TextStyle(fontWeight: FontWeight.bold)),
              Text('Size: $size'),
              Row(
                children: [
                  Text(price, style: TextStyle(fontWeight: FontWeight.bold)),
                  SizedBox(width: 8),
                  Text(originalPrice,
                      style: TextStyle(
                          decoration: TextDecoration.lineThrough,
                          color: Colors.grey)),
                ],
              ),
              Text(delivery, style: TextStyle(color: Colors.green)),
            ],
          ),
        ),
        Column(
          children: [
            IconButton(icon: Icon(Icons.close), onPressed: () {}),
            
          ],
        ),
      ],
    );
  }

  Widget _buildOrderSummary() {
    return Expanded(
      child: Card(
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Order Summary',
                  style: TextStyle(fontWeight: FontWeight.bold)),
              SizedBox(height: 16),
              _buildSummaryRow('Total Biaya Bulanan', 'Rp. 1.812.00'),
              _buildSummaryRow('Biaya Obat', 'Rp. 99.00'),
              _buildSummaryRow('Biaya Luar Pelayanan', 'Rp 2.711.00'),
              Divider(),
              _buildSummaryRow('Total Biaya', 'Rp. 1,911.00', isTotal: true),
              SizedBox(height: 16),
              Text('Payment Details',
                  style: TextStyle(fontWeight: FontWeight.bold)),
              SizedBox(height: 8),
              DropdownButtonFormField<String>(
                value: selectedPaymentMode,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Select Payment Mode',
                ),
                items: ['BCA', 'BRI', 'BNI', 'BSI', 'OTHER', 'CASH']
                    .map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                onChanged: (String? newValue) {
                  setState(() {
                    selectedPaymentMode = newValue;
                  });
                  // Additional logic here
                },
              ),
              SizedBox(height: 8),
              TextFormField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'No Transfer',
                ),
              ),
              Gap(8),
              TextFormField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Nama Pengirim',
                ),
              ),
              SizedBox(height: 8),
              Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Month',
                      ),
                    ),
                  ),
                  SizedBox(width: 8),
                  Expanded(
                    child: TextFormField(
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Year',
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {},
                child: Text(
                  'Cetak Tagihan',
                  style: TextStyle(color: Colors.white),
                ),
                style: ElevatedButton.styleFrom(
                  primary: Colors.blue,
                  minimumSize: Size(double.infinity, 50),
                ),
              ),
              Gap(8),
              ElevatedButton(
                onPressed: () {},
                child: Text(
                  'Verifikasi Pembayaran',
                  style: TextStyle(color: Colors.white),
                ),
                style: ElevatedButton.styleFrom(
                  primary: Colors.green,
                  minimumSize: Size(double.infinity, 50),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSummaryRow(String label, String value, {bool isTotal = false}) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label,
              style: isTotal ? TextStyle(fontWeight: FontWeight.bold) : null),
          Text(value,
              style: isTotal
                  ? TextStyle(fontWeight: FontWeight.bold, color: Colors.green)
                  : null),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';

class CheckoutPageManual extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'a checkout is a counter where you pay for things you are buying',
                style: TextStyle(fontSize: 16.0),
              ),
              SizedBox(height: 16.0),
              Text(
                '1. Contact Information',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8.0),
              Row(
                children: [
                  Text('Fredrik jr.'),
                  SizedBox(width: 8.0),
                  Text('Ivarssol'),
                ],
              ),
              Row(
                children: [
                  Icon(Icons.phone),
                  SizedBox(width: 8.0),
                  Text('+46 311 223 721'),
                ],
              ),
              Row(
                children: [
                  Icon(Icons.email),
                  SizedBox(width: 8.0),
                  Text('Fredrikjr@readysetgaps.com'),
                ],
              ),
              SizedBox(height: 16.0),
              Text(
                '2. Delivery method',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8.0),
              Row(
                children: [
                  ElevatedButton(
                    onPressed: () {},
                    child: Text('Same-day'),
                  ),
                  SizedBox(width: 8.0),
                  ElevatedButton(
                    onPressed: () {},
                    child: Text('Express'),
                  ),
                  SizedBox(width: 8.0),
                  ElevatedButton(
                    onPressed: () {},
                    child: Text('Normal'),
                  ),
                  SizedBox(width: 8.0),
                  ElevatedButton(
                    onPressed: () {},
                    child: Text('05488'),
                  ),
                ],
              ),
              SizedBox(height: 16.0),
              Text(
                '3. Payment method',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8.0),
              Row(
                children: [
                  ElevatedButton(
                    onPressed: () {},
                    child: Text('DPay'),
                  ),
                  SizedBox(width: 8.0),
                  ElevatedButton(
                    onPressed: () {},
                    child: Text('ePay'),
                  ),
                  SizedBox(width: 8.0),
                  ElevatedButton(
                    onPressed: () {},
                    child: Text('GPay'),
                  ),
                ],
              ),
              SizedBox(height: 16.0),
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Mr. Fredrik Ivarssol'),
                          Icon(Icons.credit_card),
                        ],
                      ),
                      SizedBox(height: 8.0),
                      Image.network(
                        'https://kanisius.sch.id/assets/default-07d309ca.png',
                        height: 100.0,
                      ),
                      SizedBox(height: 16.0),
                      Text('36 items'),
                      SizedBox(height: 8.0),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Subtotal'),
                          Text('€581.00'),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Discount'),
                          Text('-€300.1319'),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Delivery Service'),
                          Text('+€3.0'),
                        ],
                      ),
                      Divider(),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Total',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          Text(
                            '€449.00',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                      SizedBox(height: 16.0),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () {},
                          child: Text('Pay'),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        
      ),
    );
  }
}
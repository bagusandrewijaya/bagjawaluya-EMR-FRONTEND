
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:sibagjaapps/controllers/providers/P_PenggunaProvider.dart';

class ModalUsersForms extends StatelessWidget {
  ProviderPengguna p;
   ModalUsersForms({
    Key? key,
    required this.p,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StatefulBuilder(
        builder: (BuildContext context, setState) {
      return Container(
        height: MediaQuery.of(context).size.height * 0.8,
        margin: EdgeInsets.only(bottom: 31),
        decoration: BoxDecoration(
          color: Color(0xFF1E1E2E), // Dark background color
          borderRadius: BorderRadius.circular(8),
        ),
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Users / ',
                style: TextStyle(color: Colors.grey)),
            SizedBox(height: 8),
            Container(
              decoration: BoxDecoration(
                color: Color(0xFF2A2A3A),
                borderRadius: BorderRadius.circular(8),
              ),
              padding: EdgeInsets.symmetric(
                  horizontal: 16, vertical: 0),
              child: TextField(
                controller: p.namaLkp,
                decoration: InputDecoration(
                  hintText: 'Masukan Nama',
                  hintStyle: TextStyle(color: Colors.grey),
                  border: InputBorder.none,
                ),
                style: TextStyle(color: Colors.white),
              ),
            ),
            SizedBox(height: 16),
            Text('Masukan Username',
                style: TextStyle(color: Colors.grey)),
            SizedBox(height: 8),
            Container(
              decoration: BoxDecoration(
                color: Color(0xFF2A2A3A),
                borderRadius: BorderRadius.circular(8),
              ),
              padding: EdgeInsets.symmetric(
                  horizontal: 16, vertical: 0),
              child: TextField(
                controller: p.username,
                decoration: InputDecoration(
                  hintText: 'Masukan Username untuk login',
                  hintStyle: TextStyle(color: Colors.grey),
                  border: InputBorder.none,
                ),
                style: TextStyle(color: Colors.white),
              ),
            ),
            Gap(8),
            Container(
              decoration: BoxDecoration(
                color: Color(0xFF2A2A3A),
                borderRadius: BorderRadius.circular(8),
              ),
              padding: EdgeInsets.symmetric(
                  horizontal: 16, vertical: 0),
              child: TextField(
                controller: p.notlpn,
                decoration: InputDecoration(
                  hintText: 'Masukan No tlpn',
                  hintStyle: TextStyle(color: Colors.grey),
                  border: InputBorder.none,
                ),
                style: TextStyle(color: Colors.white),
              ),
            ),
            Gap(8),
            Container(
              decoration: BoxDecoration(
                color: Color(0xFF2A2A3A),
                borderRadius: BorderRadius.circular(8),
              ),
              padding: EdgeInsets.symmetric(
                  horizontal: 16, vertical: 0),
              child: TextField(
                controller: p.alamat,
                minLines: 1,
                maxLines: 3,
                decoration: InputDecoration(
                  hintText: 'Masukan Alamat',
                  hintStyle: TextStyle(color: Colors.grey),
                  border: InputBorder.none,
                ),
                style: TextStyle(color: Colors.white),
              ),
            ),
            Gap(8),
            Text('Level Pengguna',
                style: TextStyle(color: Colors.grey)),
            Gap(8),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 12),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey),
                borderRadius: BorderRadius.circular(8),
              ),
              child: DropdownButtonHideUnderline(
                child: DropdownButton<String>(
                  value: p.selectedDropdownForInsert,
                  style: TextStyle(color: Colors.red),
                  items: p.dropdown.map((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                  onChanged: (value) {
                    p.changelevelpengguna(value);
                    setState(() {
                      print(value);
                    });
                  },
                ),
              ),
            ),
            SizedBox(height: 16),
            Text('Password',
                style: TextStyle(color: Colors.grey)),
            SizedBox(height: 8),
            Row(
              children: [
                Expanded(
                  child: Container(
                    height: 50, // Add a fixed height
                    decoration: BoxDecoration(
                      color: Color(0xFF2A2A3A),
                      borderRadius:
                          BorderRadius.circular(8),
                    ),
                    padding: EdgeInsets.symmetric(
                        horizontal: 16),
                    child: TextFormField(
                      obscureText: true,
                      controller: p.password,
                      decoration: InputDecoration(
                        hintText: 'Masukan Password',
                        hintStyle:
                            TextStyle(color: Colors.grey),
                        border: InputBorder.none,
                      ),
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
                SizedBox(
                    width:
                        10), // Add some space between the fields
                Expanded(
                  child: Container(
                    height: 50, // Add a fixed height
                    decoration: BoxDecoration(
                      color: Color(0xFF2A2A3A),
                      borderRadius:
                          BorderRadius.circular(8),
                    ),
                    padding: EdgeInsets.symmetric(
                        horizontal: 16),
                    child: TextFormField(
                      obscureText: true,
                      controller: p.retypePasswd,
                      decoration: InputDecoration(
                        hintText: 'Konfirmasi Password',
                        hintStyle:
                            TextStyle(color: Colors.grey),
                        border: InputBorder.none,
                      ),
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),
            Gap(16),
            GestureDetector(
              onTap: () {
                p.Post(context);
              },
              child: Container(
                height: 50,
                decoration: BoxDecoration(
                  color: Color.fromARGB(255, 156, 156, 194),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Center(
                  child: Text(
                    'Tambah User',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ),
          ],
        ),
      );
    });
  }
}
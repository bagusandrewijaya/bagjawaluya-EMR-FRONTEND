// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:provider/provider.dart';

import 'package:sibagjaapps/models/M_Pengguna.dart';
import 'package:sibagjaapps/views/users/components/componentsModal.dart';

import '../../controllers/providers/P_PenggunaProvider.dart';

class DesignTeamPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => ProviderPengguna(),
      child: Consumer<ProviderPengguna>(builder: (context, p, w) {
        return Scaffold(
          backgroundColor: Colors.transparent,
          floatingActionButton: FloatingActionButton.extended(
            onPressed: () {
              showModalBottomSheet<dynamic>(
                isScrollControlled: true,
                backgroundColor: Colors.transparent,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.vertical(top: Radius.circular(8)),
                ),
                elevation: 0,
                context: context,
                builder: (BuildContext context) {
                  return BottomSheet(
                      backgroundColor: Colors.transparent,
                      onClosing: () {},
                      builder: (context) {
                        return ModalUsersForms(p: p,);
                      });
                },
              );
            },
            icon: Icon(
              Icons.add,
              color: Colors.white,
            ),
            label: Text(
              'Tambah Pengguna',
              style: TextStyle(color: Colors.white),
            ),
            backgroundColor: Color(0xFF2A2A3A),
          ),
          floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
          body: Row(
            children: [
              Expanded(
                flex: 3,
                child: Container(
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8)),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildHeader(),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        child: Row(
                          children: [
                            Expanded(
                              child: TextField(
                                controller: p.finderbyname,
                                decoration: InputDecoration(
                                  hintText: 'Search',
                                  prefixIcon: Icon(Icons.search),
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(8)),
                                ),
                              ),
                            ),
                            SizedBox(width: 16),
                            Container(
                              padding: EdgeInsets.symmetric(horizontal: 12),
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.grey),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: DropdownButtonHideUnderline(
                                child: DropdownButton<String>(
                                  value: p.selectedDropdown,
                                  items: p.dropdown.map((String value) {
                                    return DropdownMenuItem<String>(
                                      value: value,
                                      child: Text(value),
                                    );
                                  }).toList(),
                                  onChanged: (_) {
                                    p.changeDropdown(_!);
                                  },
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                          child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Wrap(
                          crossAxisAlignment: WrapCrossAlignment.start,
                          spacing: 8,
                          runSpacing: 8,
                          children: p.filteredData.map((item) {
                            return GestureDetector(
                              onTap: () {
                                p.selectedUserId(item.userId!);
                              },
                              child: SizedBox(
                                width: 250,
                                child: TeamMemberCard(
                                  name: item.nama!,
                                  role: item.deskripsi!,
                                  status: item.status!,
                                ),
                              ),
                            );
                          }).toList(),
                        ),
                      ))
                    ],
                  ),
                ),
              ),
              Gap(8),
              if (p.idUsers.isNotEmpty)
                Expanded(
                  flex: 1,
                  child: _buildSidebar(p),
                ),
              Gap(8)
            ],
          ),
        );
      }),
    );
  }

  Widget _buildHeader() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('People > Bagja Waluya', style: TextStyle(color: Colors.grey)),
          SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Akses Pengguna',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
              Row(
                children: [
                  CircleAvatar(backgroundColor: Colors.green, radius: 12),
                  CircleAvatar(backgroundColor: Colors.red, radius: 12),
                  SizedBox(width: 8),
                  Text('4',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSidebar(ProviderPengguna p) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(8)),
      padding: EdgeInsets.all(16),
      child: Column(
        children: [
          Row(
            children: [
              CircleAvatar(
                  radius: 24,
                  backgroundImage: AssetImage('assets/images/admin.png')),
              SizedBox(width: 16),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('${p.idUsers}',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  Text('Art Director', style: TextStyle(color: Colors.grey)),
                ],
              ),
            ],
          ),
          SizedBox(height: 24),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Projects',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              SizedBox(height: 16),
              ProjectCard(
                  title: 'The Om',
                  subtitle: 'Meditation app',
                  color: Colors.green),
              SizedBox(height: 8),
              ProjectCard(
                  title: 'Pic.inc',
                  subtitle: 'Stock photo website',
                  color: Colors.orange),
              SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {},
                child: Text(
                  'Ganti Password',
                  style: TextStyle(color: Colors.white),
                ),
                style: ElevatedButton.styleFrom(
                  primary: Colors.blue,
                  minimumSize: Size(double.infinity, 40),
                ),
              ),
              Gap(8),
              ElevatedButton(
                onPressed: () {},
                child: Text(
                  'Simpan Perubahan',
                  style: TextStyle(color: Colors.white),
                ),
                style: ElevatedButton.styleFrom(
                  primary: Colors.blue,
                  minimumSize: Size(double.infinity, 40),
                ),
              ),
              Gap(8),
              ElevatedButton(
                onPressed: () {},
                child: Text(
                  'Hapus Akun',
                  style: TextStyle(color: Colors.white),
                ),
                style: ElevatedButton.styleFrom(
                  primary: Colors.redAccent,
                  minimumSize: Size(double.infinity, 40),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }

  Widget _buildStatistic() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('My Statistic',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        SizedBox(height: 16),
        CircularPercentIndicator(
          radius: 80.0,
          lineWidth: 8.0,
          percent: 0.75,
          center: Text("75%"),
          progressColor: Colors.blue,
        ),
        SizedBox(height: 8),
        Text('Productivity', style: TextStyle(color: Colors.grey)),
        Text('+20%', style: TextStyle(color: Colors.green)),
      ],
    );
  }
}

class TeamMemberCard extends StatelessWidget {
  final String name;
  final String role;
  final String status;

  const TeamMemberCard(
      {Key? key, required this.name, required this.role, required this.status})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            CircleAvatar(
                radius: 32,
                backgroundImage: AssetImage('assets/images/admin.png')),
            SizedBox(height: 8),
            Text(name,
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            Text(role, style: TextStyle(color: Colors.grey)),
            SizedBox(height: 16),
            // Row(
            //   mainAxisAlignment: MainAxisAlignment.spaceAround,
            //   children: [
            //     _buildStat('Projects', projects),
            //     _buildStat('Done', done),
            //     _buildStat('Progress', projects - done),
            //   ],
            // ),
            SizedBox(height: 8),
            LinearProgressIndicator(
              value: 100,
              backgroundColor: Colors.grey[200],
              valueColor: AlwaysStoppedAnimation<Color>(
                  status == "1" ? Colors.blue : Colors.red),
            ),
            SizedBox(height: 4),
          ],
        ),
      ),
    );
  }

  Widget _buildStat(String label, int value) {
    return Column(
      children: [
        Text(value.toString(), style: TextStyle(fontWeight: FontWeight.bold)),
        Text(label, style: TextStyle(fontSize: 12, color: Colors.grey)),
      ],
    );
  }
}

class ProjectCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final Color color;

  const ProjectCard({
    Key? key,
    required this.title,
    required this.subtitle,
    required this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(Icons.work, color: Colors.white),
          ),
          SizedBox(width: 12),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title, style: TextStyle(fontWeight: FontWeight.bold)),
              Text(subtitle, style: TextStyle(color: Colors.grey)),
            ],
          ),
        ],
      ),
    );
  }
}

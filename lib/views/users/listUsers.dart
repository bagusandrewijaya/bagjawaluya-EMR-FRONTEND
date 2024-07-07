
import 'package:flutter/material.dart';

class MemberList extends StatelessWidget {
  final List<Map<String, dynamic>> members = [
    {
      'name': 'Breathe Skipp',
      'email': 'breatheskipp@gmail.com',
      'role': 'Member',
      'lastLogin': '—',
      'dateAdded': 'Pending',
      'avatar': 'BS',
      'isPending': true,
    },
    {
      'name': 'Onmu Juggs',
      'email': 'onmujuggs@gmail.com',
      'role': 'Supervisor',
      'lastLogin': '5 min ago',
      'dateAdded': 'Today',
      'avatar': 'OJ',
      'isPending': false,
    },
    {
      'name': 'Zainab Angeleski',
      'email': 'zainab.ange@gmail.com',
      'role': 'Sub admin',
      'lastLogin': 'Online',
      'dateAdded': 'Jun 24, 2023',
      'avatar': 'ZA',
      'isPending': false,
    },
    // Tambahkan data anggota lainnya di sini
  ];

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: DataTable(
        columns: [
          DataColumn(label: Text('MEMBER')),
          DataColumn(label: Text('ROLE')),
          DataColumn(label: Text('LAST LOGIN')),
          DataColumn(label: Text('DATE ADDED')),
          DataColumn(label: Text('')),
        ],
        rows: members.map((member) {
          return DataRow(cells: [
            DataCell(Row(
              children: [
                CircleAvatar(
                  child: Text(member['avatar']),
                  backgroundColor: Colors.grey[300],
                ),
                SizedBox(width: 10),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(member['name']),
                    Text(member['email'], style: TextStyle(color: Colors.grey, fontSize: 12)),
                  ],
                ),
              ],
            )),
            DataCell(Text(member['role'])),
            DataCell(Text(member['lastLogin'], style: TextStyle(color: member['lastLogin'] == 'Online' ? Colors.green : Colors.black))),
            DataCell(
              member['isPending']
                  ? Row(
                      children: [
                        Text(member['dateAdded']),
                        SizedBox(width: 5),
                        Text('Resend invite', style: TextStyle(color: Colors.blue)),
                      ],
                    )
                  : Text(member['dateAdded']),
            ),
            DataCell(Icon(Icons.more_horiz)),
          ]);
        }).toList(),
      ),
    );
  }
}
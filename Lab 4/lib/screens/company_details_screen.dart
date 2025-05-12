import 'package:flutter/material.dart';

class CompanyDetailsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Company Details'),
        backgroundColor: Colors.blueAccent,
      ),
      body: ListView(
        padding: const EdgeInsets.all(8),
        children: <Widget>[
          Card(
            elevation: 4,
            child: ListTile(
              title: Text('Company Name: XYZ Corp'),
              subtitle: Text('Location: Mumbai\nSalary Range: \$5,000 - \$7,000\nShort Profile: Software Development'),
            ),
          ),
          Card(
            elevation: 4,
            child: ListTile(
              title: Text('Company Name: ABC Ltd'),
              subtitle: Text('Location: Pune\nSalary Range: \$4,000 - \$6,000\nShort Profile: Marketing and Sales'),
            ),
          ),
          Card(
            elevation: 4,
            child: ListTile(
              title: Text('Company Name: PQR Inc'),
              subtitle: Text('Location: Bangalore\nSalary Range: \$6,000 - \$8,000\nShort Profile: Data Science and Analytics'),
            ),
          ),
          Card(
            elevation: 4,
            child: ListTile(
              title: Text('Company Name: LMN Tech'),
              subtitle: Text('Location: Hyderabad\nSalary Range: \$7,000 - \$9,000\nShort Profile: Cloud Computing and DevOps'),
            ),
          ),
        ],
      ),
    );
  }
}
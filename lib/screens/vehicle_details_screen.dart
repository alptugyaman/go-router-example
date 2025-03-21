import 'package:flutter/material.dart';

class VehicleDetailsScreen extends StatelessWidget {
  final String id;

  const VehicleDetailsScreen({
    super.key,
    required this.id,
  });

  @override
  Widget build(BuildContext context) {
    // In a real app, you would fetch vehicle details based on the ID
    // For demonstration, we'll create sample data
    Map<String, Map<String, String>> vehicleData = {
      '1': {
        'name': 'Togg T10X',
        'type': 'Electric Car',
        'year': '2024',
        'range': '555 miles',
        'status': 'Excellent'
      },
      '2': {
        'name': 'Tesla Model S',
        'type': 'Electric Car',
        'year': '2023',
        'range': '405 miles',
        'status': 'Nice'
      },
      '3': {
        'name': 'BYD Atto 3',
        'type': 'Electric Car',
        'year': '2021',
        'range': '333 miles',
        'status': 'Good'
      },
    };

    final vehicle = vehicleData[id] ??
        {
          'name': 'Unknown',
          'type': 'Unknown',
          'year': 'Unknown',
          'range': 'Unknown',
          'status': 'Unknown'
        };

    return Scaffold(
      appBar: AppBar(
        title: Text(vehicle['name']!),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Icon(
                Icons.directions_car,
                size: 120,
                color: Theme.of(context).primaryColor,
              ),
            ),
            const SizedBox(height: 20),
            InfoCard(
              title: 'Vehicle Information',
              items: [
                {'label': 'Name', 'value': vehicle['name']!},
                {'label': 'Type', 'value': vehicle['type']!},
                {'label': 'Year', 'value': vehicle['year']!},
                {'label': 'Range', 'value': vehicle['range']!},
                {'label': 'Status', 'value': vehicle['status']!},
              ],
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                minimumSize: const Size(double.infinity, 50),
              ),
              child: const Text('Schedule Maintenance'),
            ),
          ],
        ),
      ),
    );
  }
}

class InfoCard extends StatelessWidget {
  final String title;
  final List<Map<String, String>> items;

  const InfoCard({
    super.key,
    required this.title,
    required this.items,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            ...items.map((item) => Padding(
                  padding: const EdgeInsets.only(bottom: 8.0),
                  child: Row(
                    children: [
                      Text(
                        '${item['label']}: ',
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Text(item['value']!),
                    ],
                  ),
                )),
          ],
        ),
      ),
    );
  }
}

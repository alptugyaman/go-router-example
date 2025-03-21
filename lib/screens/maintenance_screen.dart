import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:go_router_example/core/router/route_constants.dart';

class MaintenanceScreen extends StatelessWidget {
  const MaintenanceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Sample maintenance records
    final maintenanceRecords = [
      {
        'title': 'Oil Change',
        'date': '2023-10-15',
        'status': 'Completed',
        'icon': Icons.check_circle,
        'iconColor': Colors.green,
      },
      {
        'title': 'Tire Rotation',
        'date': '2023-11-20',
        'status': 'Scheduled',
        'icon': Icons.schedule,
        'iconColor': Colors.orange,
      },
      {
        'title': 'Brake Inspection',
        'date': '2023-12-05',
        'status': 'Pending',
        'icon': Icons.pending,
        'iconColor': Colors.blue,
      },
      {
        'title': 'Annual Service',
        'date': '2024-01-10',
        'status': 'Scheduled',
        'icon': Icons.schedule,
        'iconColor': Colors.orange,
      },
    ];

    return Scaffold(
      appBar: AppBar(
        leading: BackButton(
          onPressed: () {
            context.go(RouteConstants.route.home);
          },
        ),
        title: const Text('Maintenance'),
      ),
      body: Column(
        children: [
          // Maintenance summary card
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Card(
              elevation: 4,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    const Text(
                      'Maintenance Summary',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        _buildSummaryItem(
                          context,
                          'Completed',
                          '1',
                          Icons.check_circle,
                          Colors.green,
                        ),
                        _buildSummaryItem(
                          context,
                          'Scheduled',
                          '2',
                          Icons.schedule,
                          Colors.orange,
                        ),
                        _buildSummaryItem(
                          context,
                          'Pending',
                          '1',
                          Icons.pending,
                          Colors.blue,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),

          Expanded(
            child: ListView.builder(
              itemCount: maintenanceRecords.length,
              itemBuilder: (context, index) {
                final record = maintenanceRecords[index];
                return ListTile(
                  leading: Icon(
                    record['icon'] as IconData,
                    color: record['iconColor'] as Color,
                  ),
                  title: Text(record['title'] as String),
                  subtitle: Text('Date: ${record['date']}'),
                  trailing: Chip(
                    label: Text(
                      record['status'] as String,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                      ),
                    ),
                    backgroundColor: (record['iconColor'] as Color),
                  ),
                  onTap: () {
                    // In a real app, navigate to maintenance detail screen
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSummaryItem(
    BuildContext context,
    String label,
    String count,
    IconData icon,
    Color color,
  ) {
    return Column(
      children: [
        Icon(icon, color: color, size: 30),
        const SizedBox(height: 8),
        Text(
          count,
          style: const TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(label),
      ],
    );
  }
}

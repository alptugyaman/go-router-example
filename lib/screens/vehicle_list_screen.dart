import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:go_router_example/core/router/route_constants.dart';

class VehicleListScreen extends StatelessWidget {
  const VehicleListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final vehicles = [
      {'id': '1', 'name': 'Togg T10X', 'type': 'Electric Car'},
      {'id': '2', 'name': 'Tesla Model S', 'type': 'Electric Car'},
      {'id': '3', 'name': 'BYD Atto 3', 'type': 'Electric Car'},
    ];

    return Scaffold(
      appBar: AppBar(
        leading: BackButton(
          onPressed: () {
            context.go(RouteConstants.route.home);
          },
        ),
        title: const Text('Your Vehicles'),
      ),
      body: ListView.builder(
        itemCount: vehicles.length,
        itemBuilder: (context, index) {
          final vehicle = vehicles[index];

          return ListTile(
            leading: const Icon(Icons.directions_car),
            title: Text(vehicle['name']!),
            subtitle: Text(vehicle['type']!),
            trailing: const Icon(Icons.arrow_forward_ios, size: 16),
            onTap: () {
              context
                  .go('${RouteConstants.route.vehicleList}/${vehicle['id']}');
            },
          );
        },
      ),
    );
  }
}

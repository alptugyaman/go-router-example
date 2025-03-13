import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:go_router_example/core/router/route_constants.dart';

class SmartMainScreen extends StatelessWidget {
  const SmartMainScreen({
    required this.child,
    super.key,
  });

  final Widget child;

  @override
  Widget build(BuildContext context) {
    int calculateSelectedIndex() {
      final String location = GoRouterState.of(context).uri.path;

      if (location == RouteConstants.route.smart) {
        return 0;
      } else if (location == RouteConstants.route.vehicleList) {
        return 1;
      } else if (location == RouteConstants.route.maintenance) {
        return 2;
      } else {
        return 0;
      }
    }

    void onItemTapped(int index) {
      final activeIndex = calculateSelectedIndex();

      if (activeIndex == index) return;

      final String route = switch (index) {
        0 => RouteConstants.route.smart,
        1 => RouteConstants.route.vehicleList,
        2 => RouteConstants.route.maintenance,
        _ => RouteConstants.route.smart
      };

      context.go(route);
    }

    return Scaffold(
      body: child,
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.smart_button),
            label: 'Smart',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.car_crash),
            label: 'Vehicle',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Maintenance',
          ),
        ],
        currentIndex: calculateSelectedIndex(),
        onTap: (int index) => onItemTapped(index),
      ),
    );
  }
}

class SmartScreen extends StatelessWidget {
  const SmartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(onPressed: context.pop),
        title: const Text('Smart'),
      ),
      body: const Center(
        child: Text('Smart'),
      ),
    );
  }
}

class VehicleListScreen extends StatelessWidget {
  const VehicleListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(onPressed: context.pop),
        title: const Text('Vehicle List'),
      ),
      body: Material(
        child: ListView.builder(
          itemCount: 3,
          itemBuilder: (_, int index) {
            return ListTile(
              title: Text('Vehicle ${index + 1}'),
              onTap: () => context.go(
                '${RouteConstants.route.vehicleList}/${index + 1}',
              ),
            );
          },
        ),
      ),
    );
  }
}

class VehicleDetailsScreen extends StatelessWidget {
  const VehicleDetailsScreen({
    required this.id,
    super.key,
  });

  final String id;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Vehicle Details'),
      ),
      body: Center(
        child: Text(id),
      ),
    );
  }
}

class MaintenanceScreen extends StatelessWidget {
  const MaintenanceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(onPressed: context.pop),
        title: const Text('Maintenance'),
      ),
      body: const Center(
        child: Text('Maintenance'),
      ),
    );
  }
}

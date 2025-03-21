import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:go_router_example/core/router/route_constants.dart';

class SmartScreen extends StatelessWidget {
  const SmartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(
          onPressed: () {
            context.go(RouteConstants.route.home);
          },
        ),
        title: const Text('Smart Features'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.smart_toy, size: 80),
            const SizedBox(height: 20),
            const Text(
              'Smart Features',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            const Text(
              'Discover smart features for your connected experience',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }
}

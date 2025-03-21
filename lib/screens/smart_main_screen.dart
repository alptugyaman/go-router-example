import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class SmartMainScreen extends StatelessWidget {
  final StatefulNavigationShell shell;

  const SmartMainScreen({
    required this.shell,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: shell,
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: shell.currentIndex,
        onTap: (index) => _onTap(context, index),
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.smart_toy),
            label: 'Smart',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.directions_car),
            label: 'Vehicles',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.build),
            label: 'Maintenance',
          ),
        ],
      ),
    );
  }

  void _onTap(BuildContext context, int index) {
    shell.goBranch(
      index,
      initialLocation: index == shell.currentIndex,
    );
  }
}

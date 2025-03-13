import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:go_router_example/core/router/route_constants.dart';

class EarnMasterScreen extends StatelessWidget {
  const EarnMasterScreen({
    required this.child,
    super.key,
  });

  final Widget child;

  @override
  Widget build(BuildContext context) {
    int calculateSelectedIndex() {
      final String location = GoRouterState.of(context).uri.path;

      if (location == RouteConstants.route.wallet) {
        return 0;
      } else if (location == RouteConstants.route.campaign) {
        return 1;
      } else {
        return 0;
      }
    }

    void onItemTapped(int index) {
      final activeIndex = calculateSelectedIndex();

      if (activeIndex == index) return;

      final String route = switch (index) {
        0 => RouteConstants.route.wallet,
        1 => RouteConstants.route.campaign,
        _ => RouteConstants.route.wallet
      };

      context.go(route);
    }

    return Scaffold(
      appBar: AppBar(
        leading: BackButton(
          onPressed: () => context.go(RouteConstants.route.home),
        ),
        title: const Text('Earn'),
      ),
      body: child,
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.monetization_on),
            label: 'Wallet',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.campaign),
            label: 'Campaign',
          ),
        ],
        currentIndex: calculateSelectedIndex(),
        onTap: (int index) => onItemTapped(index),
      ),
    );
  }
}

class WalletScreen extends StatelessWidget {
  const WalletScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: const Center(child: Text('Wallet')),
      floatingActionButton: FloatingActionButton(
        onPressed: () => context.push(RouteConstants.route.moneyTransfer),
        child: const Center(
          child: Text('Send'),
        ),
      ),
    );
  }
}

class MoneyTransferScreen extends StatelessWidget {
  const MoneyTransferScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Money Transfer'),
      ),
      body: const Center(
        child: Padding(
          padding: EdgeInsets.all(32.0),
          child: Text(
            'This route uses a different\nparentNavigatorKey\nthan its parent',
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}

class CampaignScreen extends StatelessWidget {
  const CampaignScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: const Center(child: Text('Campaign')),
    );
  }
}

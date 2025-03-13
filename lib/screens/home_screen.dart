import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:go_router_example/core/cubits/auth_cubit.dart';
import 'package:go_router_example/core/router/route_constants.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home Screen'),
        centerTitle: true,
        leading: IconButton(
          onPressed: () => context.go('/somepage'),
          icon: const Icon(Icons.warning),
        ),
        actions: [
          IconButton(
            onPressed: () => context.go(RouteConstants.route.settings),
            icon: const Icon(Icons.settings),
          ),
          IconButton(
            onPressed: () => context.go(
              RouteConstants.route.profile,
              extra: 'Alptuğ',
            ),
            icon: const Icon(Icons.person),
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextButton(
              onPressed: () => context.push(RouteConstants.route.wallet),
              child: const Text('Earn Shell Route'),
            ),
            TextButton(
              onPressed: () => context.push(RouteConstants.route.smart),
              child: const Text('Smart Shell Route'),
            ),
            TextButton(
              onPressed: () => context.push(RouteConstants.route.counter),
              child: const Text('Counter Route'),
            ),
            TextButton(
              onPressed: () => context.push(RouteConstants.route.microApp),
              child: const Text('Micro App Route'),
            ),
            ElevatedButton(
              onPressed: () {
                final uri = Uri.parse(
                  'gorouter://example.com/home/counter/child',
                );

                if (uri.scheme == 'gorouter') {
                  context.go(uri.path);

                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text(uri.toString())),
                  );
                }
              },
              child: const Text('Dynamic Link for Counter Child'),
            ),
            ElevatedButton(
              onPressed: () {
                final uri = Uri.parse(
                  'gorouter://example.com/home/vehicle-list/1',
                );

                if (uri.scheme == 'gorouter') {
                  context.go(
                    uri.path,
                    extra: {'queryParams': uri.queryParameters},
                  );

                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text(uri.toString())),
                  );
                }
              },
              child: const Text('Dynamic Link for Vehicle List'),
            ),

            // Avoid using extra and queryParams together unless absolutely necessary.
            // Otherwise, some additional logic might be required. See router line 79.
            ElevatedButton(
              onPressed: () {
                final uri = Uri.parse(
                  'gorouter://example.com/home/micro-app/shop?title=Shop&image=https://toggprodcdn.blob.core.windows.net/images/micro_app_icons_v2/Toggcare.jpg&link=/home/micro-app/shop',
                );

                context.go(
                  uri.path,
                  extra: {'queryParams': uri.queryParameters},
                );

                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text(uri.toString())),
                );
              },
              child: const Text('Dynamic Link for Shop Micro App'),
            ),
          ],
        ),
      ),
    );
  }
}

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings Screen'),
      ),
      body: Center(
        child: Text('Settings Screen'),
      ),
    );
  }
}

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({
    super.key,
    required this.name,
  });

  final String name;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('$name\'s Profile Screen')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            BlocListener<AuthCubit, bool>(
              listener: (context, state) {
                if (!state) {
                  // TEST - MUST BE REDIRECT TO INITIAL ROUTE
                  context.go(RouteConstants.route.home);
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Sign out failed')),
                  );
                }
              },
              child: ElevatedButton(
                onPressed: () => context.read<AuthCubit>().signOut(),
                child: const Text('Sign Out'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

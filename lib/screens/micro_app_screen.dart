import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:go_router_example/core/cubits/auth_cubit.dart';
import 'package:go_router_example/core/data/micro_app_data.dart';
import 'package:go_router_example/core/models/micro_app_model.dart';
import 'package:go_router_example/core/router/route_constants.dart';

class MicroAppScreen extends StatelessWidget {
  const MicroAppScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;

    return Scaffold(
      appBar: AppBar(title: const Text('Micro App Screen')),
      body: FutureBuilder(
        future: Future.delayed(const Duration(seconds: 1), () {
          return MicroAppData.microApps;
        }),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            final apps = snapshot.data ?? [];
            final List<MicroAppModel> mobilityApps =
                apps.map((e) => MicroAppModel.fromJson(e)).toList();

            return ListView.separated(
              separatorBuilder: (context, index) => const SizedBox(height: 20),
              itemCount: mobilityApps.length,
              itemBuilder: (context, index) {
                final app = mobilityApps[index];

                return GestureDetector(
                  onTap: () {
                    context.go(
                      app.link ?? '',
                      extra: app,
                    );
                  },
                  child: SizedBox(
                    width: width * 0.25,
                    height: width * 0.25,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.network(
                          app.image ?? '',
                          fit: BoxFit.cover,
                          width: width * 0.2,
                          height: width * 0.2,
                        ),
                        Text(
                          app.link ?? '',
                          style: Theme.of(context).textTheme.bodySmall,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 3,
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: BlocListener<AuthCubit, bool>(
          listener: (context, state) {
            if (!state) {
              context.go(RouteConstants.route.splash);
            } else {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Sign out failed')),
              );
            }
          },
          child: FloatingActionButton(
            onPressed: () {
              context.read<AuthCubit>().signOut();
            },
            child: Text(
              'Sign Out',
              textAlign: TextAlign.center,
            ),
          )),
    );
  }
}

class ShopMicroAppScreen extends StatelessWidget {
  const ShopMicroAppScreen({
    required this.microApp,
    super.key,
  });

  final MicroAppModel microApp;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(microApp.title ?? '')),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        spacing: 20,
        children: [
          Center(
            child: Image.network(
              microApp.image ?? '',
              fit: BoxFit.cover,
              width: 200,
              height: 200,
            ),
          ),
          ElevatedButton(
            onPressed: () {
              context.go(RouteConstants.route.home);
            },
            child: const Text('HOME'),
          )
        ],
      ),
    );
  }
}

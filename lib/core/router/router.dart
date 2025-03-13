import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:go_router_example/core/cubits/auth_cubit.dart';
import 'package:go_router_example/core/cubits/counter_cubit.dart';
import 'package:go_router_example/core/models/micro_app_model.dart';
import 'package:go_router_example/core/router/app_models_codec.dart';
import 'package:go_router_example/core/router/route_constants.dart';
import 'package:go_router_example/screens/auth_screen.dart';
import 'package:go_router_example/screens/counter_screen.dart';
import 'package:go_router_example/screens/earn_main_screen.dart';
import 'package:go_router_example/screens/home_screen.dart';
import 'package:go_router_example/screens/micro_app_screen.dart';
import 'package:go_router_example/screens/not_found_screen.dart';
import 'package:go_router_example/screens/smart_main_screen.dart';

final _rootNavigatorKey = GlobalKey<NavigatorState>(debugLabel: 'root');
final _earnNavigatorKey = GlobalKey<NavigatorState>(debugLabel: 'earn_main');

final GoRouter router = GoRouter(
  initialLocation: RouteConstants.route.home,
  navigatorKey: _rootNavigatorKey,
  debugLogDiagnostics: true,
  extraCodec: const AppModelsCodec(),
  routes: [
    GoRoute(
      path: RouteConstants.path.splash,
      builder: (_, __) => const SplashScreen(),
    ),
    GoRoute(
      path: RouteConstants.path.auth,
      builder: (_, __) => const AuthScreen(),
    ),
    GoRoute(
      path: RouteConstants.path.login,
      builder: (_, __) => const LoginScreen(),
    ),
    GoRoute(
      path: RouteConstants.path.register,
      builder: (_, __) => const RegisterScreen(),
    ),
    GoRoute(
      path: RouteConstants.path.home,
      redirect: (BuildContext context, _) {
        if (context.read<AuthCubit>().state == false) {
          return RouteConstants.route.splash;
        } else {
          return null;
        }
      },
      builder: (_, __) => const HomeScreen(),
      routes: [
        GoRoute(
          path: RouteConstants.path.microApp,
          builder: (_, __) => const MicroAppScreen(),
          routes: [
            GoRoute(
              path: RouteConstants.path.shopMicroApp,
              builder: (_, GoRouterState state) {
                if (state.extra is MicroAppModel) {
                  return ShopMicroAppScreen(
                    microApp: state.extra as MicroAppModel,
                  );
                }

                if (state.extra is! MicroAppModel) {
                  final extra = state.extra as Map<String, dynamic>;
                  final queryParams = extra["queryParams"];
                  final app = MicroAppModel.fromJson(queryParams);

                  return ShopMicroAppScreen(
                    microApp: app,
                  );
                }

                return const NotFoundScreen();
              },
            ),
          ],
        ),
        GoRoute(
          path: RouteConstants.path.settings,
          builder: (_, __) => SettingsScreen(),
        ),
        GoRoute(
          path: RouteConstants.path.profile,
          builder: (_, GoRouterState state) => ProfileScreen(
            name: state.extra as String,
          ),
        ),
        ShellRoute(
          builder: (_, __, Widget child) {
            return BlocProvider(
              create: (context) => CounterCubit(),
              child: child,
            );
          },
          routes: [
            GoRoute(
              path: RouteConstants.path.counter,
              builder: (_, __) => const CounterScreen(),
              routes: [
                GoRoute(
                  path: RouteConstants.path.counterChild,
                  builder: (_, __) => const CounterChildScreen(),
                ),
              ],
            ),
          ],
        ),
        ShellRoute(
          navigatorKey: _earnNavigatorKey,
          builder: (_, __, Widget child) => EarnMasterScreen(child: child),
          routes: [
            GoRoute(
              parentNavigatorKey: _earnNavigatorKey,
              path: RouteConstants.path.wallet,
              builder: (_, __) => const WalletScreen(),
              routes: [
                GoRoute(
                  parentNavigatorKey: _rootNavigatorKey,
                  path: RouteConstants.path.moneyTransfer,
                  builder: (_, __) => const MoneyTransferScreen(),
                ),
              ],
            ),
            GoRoute(
              parentNavigatorKey: _earnNavigatorKey,
              path: RouteConstants.path.campaign,
              pageBuilder: (_, GoRouterState state) {
                return CustomTransitionPage<void>(
                  key: state.pageKey,
                  child: CampaignScreen(),
                  transitionDuration: const Duration(milliseconds: 500),
                  transitionsBuilder: (
                    BuildContext context,
                    Animation<double> animation,
                    Animation<double> secondaryAnimation,
                    Widget child,
                  ) {
                    const begin = Offset(0.0, 1.0);
                    const end = Offset.zero;
                    final tween = Tween(begin: begin, end: end);
                    final offsetAnimation = animation.drive(tween);

                    return SlideTransition(
                      position: offsetAnimation,
                      child: child,
                    );
                  },
                );
              },
            ),
          ],
        ),
        ShellRoute(
          parentNavigatorKey: _rootNavigatorKey,
          builder: (_, __, Widget child) => SmartMainScreen(child: child),
          routes: [
            GoRoute(
              path: RouteConstants.path.smart,
              builder: (_, __) => const SmartScreen(),
            ),
            GoRoute(
              path: RouteConstants.path.vehicleList,
              builder: (_, __) => const VehicleListScreen(),
              routes: [
                GoRoute(
                  path: RouteConstants.path.vehicleDetails,
                  builder: (_, GoRouterState state) => VehicleDetailsScreen(
                    id: state.pathParameters['id'] as String,
                  ),
                ),
              ],
            ),
            GoRoute(
              path: RouteConstants.path.maintenance,
              builder: (_, __) => const MaintenanceScreen(),
            ),
          ],
        ),
      ],
    ),
  ],
  errorBuilder: (context, state) => const NotFoundScreen(),
);

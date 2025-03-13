import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router_example/core/cubits/auth_cubit.dart';
import 'package:go_router_example/core/router/router.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AuthCubit(),
      child: MaterialApp.router(
        themeMode: ThemeMode.dark,
        darkTheme: ThemeData.dark(),
        routerConfig: router,
      ),
    );
  }
}

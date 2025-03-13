import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:go_router_example/core/cubits/auth_cubit.dart';
import 'package:go_router_example/core/router/route_constants.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Splash Screen')),
      body: FutureBuilder(
        future: Future.delayed(const Duration(seconds: 1), () {
          // ignore: use_build_context_synchronously
          context.go(RouteConstants.route.auth);
        }),
        builder: (context, snapshot) {
          return const Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}

class AuthScreen extends StatelessWidget {
  const AuthScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Auth Screen')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () => context.push(RouteConstants.route.login),
              child: const Text('Login'),
            ),
            const SizedBox(height: 25),
            ElevatedButton(
              onPressed: () => context.push(RouteConstants.route.register),
              child: const Text('Register'),
            ),
          ],
        ),
      ),
    );
  }
}

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Login Screen')),
      body: Center(
        child: BlocListener<AuthCubit, bool>(
          listener: (context, state) {
            if (state) {
              context.go(RouteConstants.route.home);
            } else {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Sign in failed')),
              );
            }
          },
          child: ElevatedButton(
            onPressed: () => context.read<AuthCubit>().signIn(),
            child: const Text('Sign In'),
          ),
        ),
      ),
    );
  }
}

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Register Screen')),
      body: Center(
        child: Text('Register Screen'),
      ),
    );
  }
}

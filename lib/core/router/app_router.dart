import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:serviko_admin/features/auth/presentation/screens/login_screen.dart';
import 'package:serviko_admin/features/dashboard/presentation/screens/dashboard_layout.dart';
import 'package:serviko_admin/features/dashboard/presentation/screens/dashboard_screen.dart';
import 'package:serviko_admin/features/providers/presentation/screens/providers_screen.dart';

// Navigator Keys
final _rootNavigatorKey = GlobalKey<NavigatorState>();
final _shellNavigatorKey = GlobalKey<NavigatorState>();

// App Router Configuration
final GoRouter appRouter = GoRouter(
  navigatorKey: _rootNavigatorKey,
  initialLocation: '/login',
  routes: [
    GoRoute(path: '/login', builder: (context, state) => const LoginScreen()),
    ShellRoute(
      navigatorKey: _shellNavigatorKey,
      builder: (context, state, child) {
        return DashboardLayout(child: child);
      },
      routes: [
        GoRoute(
          name: 'dashboard',
          path: '/dashboard',
          pageBuilder: (context, state) =>
              const NoTransitionPage(child: DashboardScreen()),
        ),
        GoRoute(
          name: 'providers',
          path: '/providers',
          pageBuilder: (context, state) =>
              const NoTransitionPage(child: ProvidersScreen()),
        ),
      ],
    ),
  ],
);

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:serviko_admin/features/auth/presentation/screens/login_screen.dart';
import 'package:serviko_admin/features/dashboard/presentation/screens/dashboard_layout.dart';
import 'package:serviko_admin/features/dashboard/presentation/screens/dashboard_screen.dart';
import 'package:serviko_admin/features/providers/presentation/screens/providers_screen.dart';
import 'package:serviko_admin/features/providers/presentation/screens/provider_details_screen.dart';
import 'package:serviko_admin/features/categories/presentation/screens/categories_screen.dart';
import 'package:serviko_admin/features/category_requests/presentation/screens/category_requests_screen.dart';

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
        GoRoute(
          name: 'categories',
          path: '/categories',
          pageBuilder: (context, state) =>
              const NoTransitionPage(child: CategoriesScreen()),
        ),
        GoRoute(
          name: 'category-requests',
          path: '/category-requests',
          pageBuilder: (context, state) =>
              const NoTransitionPage(child: CategoryRequestsScreen()),
        ),
        GoRoute(
          name: 'provider_details',
          path: '/providers/:id',
          pageBuilder: (context, state) {
            final id = state.pathParameters['id']!;
            return NoTransitionPage(
              child: ProviderDetailsScreen(providerId: id),
            );
          },
        ),
      ],
    ),
  ],
);

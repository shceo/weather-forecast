import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:weather_app/src/exports.dart';

abstract class AppRouter {
  static final GoRouter router = GoRouter(
    errorBuilder: (context, state) => const ErrorPage(),
    //
    routes: <RouteBase>[
      GoRoute(
        path: AppRoutes.home,
        builder: (BuildContext context, GoRouterState state) {
          return const HomePage();
        },  
      ),
          GoRoute(
            path: AppRoutes.search,
            builder: (BuildContext context, GoRouterState state) {
              return const SearchPage();
            },
          ),
    ],
  );
}









//  errorBuilder: (context, state) {
//       return const ErrorPage();
//     },
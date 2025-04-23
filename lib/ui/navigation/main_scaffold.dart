import 'package:cryptools/ui/navigation/routes.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class MainScaffold extends StatelessWidget {
  final Widget child;

  const MainScaffold({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    final location = GoRouterState.of(context).uri.path;
    final currentRouteIndex = bottomNavRoutes.indexWhere(
      (route) => location.startsWith(route.path),
    );
    final currentRoute = bottomNavRoutes[currentRouteIndex];

    return Scaffold(
      body: child,
      appBar: AppBar(title: Text(currentRoute.name ?? "")),
      bottomNavigationBar: NavigationBar(
        selectedIndex: currentRouteIndex >= 0 ? currentRouteIndex : 0,
        onDestinationSelected:
            (index) => context.go(bottomNavRoutesPath[index]),
        destinations: const [
          NavigationDestination(icon: Icon(Icons.tag), label: 'Hash'),
          NavigationDestination(icon: Icon(Icons.vpn_key), label: 'Encrypt'),
          NavigationDestination(icon: Icon(Icons.code), label: 'Enc-Dec'),
          NavigationDestination(icon: Icon(Icons.casino), label: 'Random'),
          NavigationDestination(icon: Icon(Icons.more_horiz), label: 'Others'),
        ],
      ),
    );
  }
}

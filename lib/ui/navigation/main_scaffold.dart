import 'package:cryptools/core/extensions.dart';
import 'package:cryptools/ui/navigation/routes.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

enum _ActionMenuItems { history, settings }

class _MainDestinations {
  const _MainDestinations({
    required this.label,
    required this.icon,
    this.selectedIcon,
  });

  final String label;
  final Widget icon;
  final Widget? selectedIcon;
}

const List<_MainDestinations> _destinations = <_MainDestinations>[
  _MainDestinations(
    label: 'Hash',
    icon: Icon(Icons.tag_outlined),
    selectedIcon: Icon(Icons.tag),
  ),
  _MainDestinations(
    label: 'Encrypt',
    icon: Icon(Icons.vpn_key_outlined),
    selectedIcon: Icon(Icons.vpn_key),
  ),
  _MainDestinations(
    label: 'Encode',
    icon: Icon(Icons.code_outlined),
    selectedIcon: Icon(Icons.code),
  ),
  _MainDestinations(
    label: 'Random',
    icon: Icon(Icons.casino_outlined),
    selectedIcon: Icon(Icons.casino),
  ),
  _MainDestinations(
    label: 'Others',
    icon: Icon(Icons.more_horiz_outlined),
    selectedIcon: Icon(Icons.more_horiz),
  ),
];

class MainScaffold extends StatefulWidget {
  final Widget child;

  const MainScaffold({super.key, required this.child});

  @override
  State<MainScaffold> createState() => _MainScaffoldState();
}

class _MainScaffoldState extends State<MainScaffold> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    final isWideScreen = context.isWideScreen();

    final location = GoRouterState.of(context).uri.path;
    final currentRouteIndex = bottomNavRoutes.indexWhere(
      (route) => location.startsWith(route.path),
    );

    return Scaffold(
      key: _scaffoldKey,
      appBar:
          isWideScreen
              ? null
              : AppBar(
                title: const Text('CrypTools'),
                actions: [
                  PopupMenuButton(
                    itemBuilder:
                        (context) => [
                          PopupMenuItem(
                            value: _ActionMenuItems.history.name,
                            child: const Text('History'),
                          ),
                          PopupMenuItem(
                            value: _ActionMenuItems.settings.name,
                            child: const Text('Settings'),
                          ),
                        ],
                    onSelected: (value) {
                      if (value == _ActionMenuItems.history.name) {
                        context.push(RoutePaths.history);
                      } else if (value == _ActionMenuItems.settings.name) {
                        context.push(RoutePaths.settings);
                      }
                    },
                  ),
                ],
              ),
      bottomNavigationBar:
          isWideScreen
              ? null
              : NavigationBar(
                selectedIndex: currentRouteIndex >= 0 ? currentRouteIndex : 0,
                onDestinationSelected:
                    (index) => context.go(bottomNavRoutesPath[index]),
                destinations:
                    _destinations
                        .map(
                          (destination) => NavigationDestination(
                            icon: destination.icon,
                            label: destination.label,
                            selectedIcon: destination.selectedIcon,
                          ),
                        )
                        .toList(),
              ),
      drawer:
          isWideScreen
              // TODO overflow on tablet
              ? NavigationDrawer(
                selectedIndex: currentRouteIndex >= 0 ? currentRouteIndex : 0,
                onDestinationSelected: (index) {
                  if (index <= bottomNavRoutesPath.length - 1) {
                    context.go(bottomNavRoutesPath[index]);
                  } else if (index == bottomNavRoutesPath.length) {
                    context.push(RoutePaths.history);
                  } else if (index == bottomNavRoutesPath.length + 1) {
                    context.push(RoutePaths.settings);
                  }
                },
                children: [
                  SizedBox(height: 20),
                  ..._destinations.map(
                    (destination) => NavigationDrawerDestination(
                      icon: destination.icon,
                      label: Text(destination.label),
                      selectedIcon: destination.selectedIcon,
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.fromLTRB(28, 16, 28, 10),
                    child: Divider(),
                  ),
                  const NavigationDrawerDestination(
                    icon: Icon(Icons.history),
                    label: Text('History'),
                  ),
                  const NavigationDrawerDestination(
                    icon: Icon(Icons.settings),
                    label: Text('Settings'),
                  ),
                ],
              )
              : null,
      body:
          isWideScreen
              ? Row(
                children: [
                  NavigationRail(
                    selectedIndex:
                        currentRouteIndex >= 0 ? currentRouteIndex : 0,
                    onDestinationSelected: (index) {
                      context.go(bottomNavRoutesPath[index]);
                    },
                    labelType: NavigationRailLabelType.all,
                    leading: IconButton(
                      onPressed: () {
                        _scaffoldKey.currentState?.openDrawer();
                      },
                      icon: const Icon(Icons.menu),
                    ),
                    destinations:
                        _destinations
                            .map(
                              (destination) => NavigationRailDestination(
                                icon: destination.icon,
                                label: Text(destination.label),
                                selectedIcon: destination.selectedIcon,
                              ),
                            )
                            .toList(),
                  ),
                  const VerticalDivider(width: 1),
                  Expanded(child: widget.child),
                ],
              )
              : widget.child,
    );
  }
}

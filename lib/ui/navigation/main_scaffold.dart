import 'package:cryptools/ui/navigation/routes.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

enum _ActionMenuItems { history, settings }

class MainScaffold extends StatelessWidget {
  final Widget child;

  const MainScaffold({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    final isWideScreen = MediaQuery.of(context).size.width >= 600;

    final location = GoRouterState.of(context).uri.path;
    final currentRouteIndex = bottomNavRoutes.indexWhere(
      (route) => location.startsWith(route.path),
    );

    // TODO break each components to separate widgets
    return Scaffold(
      appBar:
          isWideScreen
              ? null
              : AppBar(
                title: Text('CrypTools'),
                actions: [
                  PopupMenuButton(
                    itemBuilder:
                        (context) => [
                          PopupMenuItem(
                            value: _ActionMenuItems.history.name,
                            child: Text('History'),
                          ),
                          PopupMenuItem(
                            value: _ActionMenuItems.settings.name,
                            child: Text('Settings'),
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
                destinations: const [
                  NavigationDestination(icon: Icon(Icons.tag), label: 'Hash'),
                  NavigationDestination(
                    icon: Icon(Icons.vpn_key),
                    label: 'Encrypt',
                  ),
                  NavigationDestination(
                    icon: Icon(Icons.code),
                    label: 'Encode',
                  ),
                  NavigationDestination(
                    icon: Icon(Icons.casino),
                    label: 'Random',
                  ),
                  NavigationDestination(
                    icon: Icon(Icons.more_horiz),
                    label: 'Others',
                  ),
                ],
              ),
      body:
          isWideScreen
              ? Row(
                children: [
                  NavigationRail(
                    selectedIndex:
                        currentRouteIndex >= 0 ? currentRouteIndex : 0,
                    onDestinationSelected:
                        (index) => context.go(bottomNavRoutesPath[index]),
                    labelType: NavigationRailLabelType.all,
                    destinations: const [
                      NavigationRailDestination(
                        icon: Icon(Icons.tag),
                        label: Text('Hash'),
                      ),
                      NavigationRailDestination(
                        icon: Icon(Icons.vpn_key),
                        label: Text('Encrypt'),
                      ),
                      NavigationRailDestination(
                        icon: Icon(Icons.code),
                        label: Text('Encode'),
                      ),
                      NavigationRailDestination(
                        icon: Icon(Icons.casino),
                        label: Text('Random'),
                      ),
                      NavigationRailDestination(
                        icon: Icon(Icons.more_horiz),
                        label: Text('Others'),
                      ),
                    ],
                  ),
                  VerticalDivider(width: 1),
                  Expanded(
                    child: Column(
                      children: [
                        AppBar(
                          actions: [
                            PopupMenuButton(
                              itemBuilder:
                                  (context) => [
                                    PopupMenuItem(
                                      value: _ActionMenuItems.history.name,
                                      child: Text('History'),
                                    ),
                                    PopupMenuItem(
                                      value: _ActionMenuItems.settings.name,
                                      child: Text('Settings'),
                                    ),
                                  ],
                              onSelected: (value) {
                                if (value == _ActionMenuItems.history.name) {
                                  context.push(RoutePaths.history);
                                } else if (value ==
                                    _ActionMenuItems.settings.name) {
                                  context.push(RoutePaths.settings);
                                }
                              },
                            ),
                          ],
                        ),
                        Expanded(child: child),
                      ],
                    ),
                  ),
                ],
              )
              : child,
    );
  }
}

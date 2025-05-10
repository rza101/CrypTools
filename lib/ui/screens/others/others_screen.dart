import 'package:cryptools/core/extensions.dart';
import 'package:cryptools/ui/navigation/routes.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class _OtherScreenRoute {
  final String route;
  final IconData icon;
  final String title;

  const _OtherScreenRoute({
    required this.route,
    required this.icon,
    required this.title,
  });
}

final List<_OtherScreenRoute> _routeItems = [
  _OtherScreenRoute(
    route: RoutePaths.keyDerivation,
    icon: Icons.transform,
    title: 'Key Derivation',
  ),
  _OtherScreenRoute(
    route: RoutePaths.keygen,
    icon: Icons.enhanced_encryption,
    title: 'Key Generation',
  ),
];

class OthersScreen extends StatelessWidget {
  const OthersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: context.isWideScreen() ? const _GridItems() : const _ListItems(),
      ),
    );
  }
}

class _ListItems extends StatelessWidget {
  const _ListItems();

  @override
  Widget build(BuildContext context) {
    return Column(
      children:
          _routeItems
              .map(
                (item) => SizedBox(
                  height: 100,
                  child: Card(
                    clipBehavior: Clip.hardEdge,
                    child: InkWell(
                      onTap: () => context.push(item.route),
                      child: Center(
                        child: ListTile(
                          leading: Icon(item.icon),
                          title: Text(item.title),
                        ),
                      ),
                    ),
                  ),
                ),
              )
              .toList(),
    );
  }
}

class _GridItems extends StatelessWidget {
  const _GridItems();

  @override
  Widget build(BuildContext context) {
    return Wrap(
      children:
          _routeItems
              .map(
                (item) => SizedBox(
                  width: 200,
                  height: 200,
                  child: Card(
                    clipBehavior: Clip.hardEdge,
                    child: InkWell(
                      onTap: () => context.push(item.route),
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          spacing: 16,
                          children: [
                            Icon(item.icon, size: 40),
                            Text(item.title, textAlign: TextAlign.center),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              )
              .toList(),
    );
  }
}

import 'package:cryptools/ui/navigation/routes.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class OthersScreen extends StatelessWidget {
  static final _borderRadius = BorderRadius.all(Radius.circular(12));

  const OthersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            SizedBox(
              height: 100,
              child: Card(
                shape: RoundedRectangleBorder(borderRadius: _borderRadius),
                child: InkWell(
                  borderRadius: _borderRadius,
                  onTap: () => context.push(RoutePaths.keyDerivation),
                  child: Center(
                    child: ListTile(
                      leading: const Icon(Icons.transform),
                      title: const Text('Key Derivation'),
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 100,
              child: Card(
                shape: RoundedRectangleBorder(borderRadius: _borderRadius),
                child: InkWell(
                  borderRadius: _borderRadius,
                  onTap: () => context.push(RoutePaths.keygen),
                  child: Center(
                    child: ListTile(
                      leading: const Icon(Icons.enhanced_encryption),
                      title: const Text('Key Generation'),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

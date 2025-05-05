import 'package:cryptools/ui/navigation/routes.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class OthersScreen extends StatelessWidget {
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
                clipBehavior: Clip.hardEdge,
                child: InkWell(
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
                clipBehavior: Clip.hardEdge,
                child: InkWell(
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

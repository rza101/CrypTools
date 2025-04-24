import 'package:cryptools/ui/navigation/routes.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class OthersScreen extends StatelessWidget {
  const OthersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          ElevatedButton(
            onPressed: () => context.push(RoutePaths.hmac),
            child: const Text('HMAC'),
          ),
          ElevatedButton(
            onPressed: () => context.push(RoutePaths.keyDerivation),
            child: const Text('Key Derivation'),
          ),
          ElevatedButton(
            onPressed: () => context.push(RoutePaths.keygen),
            child: const Text('Key Generation'),
          ),
        ],
      ),
    );
  }
}

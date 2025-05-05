import 'package:cryptools/ui/screens/encode/encode_binding.dart';
import 'package:cryptools/ui/screens/encode/encode_screen.dart';
import 'package:cryptools/ui/screens/encrypt/encrypt_binding.dart';
import 'package:cryptools/ui/screens/encrypt/encrypt_screen.dart';
import 'package:cryptools/ui/screens/hash/hash_binding.dart';
import 'package:cryptools/ui/screens/hash/hash_screen.dart';
import 'package:cryptools/ui/screens/key_derivation/key_derivation_binding.dart';
import 'package:cryptools/ui/screens/key_derivation/key_derivation_screen.dart';
import 'package:cryptools/ui/screens/keygen/keygen_binding.dart';
import 'package:cryptools/ui/screens/keygen/keygen_screen.dart';
import 'package:cryptools/ui/screens/others/others_screen.dart';
import 'package:cryptools/ui/screens/random/random_binding.dart';
import 'package:cryptools/ui/screens/random/random_screen.dart';
import 'package:cryptools/ui/screens/settings/settings_binding.dart';
import 'package:cryptools/ui/screens/settings/settings_screen.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'main_scaffold.dart';

class RoutePaths {
  static const hash = '/hash';
  static const encrypt = '/encrypt';
  static const encode = '/encode';
  static const random = '/random';
  static const others = '/others';
  static const keyDerivation = '/key_derivation';
  static const keygen = '/keygen';
  static const settings = '/settings';
}

final List<GoRoute> bottomNavRoutes = [
  GoRoute(
    path: RoutePaths.hash,
    builder: (ctx, state) {
      HashBinding().dependencies();
      return HashScreen();
    },
  ),
  GoRoute(
    path: RoutePaths.encrypt,
    builder: (ctx, state) {
      EncryptBinding().dependencies();
      return EncryptScreen();
    },
  ),
  GoRoute(
    path: RoutePaths.encode,
    builder: (ctx, state) {
      EncodeBinding().dependencies();
      return EncodeScreen();
    },
  ),
  GoRoute(
    path: RoutePaths.random,
    builder: (ctx, state) {
      RandomBinding().dependencies();
      return RandomScreen();
    },
  ),
  GoRoute(
    path: RoutePaths.others,
    builder: (ctx, state) => const OthersScreen(),
  ),
];

final bottomNavRoutesPath = bottomNavRoutes.map((route) => route.path).toList();

// TODO fix url not changing when on non shell route
// if using go, there is no backstack?
// if using push, url not changing
final GoRouter router = GoRouter(
  initialLocation: RoutePaths.hash,
  routes: [
    ShellRoute(
      builder: (ctx, state, child) => MainScaffold(child: child),
      routes: bottomNavRoutes,
    ),
    GoRoute(
      path: RoutePaths.keygen,
      builder: (ctx, state) {
        KeygenBinding().dependencies();
        return Scaffold(
          appBar: AppBar(title: const Text('Key Generation')),
          body: KeygenScreen(),
        );
      },
    ),
    GoRoute(
      path: RoutePaths.keyDerivation,
      builder: (ctx, state) {
        KeyDerivationBinding().dependencies();
        return Scaffold(
          appBar: AppBar(title: const Text('Key Derivation')),
          body: KeyDerivationScreen(),
        );
      },
    ),
    GoRoute(
      path: RoutePaths.settings,
      builder: (ctx, state) {
        SettingsBinding().dependencies();
        return Scaffold(
          appBar: AppBar(title: const Text('Settings')),
          body: SettingsScreen(),
        );
      },
    ),
  ],
);

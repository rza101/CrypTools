import 'package:cryptools/ui/screens/encoding/encoding_screen.dart';
import 'package:cryptools/ui/screens/encryption/encryption_screen.dart';
import 'package:cryptools/ui/screens/hashing/hashing_screen.dart';
import 'package:cryptools/ui/screens/history/history_screen.dart';
import 'package:cryptools/ui/screens/keygen/keygen_screen.dart';
import 'package:cryptools/ui/screens/others/others_screen.dart';
import 'package:cryptools/ui/screens/random/random_screen.dart';
import 'package:cryptools/ui/screens/settings/settings_screen.dart';
import 'package:go_router/go_router.dart';

import 'main_scaffold.dart';

final List<GoRoute> bottomNavRoutes = [
  GoRoute(
    path: '/hashing',
    name: 'Hashing',
    builder: (context, state) => HashingScreen(),
  ),
  GoRoute(
    path: '/encryption',
    name: 'Encryption',
    builder: (context, state) => EncryptionScreen(),
  ),
  GoRoute(
    path: '/encoding',
    name: 'Encoding',
    builder: (context, state) => EncodingScreen(),
  ),
  GoRoute(
    path: '/random',
    name: 'Random',
    builder: (context, state) => RandomScreen(),
  ),
  GoRoute(
    path: '/others',
    name: 'Others',
    builder: (context, state) => OthersScreen(),
  ),
];

final bottomNavRoutesPath = bottomNavRoutes.map((route) => route.path).toList();

final GoRouter router = GoRouter(
  initialLocation: '/hashing',
  routes: [
    ShellRoute(
      builder: (context, state, child) => MainScaffold(child: child),
      routes: bottomNavRoutes,
    ),
    GoRoute(
      path: '/keygen',
      name: 'Keygen',
      builder: (context, state) => KeygenScreen(),
    ),
    GoRoute(
      path: '/history',
      name: 'History',
      builder: (context, state) => HistoryScreen(),
    ),
    GoRoute(
      path: '/settings',
      name: 'Settings',
      builder: (context, state) => SettingsScreen(),
    ),
  ],
);

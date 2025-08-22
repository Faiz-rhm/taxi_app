import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'src/core/services/app_theme.dart';
import 'src/route/app_router.dart';

void main() {
  runApp(
    const ProviderScope(
      child: TaxiApp(),
    ),
  );
}

class TaxiApp extends ConsumerWidget {
  const TaxiApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp(
      title: 'Taxi App',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      initialRoute: '/onboarding',
      onGenerateRoute: AppRouter.generateRoute,
    );
  }
}

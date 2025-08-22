import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
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
      theme: ThemeData(
        primarySwatch: Colors.blue,
        useMaterial3: true,
      ),
      initialRoute: '/onboarding',
      onGenerateRoute: AppRouter.generateRoute,
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/domain/provider/weather_provider.dart';
import 'package:weather_app/ui/routes/app_router.dart';

class WeatherApp extends StatelessWidget {
  const WeatherApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => WeatherProvider(),
      child: MaterialApp.router(
        debugShowCheckedModeBanner: false,
        routerConfig: AppRouter.router,
        localizationsDelegates: const [
          GlobalCupertinoLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
        ],
      ),
    );
  }
}

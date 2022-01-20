//import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:ken/smeup/services/smeupLocalizationDelegate.dart';

import 'package:provider/provider.dart';
import 'main_screen.dart';
import 'changeNotifierService.dart';
import 'routeService.dart';

final RouteObserver<PageRoute> routeObserver = RouteObserver<PageRoute>();

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  //await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  static bool loginEnabled = false;

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: ChangeNotifierService.getProviders(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        localizationsDelegates: [
          SmeupLocalizationDelegate(),
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
          DefaultCupertinoLocalizations.delegate
        ],
        supportedLocales: [
          const Locale('en', 'US'),
          const Locale('it', 'IT'),
          const Locale('fr', 'FR'),
        ],
        home: MainScreen(), // AuthenticationWrapper(),
        onGenerateRoute: (RouteSettings settings) {
          return RouteService.getRoutes(settings);
        },
        navigatorObservers: [routeObserver],
      ),
    );
  }
}

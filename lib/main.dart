import 'package:anime_app/injection_container.dart';
import 'package:anime_app/ui/themes/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'ui/navigation/go_router.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitDown, DeviceOrientation.portraitUp]);
  await init();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: goRouter,
      theme: ThemeClass.darkTheme,
    );
  }
}

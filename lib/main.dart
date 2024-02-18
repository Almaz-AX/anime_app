import 'package:anime_app/injection_container.dart';
import 'package:anime_app/ui/themes/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'ui/navigation/go_router.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // ByteData data =
  //     await PlatformAssetBundle().load('lib/assets/ca/lets-encrypt-r3.pem');
  // SecurityContext.defaultContext
  //     .setTrustedCertificatesBytes(data.buffer.asUint8List());
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
      // debugShowCheckedModeBanner: false,
      theme: ThemeClass.darkTheme,
    );
  }
}

// DevicePreview(
//   enabled: !kReleaseMode,
//   builder: (context) => const MyApp()
// ),


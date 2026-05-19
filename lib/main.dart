import 'package:camera/camera.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:scrape_application/features/auth/controllers/auth_controller.dart';
import 'package:scrape_application/features/auth/screens/register_screen.dart';
import 'firebase_options.dart';

late List<CameraDescription> cameras;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  cameras = await availableCameras();

  runApp(
    ChangeNotifierProvider(
      create: (_) => AuthController(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: Size(375, 812),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (_, child) {
        return const MaterialApp(
          debugShowCheckedModeBanner: false,
          home: RegisterScreen(),
        );
      },
    );
  }
}

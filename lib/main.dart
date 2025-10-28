import 'package:flutter/material.dart';
import 'package:flutter_background_service/flutter_background_service.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:focus/background_service.dart';
import 'package:focus/call_listener.dart';
import 'package:get/get.dart';
import 'package:focus/routes/app_pages.dart';
import 'package:focus/routes/app_routes.dart';
import 'package:permission_handler/permission_handler.dart';

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize notifications
  const initSettingsAndroid = AndroidInitializationSettings(
    '@mipmap/ic_launcher',
  );
  const initSettings = InitializationSettings(android: initSettingsAndroid);
  final localNotifications = FlutterLocalNotificationsPlugin();
  await localNotifications.initialize(initSettings);

  // Request permissions
  await Permission.phone.request();
  await Permission.notification.request();
  await Permission.ignoreBatteryOptimizations.request();

  // Configure background service
  final service = FlutterBackgroundService();
  await service.configure(
    androidConfiguration: AndroidConfiguration(
      onStart: onStart,
      autoStart: true,
      isForegroundMode: true,
      notificationChannelId: 'focus_channel',
      initialNotificationTitle: 'Focus Service',
      initialNotificationContent: 'Listening for call events...',
      foregroundServiceTypes: [AndroidForegroundType.phoneCall],
    ),
    iosConfiguration: IosConfiguration(),
  );

  await service.startService();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(390, 844), // Base design size (e.g. iPhone 12)
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) => GetMaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Focus App',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        ),
        initialRoute: AppRoutes.home,
        getPages: AppPages.pages,
      ),
    );
  }
}

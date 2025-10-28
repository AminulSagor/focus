import 'package:flutter_background_service/flutter_background_service.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class CallListener {
  static void startListening() {
    final service = FlutterBackgroundService();

    // Local notification instance
    final FlutterLocalNotificationsPlugin notifier =
        FlutterLocalNotificationsPlugin();
    const AndroidNotificationDetails androidDetails =
        AndroidNotificationDetails(
          'focus_channel',
          'Focus Background Notifications',
          channelDescription:
              'Displays call status updates from Focus service.',
          importance: Importance.high,
          priority: Priority.high,
          icon: '@mipmap/ic_launcher',
        );
    const NotificationDetails details = NotificationDetails(
      android: androidDetails,
    );

    service.on('onCallStateChanged').listen((event) async {
      if (event == null) return;
      final state = event['state'];
      final number = event['number'] ?? 'Unknown';
      print('📞 [$state] from $number');

      String message = '';
      if (state == 'RINGING') {
        message = 'Incoming call from $number';
      } else if (state == 'OFFHOOK') {
        message = 'Call answered: $number';
      } else if (state == 'IDLE') {
        message = 'Call ended or missed from $number';
      }

      if (message.isNotEmpty) {
        await notifier.show(
          DateTime.now().millisecondsSinceEpoch ~/ 1000,
          'Focus Call Monitor',
          message,
          details,
        );
      }
    });
  }
}

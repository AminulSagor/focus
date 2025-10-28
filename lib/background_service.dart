import 'package:flutter_background_service/flutter_background_service.dart';
import 'package:flutter_background_service_android/flutter_background_service_android.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

@pragma('vm:entry-point')
void onStart(ServiceInstance service) async {
  if (service is AndroidServiceInstance) {
    service.setAsForegroundService();
    service.setForegroundNotificationInfo(
      title: 'Focus Active',
      content: 'Monitoring calls in background...',
    );
  }

  service.on('onCallStateChanged').listen((event) {
    if (event == null) return;
    print(
      '📞 ${event['state']} from ${event['number']} (ringerMode: ${event['ringerMode']})',
    );
  });
}

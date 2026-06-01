import 'dart:async';
import 'dart:developer';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:permission_handler/permission_handler.dart';

/*
  TOP-LEVEL BACKGROUND MESSAGE HANDLER
  This must be a top-level function (not inside a class) and annotated with @pragma('vm:entry-point')
  to handle messages when the app is in the background or terminated.
*/
@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  log("Handling a background message: ${message.messageId}");
}

class NotificationService {
  static final FirebaseMessaging _messaging = FirebaseMessaging.instance;
  static final FlutterLocalNotificationsPlugin _localNotifications = FlutterLocalNotificationsPlugin();

  /// Initialize all notification settings
  static Future<void> initialize() async {
    // 1. Request permissions (Android 13+ and iOS)
    await requestPermissions();

    // 2. Initialize local notifications for foreground display on Android
    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('@mipmap/ic_launcher');
    
    const DarwinInitializationSettings initializationSettingsDarwin =
        DarwinInitializationSettings();

    const InitializationSettings initializationSettings = InitializationSettings(
      android: initializationSettingsAndroid,
      iOS: initializationSettingsDarwin,
    );

    await _localNotifications.initialize(
      settings: initializationSettings,
      onDidReceiveNotificationResponse: (details) {
        // Handle notification tap when app is running
        log("Notification tapped: ${details.payload}");
      },
    );

    // 3. Create High Importance Android Notification Channel
    const AndroidNotificationChannel channel = AndroidNotificationChannel(
      'high_importance_channel', // id
      'High Importance Notifications', // title
      description: 'This channel is used for important notifications.', // description
      importance: Importance.max,
    );

    await _localNotifications
        .resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(channel);

    // 4. Set up background handler
    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

    // 5. Handle foreground messages (App is open)
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      log('Message received in foreground: ${message.notification?.title}');
      
      if (message.notification != null) {
        _showLocalNotification(message, channel);
      }
    });

    // 6. Handle app opened from notification (App was in background)
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      log('App opened from notification: ${message.data}');
    });

    // 7. Subscribe to default topic
    await subscribeToTopic('test');

    // 8. Log FCM Token for debugging
    String? token = await getToken();
    log("🚀 FCM Token: $token");
  }

  /// Request permissions for both Android and iOS
  static Future<void> requestPermissions() async {
    // Request via Firebase Messaging
    NotificationSettings settings = await _messaging.requestPermission(
      alert: true,
      badge: true,
      sound: true,
    );

    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      log('✅ User granted notification permission');
    } else {
      log('❌ User declined or has not accepted permission');
    }

    // Explicitly request Android 13+ permission using permission_handler
    if (await Permission.notification.isDenied) {
      await Permission.notification.request();
    }
  }

  /// Display a local notification when a message arrives in foreground
  static Future<void> _showLocalNotification(RemoteMessage message, AndroidNotificationChannel channel) async {
    RemoteNotification? notification = message.notification;
    AndroidNotification? android = message.notification?.android;

    if (notification != null) {
      _localNotifications.show(
        id: notification.hashCode,
        title: notification.title,
        body: notification.body,
        notificationDetails: NotificationDetails(
          android: AndroidNotificationDetails(
            channel.id,
            channel.name,
            channelDescription: channel.description,
            icon: android?.smallIcon ?? '@mipmap/ic_launcher',
            importance: channel.importance,
            priority: Priority.high,
          ),
          iOS: const DarwinNotificationDetails(
            presentAlert: true,
            presentBadge: true,
            presentSound: true,
          ),
        ),
        payload: message.data.toString(),
      );
    }
  }

  /// Subscribe to a specific topic
  static Future<void> subscribeToTopic(String topic) async {
    try {
      await _messaging.subscribeToTopic(topic);
      log('📣 Subscribed to topic: $topic');
    } catch (e) {
      log('❌ Error subscribing to topic $topic: $e');
    }
  }

  /// Unsubscribe from a specific topic
  static Future<void> unsubscribeFromTopic(String topic) async {
    try {
      await _messaging.unsubscribeFromTopic(topic);
      log('🔇 Unsubscribed from topic: $topic');
    } catch (e) {
      log('❌ Error unsubscribing from topic $topic: $e');
    }
  }

  /// Get current FCM token
  static Future<String?> getToken() async {
    try {
      return await _messaging.getToken();
    } catch (e) {
      log("Error getting token: $e");
      return null;
    }
  }
}

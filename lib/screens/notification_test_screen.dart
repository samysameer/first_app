import 'package:flutter/material.dart';
import '../../services/notification_service.dart';

class NotificationTestScreen extends StatelessWidget {
  const NotificationTestScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('FCM Topics Test'),
        backgroundColor: const Color(0xFFDC2626),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Card(
              color: Color(0xFFFEF2F2),
              child: Padding(
                padding: EdgeInsets.all(15.0),
                child: Text(
                  'Use this screen to manually test Topic subscriptions. Note: Subscriptions are automatic on login/register.',
                  style: TextStyle(color: Color(0xFF991B1B)),
                ),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => NotificationService.subscribeToTopic('test'),
              style: ElevatedButton.styleFrom(backgroundColor: Colors.blue),
              child: const Text('Subscribe to "test" Topic', style: TextStyle(color: Colors.white)),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: () => NotificationService.subscribeToTopic('donor'),
              style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
              child: const Text('Subscribe to "donor" Topic', style: TextStyle(color: Colors.white)),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: () => NotificationService.subscribeToTopic('requester'),
              style: ElevatedButton.styleFrom(backgroundColor: Colors.orange),
              child: const Text('Subscribe to "requester" Topic', style: TextStyle(color: Colors.white)),
            ),
            const Spacer(),
            const Divider(),
            ElevatedButton(
              onPressed: () async {
                String? token = await NotificationService.getToken();
                if (context.mounted) {
                  showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: const Text('FCM Token'),
                      content: SelectableText(token ?? 'Error getting token'),
                      actions: [
                        TextButton(onPressed: () => Navigator.pop(context), child: const Text('OK'))
                      ],
                    ),
                  );
                }
              },
              child: const Text('View My FCM Token'),
            ),
          ],
        ),
      ),
    );
  }
}

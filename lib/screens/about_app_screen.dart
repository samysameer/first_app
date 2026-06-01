import 'package:flutter/material.dart';

class AboutAppScreen extends StatelessWidget {
  const AboutAppScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    
    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: AppBar(
        title: const Text('About E-Assist', style: TextStyle(fontWeight: FontWeight.bold)),
        centerTitle: true,
        backgroundColor: theme.appBarTheme.backgroundColor ?? theme.colorScheme.surface,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios, color: theme.iconTheme.color),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Icon(Icons.favorite, color: Color(0xFFDC2626), size: 64),
            const SizedBox(height: 16),
            const Text(
              'E-Assist',
              style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: Color(0xFFDC2626)),
            ),
            const Text(
              'DONATION & EMERGENCY AID APP',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600, letterSpacing: 1.2),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 24),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: theme.cardColor,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10, offset: const Offset(0, 2)),
                ],
              ),
              child: Column(
                children: [
                  const Text(
                    'FUTURE UNIVERSITY IN EGYPT',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                    textAlign: TextAlign.center,
                  ),
                  const Text(
                    'Faculty of Computers & Information Technology',
                    style: TextStyle(fontSize: 12, color: Colors.grey),
                    textAlign: TextAlign.center,
                  ),
                  const Divider(height: 24),
                  const Text(
                    'Supervisor',
                    style: TextStyle(fontWeight: FontWeight.bold, color: Color(0xFFDC2626)),
                  ),
                  const SizedBox(height: 4),
                  const Text('Dr. Mohamed Saeid Mohamed Shalaby', style: TextStyle(fontWeight: FontWeight.w500)),
                  const SizedBox(height: 16),
                  const Text(
                    'Team Members',
                    style: TextStyle(fontWeight: FontWeight.bold, color: Color(0xFFDC2626)),
                  ),
                  const SizedBox(height: 4),
                  const Text(
                    'Waheed Khairy • Fady Nader • Samy Sameer\nHabib Gamal • Yehia Mohamed • Youssef Hazem',
                    textAlign: TextAlign.center,
                    style: TextStyle(height: 1.5, fontWeight: FontWeight.w500),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            _buildSection(
              theme,
              title: 'MOTIVATION',
              icon: Icons.lightbulb_outline,
              content: 'Many people face emergencies without quick help. Slow response can risk lives and delay support. We aim to carry out a smart system that is able to connecting people with suitable organizations as well as giving excellent guidance for them.',
            ),
            const SizedBox(height: 16),
            _buildSection(
              theme,
              title: 'IDEA',
              icon: Icons.rocket_launch,
              content: '• A one-touch emergency system to contact help quickly.\n• Automatically share users\' location as well as their medical cases with nearby hospitals.',
            ),
            const SizedBox(height: 16),
            _buildSection(
              theme,
              title: 'RESEARCH PROBLEM',
              icon: Icons.warning_amber_rounded,
              content: '• Lack of quick and reliable medical help during emergencies.\n• No smart system gives instant medical advice.',
            ),
            const SizedBox(height: 16),
            _buildSection(
              theme,
              title: 'DATA COLLECTION',
              icon: Icons.analytics_outlined,
              content: '• Collect location and measured data to suggest the best nearby help centers.\n• Use AI models to analyze users\' symptoms and suggest the recommended steps subsequently.',
            ),
            const SizedBox(height: 16),
            _buildSection(
              theme,
              title: 'IMPLEMENTATION',
              icon: Icons.code,
              content: '• Built with Flutter for Android and iOS.\n• Uses Firebase for data, alerts, and authentication.\n• Integrated with Gemini API for AI-based medical consultation.',
            ),
            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }

  Widget _buildSection(ThemeData theme, {required String title, required IconData icon, required String content}) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: theme.cardColor,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10, offset: const Offset(0, 2)),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, color: const Color(0xFFDC2626)),
              const SizedBox(width: 8),
              Text(
                title,
                style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Color(0xFFDC2626)),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            content,
            style: const TextStyle(height: 1.5),
          ),
        ],
      ),
    );
  }
}

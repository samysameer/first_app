import 'package:flutter/material.dart';

class DispatcherMainScreen extends StatelessWidget {
  const DispatcherMainScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dispatcher / Ambulance'),
        backgroundColor: const Color(0xFFF59E0B),
        foregroundColor: Colors.white,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          const Text(
            'Use Cases (from E-Assist System Diagram)',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.grey),
          ),
          const SizedBox(height: 16),
          _buildUseCaseTile(Icons.airport_shuttle, 'Assign Ambulance', 'Dispatch ambulance to the emergency location.'),
          _buildUseCaseTile(Icons.my_location, 'Track Ambulance', 'Monitor the real-time location of the ambulance.'),
        ],
      ),
    );
  }

  Widget _buildUseCaseTile(IconData icon, String title, String subtitle) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: ListTile(
        leading: Icon(icon, color: const Color(0xFFF59E0B), size: 32),
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text(subtitle),
        trailing: const Icon(Icons.arrow_forward_ios, size: 16),
        onTap: () {},
      ),
    );
  }
}

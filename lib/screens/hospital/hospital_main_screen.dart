import 'package:flutter/material.dart';

class HospitalMainScreen extends StatelessWidget {
  const HospitalMainScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Hospital Dashboard'),
        backgroundColor: const Color(0xFF3B82F6),
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
          _buildUseCaseTile(Icons.sos, 'View Incoming SOS Cases', 'Monitor and respond to emergency requests.'),
          _buildUseCaseTile(Icons.update, 'Update Case Status', 'Update the status of ongoing emergencies.'),
          _buildUseCaseTile(Icons.bloodtype, 'Create Donation Request', 'Request blood or supplies for the hospital.'),
        ],
      ),
    );
  }

  Widget _buildUseCaseTile(IconData icon, String title, String subtitle) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: ListTile(
        leading: Icon(icon, color: const Color(0xFF3B82F6), size: 32),
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text(subtitle),
        trailing: const Icon(Icons.arrow_forward_ios, size: 16),
        onTap: () {},
      ),
    );
  }
}

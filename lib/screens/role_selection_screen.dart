import 'package:flutter/material.dart';
import 'donor/donor_main_screen.dart';
import 'requester/requester_main_screen.dart';
import 'hospital/hospital_main_screen.dart';
import 'admin/admin_main_screen.dart';
import 'dispatcher/dispatcher_main_screen.dart';

class RoleSelectionScreen extends StatelessWidget {
  const RoleSelectionScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Identification', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black)),
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
            const Text(
              "How would you like to use the app?",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Color(0xFF111827)),
            ),
            const SizedBox(height: 8),
            const Text(
              "Select your role to personalize your experience.",
              style: TextStyle(fontSize: 16, color: Color(0xFF6B7280)),
            ),
            const SizedBox(height: 40),
            
            // Donor Option
            _RoleCard(
              title: 'I want to Donate',
              subtitle: 'Give blood, supplies, or volunteer in emergencies near you.',
              icon: Icons.volunteer_activism,
              color: const Color(0xFF10B981),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const DonorMainScreen()),
                );
              },
            ),
            
            const SizedBox(height: 20),
            
            // Requester Option
            _RoleCard(
              title: 'I need Help',
              subtitle: 'Request blood or emergency aid for yourself or others.',
              icon: Icons.emergency_share,
              color: const Color(0xFFDC2626),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const RequesterMainScreen()),
                );
              },
            ),
            
            const SizedBox(height: 20),
            
            // Hospital Staff Option
            _RoleCard(
              title: 'Hospital Staff',
              subtitle: 'Manage incoming SOS cases and updates.',
              icon: Icons.local_hospital,
              color: const Color(0xFF3B82F6),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const HospitalMainScreen()),
                );
              },
            ),
            
            const SizedBox(height: 20),
            
            // Dispatcher / Ambulance Option
            _RoleCard(
              title: 'Dispatcher / Ambulance',
              subtitle: 'Assign and track ambulances for emergencies.',
              icon: Icons.airport_shuttle,
              color: const Color(0xFFF59E0B),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const DispatcherMainScreen()),
                );
              },
            ),
            
            const SizedBox(height: 20),
            
            // Admin Option
            _RoleCard(
              title: 'Administrator',
              subtitle: 'Manage hospitals, roles, and permissions.',
              icon: Icons.admin_panel_settings,
              color: const Color(0xFF8B5CF6),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const AdminMainScreen()),
                );
              },
            ),
            
            const SizedBox(height: 40),
            const Center(
              child: Text(
                "You can switch between roles anytime in settings.",
                style: TextStyle(fontSize: 12, color: Color(0xFF9CA3AF)),
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}

class _RoleCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final IconData icon;
  final Color color;
  final VoidCallback onTap;

  const _RoleCard({
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(24),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          color: color.withOpacity(0.05),
          borderRadius: BorderRadius.circular(24),
          border: Border.all(color: color.withOpacity(0.2), width: 1.5),
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: color.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(icon, size: 32, color: color),
            ),
            const SizedBox(width: 20),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: color),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    subtitle,
                    style: TextStyle(fontSize: 13, color: color.withOpacity(0.8)),
                  ),
                ],
              ),
            ),
            Icon(Icons.arrow_forward_ios, size: 16, color: color),
          ],
        ),
      ),
    );
  }
}

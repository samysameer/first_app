import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../l10n/app_localizations.dart';
import 'edit_profile_screen.dart';

class PrivacySecurityScreen extends StatelessWidget {
  const PrivacySecurityScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.privacySecurity),
        backgroundColor: const Color(0xFFDC2626),
        foregroundColor: Colors.white,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _buildOption(
            context,
            icon: Icons.person_outline,
            title: l10n.editProfile,
            subtitle: l10n.updateyourpersonalinforma,
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const EditProfileScreen()),
              );
            },
          ),
          const Divider(),
          _buildOption(
            context,
            icon: Icons.lock_outline,
            title: l10n.changePassword,
            subtitle: l10n.updateCredentials,
            onTap: () {
              // Logic to send password reset email
              final email = FirebaseAuth.instance.currentUser?.email;
              if (email != null) {
                FirebaseAuth.instance.sendPasswordResetEmail(email: email);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text(l10n.passwordresetemailsent)),
                );
              }
            },
          ),
          const Divider(),
          _buildOption(
            context,
            icon: Icons.security,
            title: l10n.twoFactorAuth,
            subtitle: l10n.extraLayerSecurity,
            onTap: () {},
          ),
          const Divider(),
          _buildOption(
            context,
            icon: Icons.visibility_off_outlined,
            title: l10n.profileVisibility,
            subtitle: l10n.chooseWhoSeesProfile,
            onTap: () {},
          ),
          const SizedBox(height: 24),
          Text(
            l10n.dataPrivacy,
            style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Color(0xFFDC2626)),
          ),
          const SizedBox(height: 8),
          _buildOption(
            context,
            icon: Icons.download_outlined,
            title: l10n.downloadMyData,
            subtitle: l10n.getCopyAccountInfo,
            onTap: () {},
          ),
          const Divider(),
          _buildOption(
            context,
            icon: Icons.delete_forever_outlined,
            title: l10n.deleteAccount,
            subtitle: l10n.permanentlyRemoveAccount,
            textColor: Colors.red,
            onTap: () {},
          ),
        ],
      ),
    );
  }

  Widget _buildOption(BuildContext context, {
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
    Color? textColor,
  }) {
    return ListTile(
      leading: Icon(icon, color: textColor ?? const Color(0xFF6B7280)),
      title: Text(title, style: TextStyle(fontWeight: FontWeight.bold, color: textColor)),
      subtitle: Text(subtitle),
      trailing: const Icon(Icons.chevron_right, size: 20),
      onTap: onTap,
    );
  }
}

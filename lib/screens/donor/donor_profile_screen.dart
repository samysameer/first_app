import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import '../../services/auth_service.dart';
import '../auth/login_screen.dart';
import '../app_settings_screen.dart';
import '../../locale_provider.dart';
import '../../l10n/app_localizations.dart';
import 'edit_profile_screen.dart';
import 'donation_history_screen.dart';
import 'badges_achievements_screen.dart';
import 'location_settings_screen.dart';
import 'privacy_security_screen.dart';
import 'language_settings_screen.dart';
import '../requester/requester_history_screen.dart';

class DonorProfileScreen extends StatefulWidget {
  const DonorProfileScreen({Key? key}) : super(key: key);

  @override
  State<DonorProfileScreen> createState() => _DonorProfileScreenState();
}

class _DonorProfileScreenState extends State<DonorProfileScreen> {
  late Future<Map<String, dynamic>?> _userDataFuture;
  bool _isUploading = false;
  String _imageTimestamp = DateTime.now().millisecondsSinceEpoch.toString();

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery, imageQuality: 70);

    if (pickedFile != null) {
      setState(() => _isUploading = true);
      final url = await AuthService.uploadProfileImage(File(pickedFile.path));
      setState(() => _isUploading = false);

      if (url != null) {
        setState(() {
          _imageTimestamp = DateTime.now().millisecondsSinceEpoch.toString();
        });
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Profile photo updated successfully!')),
          );
        }
      }
    }
  }

  @override
  void initState() {
    super.initState();
    _userDataFuture = _fetchUserData();
  }

  Future<Map<String, dynamic>?> _fetchUserData() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      final doc = await FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid)
          .get();
      return doc.data();
    }
    return null;
  }

  Future<void> _refreshUserData() async {
    setState(() {
      _userDataFuture = _fetchUserData();
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final l10n = AppLocalizations.of(context);

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      body: SafeArea(
        child: StreamBuilder<DocumentSnapshot>(
          stream: FirebaseFirestore.instance
              .collection('users')
              .doc(FirebaseAuth.instance.currentUser?.uid)
              .snapshots(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(color: Color(0xFFDC2626)),
              );
            }

            final data = (snapshot.data?.data() as Map<String, dynamic>?) ?? {};
            final name = data['name'] ?? l10n.user;
            final email = data['email'] ?? l10n.enterEmail;
            final phone = data['phone'] ?? l10n.enterPhone;
            final bloodType = data['bloodType'] ?? '--';
            final city = data['city'] ?? l10n.city;
            final bool isAvailable = data['isAvailable'] ?? true;
            final String? photoUrl = data['photoUrl'];
            final dynamic createdAt = data['createdAt'];
            String memberSince = '...';
            
            if (createdAt != null) {
              if (createdAt is Timestamp) {
                memberSince = DateFormat('MMMM d, yyyy').format(createdAt.toDate());
              } else if (createdAt is DateTime) {
                memberSince = DateFormat('MMMM d, yyyy').format(createdAt);
              }
            } else {
              memberSince = DateFormat('MMMM d, yyyy').format(DateTime.now());
            }

            return SingleChildScrollView(
              child: Column(
                children: [
                  // Header with Profile Card
                  Container(
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.centerLeft,
                        end: Alignment.centerRight,
                        colors: [Color(0xFFDC2626), Color(0xFFB91C1C)],
                      ),
                    ),
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              data['userType'] == 'donor' ? l10n.donor : l10n.requester,
                              style: const TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                            IconButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        const AppSettingsScreen(),
                                  ),
                                );
                              },
                              icon: const Icon(
                                Icons.settings,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),

                        // Profile Info Card
                        Container(
                          padding: const EdgeInsets.all(24),
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(24),
                          ),
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  GestureDetector(
                                    onTap: _isUploading ? null : _pickImage,
                                    child: Stack(
                                      children: [
                                        Container(
                                          width: 80,
                                          height: 80,
                                          decoration: BoxDecoration(
                                            gradient: LinearGradient(
                                              begin: Alignment.topLeft,
                                              end: Alignment.bottomRight,
                                              colors: [
                                                Colors.white.withOpacity(0.3),
                                                Colors.white.withOpacity(0.1),
                                              ],
                                            ),
                                            shape: BoxShape.circle,
                                            border: Border.all(
                                              color: Colors.white.withOpacity(0.2),
                                              width: 4,
                                            ),
                                          ),
                                          child: ClipOval(
                                            child: photoUrl != null
                                                ? Image.network(
                                                    '$photoUrl${photoUrl.contains('?') ? '&' : '?'}t=$_imageTimestamp',
                                                    fit: BoxFit.cover,
                                                    errorBuilder: (context, error, stackTrace) =>
                                                        const Icon(Icons.person, color: Colors.white, size: 40),
                                                    loadingBuilder: (context, child, loadingProgress) {
                                                      if (loadingProgress == null) return child;
                                                      return const Center(child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2));
                                                    },
                                                  )
                                                : const Icon(Icons.person, color: Colors.white, size: 40),
                                          ),
                                        ),
                                        if (_isUploading)
                                          Positioned.fill(
                                            child: Container(
                                              decoration: const BoxDecoration(
                                                color: Colors.black45,
                                                shape: BoxShape.circle,
                                              ),
                                              child: const Center(
                                                child: CircularProgressIndicator(color: Colors.white, strokeWidth: 3),
                                              ),
                                            ),
                                          )
                                        else
                                          Positioned(
                                            bottom: 0,
                                            right: 0,
                                            child: Container(
                                              padding: const EdgeInsets.all(4),
                                              decoration: const BoxDecoration(
                                                color: Colors.white,
                                                shape: BoxShape.circle,
                                              ),
                                              child: Icon(Icons.edit, color: theme.primaryColor, size: 14),
                                            ),
                                          ),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(width: 16),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          name,
                                          style: const TextStyle(
                                            fontSize: 24,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white,
                                          ),
                                        ),
                                        const SizedBox(height: 8),
                                        Wrap(
                                          spacing: 8,
                                          runSpacing: 8,
                                          children: [
                                            _InfoChip(
                                              label: '${l10n.bloodTypeLabel} $bloodType',
                                              bgColor: Colors.white,
                                              opacity: 0.2,
                                            ),
                                            _InfoChip(
                                              label: isAvailable ? l10n.available : l10n.notAvailable,
                                              bgColor: isAvailable ? const Color(0xFF4ADE80) : Colors.grey,
                                              indicatorColor: isAvailable ? const Color(0xFF22C55E) : Colors.white70,
                                              opacity: 0.3,
                                              hasIndicator: true,
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 16),
                              Column(
                                children: [
                                  _ContactRow(icon: Icons.phone, text: phone),
                                  const SizedBox(height: 8),
                                  _ContactRow(icon: Icons.email, text: email),
                                  const SizedBox(height: 8),
                                  _ContactRow(
                                    icon: Icons.location_on,
                                    text: '$city, ${l10n.Egypt}',
                                  ),
                                  const SizedBox(height: 8),
                                  _ContactRow(
                                    icon: Icons.calendar_today,
                                    text: '${l10n.memberSince} $memberSince',
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),

                  // Stats Grid
                  StreamBuilder<DocumentSnapshot>(
                    stream: FirebaseFirestore.instance
                        .collection('users')
                        .doc(FirebaseAuth.instance.currentUser?.uid)
                        .snapshots(),
                    builder: (context, snapshot) {
                      int livesSaved = 0;
                      String responseRate = '0%';
                      
                      if (snapshot.hasData && snapshot.data!.exists) {
                        final data = snapshot.data!.data() as Map<String, dynamic>;
                        livesSaved = data['livesSaved'] ?? 0;
                        responseRate = data['responseRate'] ?? '100%';
                      }

                      return Padding(
                        padding: const EdgeInsets.all(16),
                        child: Container(
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: isDark ? theme.cardColor : Colors.white,
                            borderRadius: BorderRadius.circular(16),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.05),
                                blurRadius: 10,
                                offset: const Offset(0, 2),
                              ),
                            ],
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              _StatColumn(
                                icon: Icons.favorite,
                                iconColor: const Color(0xFFDC2626),
                                iconBgColor: const Color(0xFFFEE2E2),
                                value: '$livesSaved',
                                label: l10n.isArabic ? 'حياة تم إنقاذها' : 'Lives Saved',
                              ),
                              _StatColumn(
                                icon: Icons.star,
                                iconColor: const Color(0xFF2563EB),
                                iconBgColor: const Color(0xFFDBEAFE),
                                value: responseRate,
                                label: l10n.responseRate,
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),

                  StreamBuilder<DocumentSnapshot>(
                    stream: FirebaseFirestore.instance
                        .collection('users')
                        .doc(FirebaseAuth.instance.currentUser?.uid)
                        .snapshots(),
                    builder: (context, snapshot) {
                      int livesSaved = 0;
                      if (snapshot.hasData && snapshot.data!.exists) {
                        final data = snapshot.data!.data() as Map<String, dynamic>;
                        livesSaved = data['livesSaved'] ?? 0;
                      }

                      int nextMilestone = 20;
                      if (livesSaved >= 20) nextMilestone = 50;
                      if (livesSaved >= 50) nextMilestone = 100;
                      
                      int remaining = nextMilestone - livesSaved;

                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: Container(
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment.centerLeft,
                              end: Alignment.centerRight,
                              colors: isDark
                                  ? [const Color(0xFF1E293B), const Color(0xFF1A3326)]
                                  : [const Color(0xFFF0FDF4), const Color(0xFFDCFCE7)],
                            ),
                            borderRadius: BorderRadius.circular(16),
                            border: Border.all(color: isDark ? const Color(0xFF334155) : const Color(0xFFBBF7D0)),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    l10n.isArabic ? 'تأثيرك' : 'Your Impact',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: isDark ? Colors.white : const Color(0xFF111827),
                                    ),
                                  ),
                                  const Icon(
                                    Icons.emoji_events,
                                    color: Color(0xFF16A34A),
                                    size: 20,
                                  ),
                                ],
                              ),
                              const SizedBox(height: 8),
                              Text(
                                '$livesSaved ${l10n.isArabic ? 'حياة تم إنقاذها' : 'Lives Saved'}',
                                style: const TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xFF15803D),
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                livesSaved == 0 
                                  ? (l10n.isArabic ? 'ابدأ رحلتك لإنقاذ الأرواح اليوم!' : 'Start your journey to save lives today!')
                                  : (l10n.isArabic ? 'أنت ضمن أفضل 5٪ من المتبرعين في القاهرة!' : 'You\'re in the top 5% of donors in Cairo!'),
                                style: const TextStyle(
                                  fontSize: 14,
                                  color: Color(0xFF6B7280),
                                ),
                              ),
                              const SizedBox(height: 12),
                              ClipRRect(
                                borderRadius: BorderRadius.circular(4),
                                child: LinearProgressIndicator(
                                  value: livesSaved / nextMilestone,
                                  minHeight: 8,
                                  backgroundColor: Colors.white.withOpacity(0.5),
                                  valueColor: const AlwaysStoppedAnimation<Color>(
                                    Color(0xFF16A34A),
                                  ),
                                ),
                              ),
                              const SizedBox(height: 4),
                              if (remaining > 0)
                                Text(
                                  '$remaining ${l10n.isArabic ? 'تبرعات إضافية للوصول إلى الإنجاز التالي' : 'more donations to reach next milestone'}',
                                  style: const TextStyle(
                                    fontSize: 12,
                                    color: Color(0xFF6B7280),
                                  ),
                                ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                  const SizedBox(height: 16),

                  // Menu Items
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Container(
                      decoration: BoxDecoration(
                        color: isDark ? theme.cardColor : Colors.white,
                        borderRadius: BorderRadius.circular(16),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.05),
                            blurRadius: 10,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: Column(
                        children: [
                          if (data['userType'] == 'donor')
                            _MenuItem(
                              icon: Icons.water_drop,
                              iconColor: const Color(0xFFDC2626),
                              iconBgColor: const Color(0xFFFEE2E2),
                              label: l10n.donationHistory,
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) => const DonationHistoryScreen()),
                                );
                              },
                            ),
                          if (data['userType'] == 'donor') const Divider(height: 1),
                          if (data['userType'] == 'requester')
                            _MenuItem(
                              icon: Icons.history,
                              iconColor: const Color(0xFFDC2626),
                              iconBgColor: const Color(0xFFFEE2E2),
                              label: l10n.isArabic ? 'سجل الطلبات' : 'Request History',
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) => const RequesterHistoryScreen()),
                                );
                              },
                            ),
                          if (data['userType'] == 'requester') const Divider(height: 1),
                          _MenuItem(
                            icon: Icons.language,
                            iconColor: const Color(0xFF9333EA),
                            iconBgColor: const Color(0xFFF3E8FF),
                            label: l10n.appLanguage,
                            trailing: Text(
                              localeProvider.value.languageCode == 'ar'
                                  ? 'العربية'
                                  : localeProvider.value.languageCode == 'fr'
                                      ? 'Français'
                                      : localeProvider.value.languageCode == 'de'
                                          ? 'Deutsch'
                                          : 'English',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: theme.primaryColor,
                              ),
                            ),
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const LanguageSettingsScreen(),
                                ),
                              );
                            },
                          ),
                          const Divider(height: 1),
                          _MenuItem(
                            icon: Icons.location_on,
                            iconColor: const Color(0xFF16A34A),
                            iconBgColor: const Color(0xFFDCFCE7),
                            label: l10n.locationSettings,
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => const LocationSettingsScreen()),
                              );
                            },
                          ),
                          const Divider(height: 1),
                          _MenuItem(
                            icon: Icons.settings,
                            iconColor: const Color(0xFF6B7280),
                            iconBgColor: const Color(0xFFF3F4F6),
                            label: l10n.appSettings,
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      const AppSettingsScreen(),
                                ),
                              );
                            },
                          ),
                          const Divider(height: 1),
                          _MenuItem(
                            icon: Icons.shield,
                            iconColor: const Color(0xFF9333EA),
                            iconBgColor: const Color(0xFFF3E8FF),
                            label: l10n.privacySecurity,
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => const PrivacySecurityScreen()),
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),

                  // Logout Button
                  Padding(
                    padding: const EdgeInsets.all(16),
                    child: OutlinedButton.icon(
                      onPressed: () {
                        AuthService.logout();
                        Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const LoginScreen(),
                          ),
                          (route) => false,
                        );
                      },
                      icon: const Icon(Icons.logout, size: 20),
                      label: Text(
                        l10n.logout,
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      style: OutlinedButton.styleFrom(
                        foregroundColor: const Color(0xFFDC2626),
                        side: const BorderSide(
                          color: Color(0xFFDC2626),
                          width: 2,
                        ),
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        minimumSize: const Size(double.infinity, 48),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 24),
                    child: Center(
                      child: Text(
                        l10n.developedBy,
                        style: const TextStyle(
                          fontSize: 12,
                          color: Colors.grey,
                          letterSpacing: 0.5,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}

class _InfoChip extends StatelessWidget {
  final String label;
  final Color bgColor;
  final Color indicatorColor;
  final double opacity;
  final bool hasIndicator;

  const _InfoChip({
    Key? key,
    required this.label,
    required this.bgColor,
    this.indicatorColor = const Color(0xFF86EFAC),
    required this.opacity,
    this.hasIndicator = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: bgColor.withOpacity(opacity),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (hasIndicator) ...[
            Container(
              width: 8,
              height: 8,
              decoration: BoxDecoration(
                color: indicatorColor,
                shape: BoxShape.circle,
              ),
            ),
            const SizedBox(width: 6),
          ],
          Text(
            label,
            style: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}

class _ContactRow extends StatelessWidget {
  final IconData icon;
  final String text;

  const _ContactRow({Key? key, required this.icon, required this.text})
    : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, size: 16, color: Colors.white.withOpacity(0.9)),
        const SizedBox(width: 8),
        Text(
          text,
          style: TextStyle(fontSize: 14, color: Colors.white.withOpacity(0.9)),
        ),
      ],
    );
  }
}

class _StatColumn extends StatelessWidget {
  final IconData icon;
  final Color iconColor;
  final Color iconBgColor;
  final String value;
  final String label;

  const _StatColumn({
    Key? key,
    required this.icon,
    required this.iconColor,
    required this.iconBgColor,
    required this.value,
    required this.label,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Column(
      children: [
        Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            color: iconBgColor,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(icon, color: iconColor, size: 20),
        ),
        const SizedBox(height: 8),
        Text(
          value,
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: isDark ? Colors.white : const Color(0xFF111827),
          ),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: const TextStyle(fontSize: 12, color: Color(0xFF6B7280)),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}

class _MenuItem extends StatelessWidget {
  final IconData icon;
  final Color iconColor;
  final Color iconBgColor;
  final String label;
  final Widget? trailing;
  final VoidCallback? onTap;

  const _MenuItem({
    Key? key,
    required this.icon,
    required this.iconColor,
    required this.iconBgColor,
    required this.label,
    this.trailing,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return InkWell(
      onTap: onTap ?? () {},
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: iconBgColor,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(icon, color: iconColor, size: 20),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                label,
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  color: isDark ? Colors.white : const Color(0xFF111827),
                ),
              ),
            ),
            trailing ?? const Icon(Icons.chevron_right, color: Color(0xFF9CA3AF)),
          ],
        ),
      ),
    );
  }
}

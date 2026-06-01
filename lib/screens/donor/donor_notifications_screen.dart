import 'package:flutter/material.dart';
import '../../l10n/app_localizations.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:intl/intl.dart';
import '../../l10n/app_localizations.dart';

class DonorNotificationsScreen extends StatefulWidget {
  const DonorNotificationsScreen({Key? key}) : super(key: key);

  @override
  State<DonorNotificationsScreen> createState() => _DonorNotificationsScreenState();
}

class _DonorNotificationsScreenState extends State<DonorNotificationsScreen> {
  int _selectedTab = 0; // 0: All, 1: Emergency, 2: Updates

  String _getTimeAgo(dynamic timestamp, AppLocalizations l10n) {
    if (timestamp == null) return '--';
    DateTime date = (timestamp as Timestamp).toDate();
    Duration diff = DateTime.now().difference(date);
    if (diff.inMinutes < 60) return l10n.isArabic ? 'منذ ${diff.inMinutes} دقيقة' : '${diff.inMinutes}m ago';
    if (diff.inHours < 24) return l10n.isArabic ? 'منذ ${diff.inHours} ساعة' : '${diff.inHours}h ago';
    return DateFormat('MMM dd').format(date);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final l10n = AppLocalizations.of(context);

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      body: SafeArea(
        child: Column(
          children: [
            // Header
            Container(
              color: isDark ? theme.cardColor : Colors.white,
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        l10n.notifications,
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: isDark ? Colors.white : const Color(0xFF111827),
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          // In a real app, this would update a 'read' field in Firestore
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text(l10n.allmarkedasread)),
                          );
                        },
                        child: Text(
                          l10n.markAllRead,
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: Color(0xFFDC2626),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      GestureDetector(
                        onTap: () => setState(() => _selectedTab = 0),
                        child: _TabChip(label: l10n.all, isSelected: _selectedTab == 0),
                      ),
                      const SizedBox(width: 8),
                      GestureDetector(
                        onTap: () => setState(() => _selectedTab = 1),
                        child: _TabChip(label: l10n.emergencyTab, isSelected: _selectedTab == 1),
                      ),
                      const SizedBox(width: 8),
                      GestureDetector(
                        onTap: () => setState(() => _selectedTab = 2),
                        child: _TabChip(label: l10n.updatesTab, isSelected: _selectedTab == 2),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // Notifications List (Live)
            Expanded(
              child: _buildNotificationList(l10n, isDark, theme),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNotificationList(AppLocalizations l10n, bool isDark, ThemeData theme) {
    if (_selectedTab == 1) {
      // Emergency Only
      return StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('emergencies')
            .where('status', isEqualTo: 'active')
            .snapshots(),
        builder: (context, snapshot) => _buildStreamContent(snapshot, l10n, 'emergency'),
      );
    } else if (_selectedTab == 2) {
      // Updates Only
      return StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('donations')
            .where('donorId', isEqualTo: FirebaseAuth.instance.currentUser?.uid)
            .snapshots(),
        builder: (context, snapshot) => _buildStreamContent(snapshot, l10n, 'update'),
      );
    } else {
      // All - For simplicity without rxdart, we'll just combine emergencies first
      // In a production app, use a unified 'notifications' collection
      return StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('emergencies')
            .where('status', isEqualTo: 'active')
            .snapshots(),
        builder: (context, snapshot) => _buildStreamContent(snapshot, l10n, 'all'),
      );
    }
  }

  Widget _buildStreamContent(AsyncSnapshot<QuerySnapshot> snapshot, AppLocalizations l10n, String type) {
    if (snapshot.connectionState == ConnectionState.waiting) {
      return const Center(child: CircularProgressIndicator());
    }

    if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.notifications_none, size: 64, color: Colors.grey.withOpacity(0.5)),
            const SizedBox(height: 16),
            Text(
              l10n.nonewalerts,
              style: const TextStyle(fontSize: 16, color: Colors.grey),
            ),
          ],
        ),
      );
    }

    final List<QueryDocumentSnapshot> docs = snapshot.data!.docs.toList();
    
    // Sort locally
    docs.sort((a, b) {
      final aData = a.data() as Map<String, dynamic>;
      final bData = b.data() as Map<String, dynamic>;
      final aTime = (aData['createdAt'] ?? aData['timestamp']) as Timestamp?;
      final bTime = (bData['createdAt'] ?? bData['timestamp']) as Timestamp?;
      if (aTime == null || bTime == null) return 0;
      return bTime.compareTo(aTime);
    });

    return ListView.separated(
      padding: const EdgeInsets.all(16),
      itemCount: docs.length,
      separatorBuilder: (context, index) => const SizedBox(height: 12),
      itemBuilder: (context, index) {
        final data = docs[index].data() as Map<String, dynamic>;
        
        if (type == 'update' || (type == 'all' && docs[index].reference.parent.id == 'donations')) {
           return _NotificationCard(
            icon: Icons.check_circle,
            iconColor: const Color(0xFF16A34A),
            iconBgColor: const Color(0xFFDCFCE7),
            title: l10n.requestCompleted,
            message: l10n.yourdonationhasbeenrecord,
            time: _getTimeAgo(data['timestamp'], l10n),
            isUnread: false,
            hasAction: false,
          );
        }

        // Emergency Notification
        final emergencyType = data['type'] ?? 'blood';
        return _NotificationCard(
          icon: emergencyType == 'blood' ? Icons.water_drop : (emergencyType == 'medical' ? Icons.medical_services : Icons.emergency),
          iconColor: const Color(0xFFDC2626),
          iconBgColor: const Color(0xFFFEE2E2),
          title: l10n.newEmergencyRequest,
          message: data['description'] ?? '',
          time: _getTimeAgo(data['createdAt'], l10n),
          isUnread: true,
          hasAction: true,
          onAction: () {
             // Navigation or acceptance logic could go here
             ScaffoldMessenger.of(context).showSnackBar(
               SnackBar(content: Text(l10n.openingrequest)),
             );
          },
        );
      },
    );
  }
}


class _TabChip extends StatelessWidget {
  final String label;
  final bool isSelected;

  const _TabChip({
    Key? key,
    required this.label,
    required this.isSelected,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: isSelected ? const Color(0xFFDC2626) : (isDark ? theme.cardColor : const Color(0xFFF3F4F6)),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        label,
        style: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w500,
          color: isSelected ? Colors.white : (isDark ? Colors.white70 : const Color(0xFF374151)),
        ),
      ),
    );
  }
}

class _NotificationCard extends StatelessWidget {
  final IconData icon;
  final Color iconColor;
  final Color iconBgColor;
  final String title;
  final String message;
  final String time;
  final bool isUnread;
  final bool hasAction;
  final VoidCallback? onAction;

  const _NotificationCard({
    Key? key,
    required this.icon,
    required this.iconColor,
    required this.iconBgColor,
    required this.title,
    required this.message,
    required this.time,
    required this.isUnread,
    required this.hasAction,
    this.onAction,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final l10n = AppLocalizations.of(context);
    return Container(
      decoration: BoxDecoration(
        color: isDark ? theme.cardColor : Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: isUnread ? const Color(0xFFFECACA) : (isDark ? const Color(0xFF334155) : const Color(0xFFE5E7EB)),
          width: 2,
        ),
        boxShadow: isUnread
            ? [
                BoxShadow(
                  color: const Color(0xFFDC2626).withOpacity(0.1),
                  blurRadius: 10,
                  offset: const Offset(0, 2),
                ),
              ]
            : null,
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: iconBgColor,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(
                    icon,
                    color: iconColor,
                    size: 20,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Text(
                              title,
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: isDark ? Colors.white : const Color(0xFF111827),
                              ),
                            ),
                          ),
                          if (isUnread)
                            Container(
                              width: 8,
                              height: 8,
                              decoration: const BoxDecoration(
                                color: Color(0xFFDC2626),
                                shape: BoxShape.circle,
                              ),
                            ),
                        ],
                      ),
                      const SizedBox(height: 4),
                      Text(
                        message,
                        style: const TextStyle(
                          fontSize: 14,
                          color: Color(0xFF6B7280),
                          height: 1.4,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          const Icon(
                            Icons.access_time,
                            size: 12,
                            color: Color(0xFF9CA3AF),
                          ),
                          const SizedBox(width: 4),
                          Text(
                            time,
                            style: const TextStyle(
                              fontSize: 12,
                              color: Color(0xFF9CA3AF),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
            if (hasAction) ...[
              const SizedBox(height: 12),
              const Divider(height: 1),
              const SizedBox(height: 12),
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: onAction,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFFDC2626),
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: Text(
                        l10n.viewRequest,
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  OutlinedButton(
                    onPressed: () {},
                    style: OutlinedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 10,
                      ),
                      side: const BorderSide(
                        color: Color(0xFFD1D5DB),
                        width: 2,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: Text(
                      l10n.dismiss,
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF374151),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ],
        ),
      ),
    );
  }
}

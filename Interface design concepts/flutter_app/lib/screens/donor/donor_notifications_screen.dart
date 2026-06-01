import 'package:flutter/material.dart';

class DonorNotificationsScreen extends StatelessWidget {
  const DonorNotificationsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF9FAFB),
      body: SafeArea(
        child: Column(
          children: [
            // Header
            Container(
              color: Colors.white,
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Notifications',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF111827),
                        ),
                      ),
                      TextButton(
                        onPressed: () {},
                        child: const Text(
                          'Mark all read',
                          style: TextStyle(
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
                      _TabChip(label: 'All (2)', isSelected: true),
                      const SizedBox(width: 8),
                      _TabChip(label: 'Emergency', isSelected: false),
                      const SizedBox(width: 8),
                      _TabChip(label: 'Updates', isSelected: false),
                    ],
                  ),
                ],
              ),
            ),

            // Notifications List
            Expanded(
              child: ListView(
                padding: const EdgeInsets.all(16),
                children: const [
                  _NotificationCard(
                    icon: Icons.water_drop,
                    iconColor: Color(0xFFDC2626),
                    iconBgColor: Color(0xFFFEE2E2),
                    title: 'New Emergency Request',
                    message: 'Critical blood donation needed 1.2 km away',
                    time: '2 minutes ago',
                    isUnread: true,
                    hasAction: true,
                  ),
                  SizedBox(height: 12),
                  _NotificationCard(
                    icon: Icons.favorite,
                    iconColor: Color(0xFFEA580C),
                    iconBgColor: Color(0xFFFFEDD5),
                    title: 'High Priority Request',
                    message: 'Medical supplies needed at Dar El Fouad Hospital',
                    time: '15 minutes ago',
                    isUnread: true,
                    hasAction: true,
                  ),
                  SizedBox(height: 12),
                  _NotificationCard(
                    icon: Icons.check_circle,
                    iconColor: Color(0xFF16A34A),
                    iconBgColor: Color(0xFFDCFCE7),
                    title: 'Request Completed',
                    message: 'Thank you for helping Sarah Mohamed! +10 points',
                    time: '2 hours ago',
                    isUnread: false,
                    hasAction: false,
                  ),
                  SizedBox(height: 12),
                  _NotificationCard(
                    icon: Icons.emoji_events,
                    iconColor: Color(0xFFCA8A04),
                    iconBgColor: Color(0xFFFEF3C7),
                    title: 'New Badge Earned!',
                    message: 'You\'ve unlocked "Life Saver" - 10 donations completed',
                    time: '5 hours ago',
                    isUnread: false,
                    hasAction: false,
                  ),
                  SizedBox(height: 12),
                  _NotificationCard(
                    icon: Icons.notifications,
                    iconColor: Color(0xFF2563EB),
                    iconBgColor: Color(0xFFDBEAFE),
                    title: 'Reminder',
                    message: 'You can donate blood again starting tomorrow',
                    time: '1 day ago',
                    isUnread: false,
                    hasAction: false,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
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
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: isSelected ? const Color(0xFFDC2626) : const Color(0xFFF3F4F6),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        label,
        style: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w500,
          color: isSelected ? Colors.white : const Color(0xFF374151),
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
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: isUnread ? const Color(0xFFFECACA) : const Color(0xFFE5E7EB),
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
                              style: const TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF111827),
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
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFFDC2626),
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: const Text(
                        'View Request',
                        style: TextStyle(
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
                    child: const Text(
                      'Dismiss',
                      style: TextStyle(
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

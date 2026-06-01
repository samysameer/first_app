import 'package:flutter/material.dart';
import '../../l10n/app_localizations.dart';

class BadgesAchievementsScreen extends StatelessWidget {
  const BadgesAchievementsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.badgesAchievements),
        backgroundColor: const Color(0xFFDC2626),
        foregroundColor: Colors.white,
      ),
      body: GridView.count(
        crossAxisCount: 2,
        padding: const EdgeInsets.all(16),
        mainAxisSpacing: 16,
        crossAxisSpacing: 16,
        children: [
          _buildBadgeCard(l10n.firstResponder, Icons.flash_on, Colors.orange, true, l10n),
          _buildBadgeCard(l10n.lifeSaver, Icons.favorite, Colors.red, true, l10n),
          _buildBadgeCard(l10n.bloodHero, Icons.water_drop, Colors.redAccent, false, l10n),
          _buildBadgeCard(l10n.frequentDonor, Icons.repeat, Colors.blue, false, l10n),
          _buildBadgeCard(l10n.communityPillar, Icons.people, Colors.green, false, l10n),
          _buildBadgeCard(l10n.nightOwl, Icons.dark_mode, Colors.purple, false, l10n),
        ],
      ),
    );
  }

  Widget _buildBadgeCard(String title, IconData icon, Color color, bool unlocked, AppLocalizations l10n) {
    return Container(
      decoration: BoxDecoration(
        color: unlocked ? Colors.white : Colors.grey.withOpacity(0.1),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: unlocked ? color.withOpacity(0.5) : Colors.transparent),
        boxShadow: unlocked ? [
          BoxShadow(color: color.withOpacity(0.2), blurRadius: 8, offset: const Offset(0, 4)),
        ] : [],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, size: 48, color: unlocked ? color : Colors.grey),
          const SizedBox(height: 12),
          Text(
            title,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: unlocked ? Colors.black87 : Colors.grey,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            unlocked ? l10n.unlocked : l10n.locked,
            style: TextStyle(
              fontSize: 12,
              color: unlocked ? color : Colors.grey,
            ),
          ),
        ],
      ),
    );
  }
}

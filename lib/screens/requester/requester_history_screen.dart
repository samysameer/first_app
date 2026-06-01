import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:intl/intl.dart';
import '../../l10n/app_localizations.dart';

class RequesterHistoryScreen extends StatelessWidget {
  const RequesterHistoryScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final l10n = AppLocalizations.of(context);
    final user = FirebaseAuth.instance.currentUser;

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.isArabic ? 'سجل الطلبات' : 'Request History'),
        backgroundColor: const Color(0xFFDC2626),
        foregroundColor: Colors.white,
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('emergencies')
            .where('userId', isEqualTo: user?.uid)
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.history, size: 80, color: Colors.grey.withOpacity(0.5)),
                  const SizedBox(height: 16),
                  Text(
                    l10n.norequestsyet,
                    style: const TextStyle(fontSize: 18, color: Colors.grey),
                  ),
                ],
              ),
            );
          }

          final List<QueryDocumentSnapshot> docs = snapshot.data!.docs.toList();
          
          // Sort locally to avoid index requirement
          docs.sort((a, b) {
            final aTime = (a.data() as Map<String, dynamic>)['createdAt'] as Timestamp?;
            final bTime = (b.data() as Map<String, dynamic>)['createdAt'] as Timestamp?;
            if (aTime == null || bTime == null) return 0;
            return bTime.compareTo(aTime);
          });

          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: docs.length,
            itemBuilder: (context, index) {
              final data = docs[index].data() as Map<String, dynamic>;
              final type = data['type'] ?? 'rescue';
              final status = data['status'] ?? 'active';
              final createdAt = data['createdAt'] as Timestamp?;
              
              IconData icon;
              String title;
              Color statusColor;
              String statusText;

              switch (type) {
                case 'blood':
                  icon = Icons.bloodtype;
                  title = l10n.bloodRequest;
                  break;
                case 'medical':
                  icon = Icons.medical_services;
                  title = l10n.medicalSuppliesRequest;
                  break;
                default:
                  icon = Icons.emergency;
                  title = l10n.rescueRequest;
              }

              switch (status) {
                case 'completed':
                  statusColor = Colors.green;
                  statusText = l10n.completedStatus;
                  break;
                case 'accepted':
                  statusColor = Colors.blue;
                  statusText = l10n.accepted;
                  break;
                case 'active':
                  statusColor = Colors.orange;
                  statusText = l10n.active;
                  break;
                default:
                  statusColor = Colors.grey;
                  statusText = status;
              }

              return Card(
                margin: const EdgeInsets.only(bottom: 12),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                child: ListTile(
                  leading: CircleAvatar(
                    backgroundColor: statusColor.withOpacity(0.1),
                    child: Icon(icon, color: statusColor),
                  ),
                  title: Text(
                    title,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(data['description'] ?? ''),
                      const SizedBox(height: 4),
                      Text(
                        createdAt != null 
                          ? DateFormat('MMM dd, yyyy • hh:mm a', l10n.isArabic ? 'ar' : 'en').format(createdAt.toDate())
                          : 'Just now',
                        style: const TextStyle(fontSize: 12, color: Colors.grey),
                      ),
                    ],
                  ),
                  trailing: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: statusColor.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      statusText,
                      style: TextStyle(color: statusColor, fontSize: 10, fontWeight: FontWeight.bold),
                    ),
                  ),
                  isThreeLine: true,
                ),
              );
            },
          );
        },
      ),
    );
  }
}

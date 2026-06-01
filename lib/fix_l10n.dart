import 'dart:io';

const translations = {
  'A**** H*****': ['A**** H*****', 'أ**** ح*****', 'A**** H*****', 'A**** H*****'],
  'Letters only': ['Letters only', 'أحرف فقط', 'Lettres uniquement', 'Nur Buchstaben'],
  'Enter a valid email': ['Enter a valid email', 'البريد غير صحيح', 'Entrez un email valide', 'Gültige E-Mail eingeben'],
  'Invalid Egyptian phone number': ['Invalid Egyptian phone number', 'رقم هاتف مصري غير صحيح', 'Numéro égyptien invalide', 'Ungültige ägyptische Nummer'],
  'Enter a password': ['Enter a password', 'أدخل كلمة المرور', 'Entrez un mot de passe', 'Passwort eingeben'],
  'Request accepted! Please head to the location.': ['Request accepted! Please head to the location.', 'تم قبول الطلب! يرجى التوجه للموقع.', 'Demande acceptée! Veuillez vous rendre sur place.', 'Anfrage akzeptiert! Bitte begeben Sie sich zum Ort.'],
  'Failed to update status': ['Failed to update status', 'فشل تحديث الحالة', 'Échec de la mise à jour du statut', 'Statusaktualisierung fehlgeschlagen'],
  'Response Rate': ['Response Rate', 'معدل الاستجابة', 'Taux de réponse', 'Rücklaufquote'],
  'No nearby emergencies at the moment': ['No nearby emergencies at the moment', 'لا توجد حالات طوارئ قريبة حالياً', 'Aucune urgence à proximité pour le moment', 'Derzeit keine Notfälle in der Nähe'],
  'Unknown Location': ['Unknown Location', 'موقع غير محدد', 'Lieu inconnu', 'Unbekannter Ort'],
  'All marked as read': ['All marked as read', 'تم تحديد الكل كمقروء', 'Tout marqué comme lu', 'Alle als gelesen markiert'],
  'No new alerts': ['No new alerts', 'لا توجد تنبيهات جديدة', 'Aucune nouvelle alerte', 'Keine neuen Benachrichtigungen'],
  'Your donation has been recorded! Thank you for your contribution.': ['Your donation has been recorded! Thank you for your contribution.', 'تم تسجيل تبرعك بنجاح! شكراً لمساهمتك.', 'Votre don a été enregistré! Merci pour votre contribution.', 'Ihre Spende wurde registriert! Danke für Ihren Beitrag.'],
  'Opening request...': ['Opening request...', 'فتح الطلب...', 'Ouverture de la demande...', 'Anfrage wird geöffnet...'],
  'Profile photo updated successfully!': ['Profile photo updated successfully!', 'تم تحديث صورة الملف الشخصي بنجاح!', 'Photo de profil mise à jour avec succès!', 'Profilbild erfolgreich aktualisiert!'],
  'HEALTH INFORMATION': ['HEALTH INFORMATION', 'معلومات الصحة', 'INFORMATIONS SUR LA SANTÉ', 'GESUNDHEITSINFORMATIONEN'],
  'Request accepted successfully!': ['Request accepted successfully!', 'تم قبول الطلب بنجاح!', 'Demande acceptée avec succès!', 'Anfrage erfolgreich akzeptiert!'],
  'Something went wrong': ['Something went wrong', 'حدث خطأ ما', 'Un problème est survenu', 'Etwas ist schiefgelaufen'],
  'Emergency Details': ['Emergency Details', 'تفاصيل الحالة', 'Détails de l\'urgence', 'Notfalldetails'],
  'Needs your help': ['Needs your help', 'يحتاج إلى مساعدتك', 'A besoin de votre aide', 'Braucht Ihre Hilfe'],
  'Description': ['Description', 'وصف الحالة', 'Description', 'Beschreibung'],
  'Location': ['Location', 'الموقع', 'Emplacement', 'Standort'],
  'Contact Information': ['Contact Information', 'معلومات التواصل', 'Coordonnées', 'Kontaktinformationen'],
  'Accept Request & Go': ['Accept Request & Go', 'قبول الطلب والتوجه للموقع', 'Accepter la demande et y aller', 'Anfrage annehmen & Los'],
  'Live location sharing enabled': ['Live location sharing enabled', 'تم تفعيل مشاركة الموقع المباشر', 'Partage de position en direct activé', 'Live-Standortfreigabe aktiviert'],
  'Live location sharing disabled': ['Live location sharing disabled', 'تم إيقاف مشاركة الموقع', 'Partage de position en direct désactivé', 'Live-Standortfreigabe deaktiviert'],
  'Background location enabled': ['Background location enabled', 'تم تفعيل الموقع في الخلفية', 'Localisation en arrière-plan activée', 'Hintergrundstandort aktiviert'],
  'Background location disabled': ['Background location disabled', 'تم إيقاف الموقع في الخلفية', 'Localisation en arrière-plan désactivée', 'Hintergrundstandort deaktiviert'],
  'Update your personal information': ['Update your personal information', 'تحديث معلوماتك الشخصية', 'Mettre à jour vos informations', 'Aktualisieren Sie Ihre persönlichen Daten'],
  'Password reset email sent!': ['Password reset email sent!', 'تم إرسال رابط إعادة تعيين كلمة المرور!', 'Email de réinitialisation envoyé!', 'Passwort-Reset-E-Mail gesendet!'],
  'Hello! I am your E-Assist AI Emergency Assistant. How can I help you today? I can provide first aid advice, explain emergency procedures, or help you find resources.': ['Hello! I am your E-Assist AI Emergency Assistant. How can I help you today? I can provide first aid advice, explain emergency procedures, or help you find resources.', 'مرحباً! أنا مساعد E-Assist الذكي للطوارئ. كيف يمكنني مساعدتك اليوم؟ يمكنني تقديم إرشادات الإسعافات الأولية، شرح إجراءات الطوارئ، أو المساعدة في العثور على الموارد.', 'Bonjour! Je suis votre assistant d\'urgence IA. Comment puis-je vous aider?', 'Hallo! Ich bin Ihr KI-Notfallassistent. Wie kann ich helfen?'],
  'AI Emergency Assistant': ['AI Emergency Assistant', 'مساعد الطوارئ الذكي', 'Assistant d\'urgence IA', 'KI-Notfallassistent'],
  'Note: This assistant is for general first aid advice. For critical emergencies, call 123 immediately.': ['Note: This assistant is for general first aid advice. For critical emergencies, call 123 immediately.', 'ملاحظة: هذا المساعد لتقديم إرشادات الإسعافات الأولية العامة. في الحالات الخطيرة، اتصل فوراً بالرقم 123.', 'Note: Pour les urgences critiques, appelez le 123.', 'Hinweis: Rufen Sie in kritischen Notfällen sofort 123 an.'],
  'AI Assistant is thinking...': ['AI Assistant is thinking...', 'المساعد الذكي يفكر...', 'L\'assistant IA réfléchit...', 'KI-Assistent denkt nach...'],
  'Ask E-Assist AI...': ['Ask E-Assist AI...', 'اسأل مساعد الطوارئ...', 'Demander à l\'IA E-Assist...', 'Fragen Sie E-Assist KI...'],
  'No requests yet': ['No requests yet', 'لا توجد طلبات سابقة', 'Aucune demande pour le moment', 'Noch keine Anfragen'],
  'Accepted': ['Accepted', 'تم القبول', 'Accepté', 'Akzeptiert'],
  'Active SOS': ['Active SOS', 'طلبات نشطة', 'SOS actif', 'Aktives SOS'],
  'Help Received': ['Help Received', 'مساعدة تمت', 'Aide reçue', 'Hilfe erhalten'],
  'Need Immediate Help?': ['Need Immediate Help?', 'هل تحتاج إلى مساعدة فورية؟', 'Besoin d\'aide immédiate?', 'Brauchen Sie sofortige Hilfe?'],
  'Tap below to broadcast emergency request to nearby donors': ['Tap below to broadcast emergency request to nearby donors', 'اضغط أدناه لإرسال طلب طوارئ لجميع المتبرعين القريبين', 'Appuyez pour diffuser la demande', 'Tippen Sie hier, um die Anfrage zu senden'],
  '🚨 Request Emergency Aid': ['🚨 Request Emergency Aid', '🚨 اطلب مساعدة طارئة', '🚨 Demander une aide', '🚨 Notfallhilfe anfordern'],
  'Just now': ['Just now', 'الآن', 'À l\'instant', 'Gerade eben'],
};

void main() async {
  final dir = Directory('c:/development/flutter-app/first_app/lib');
  final regex = RegExp(r"(?:l10n\.)?isArabic(?:\(context\))?\s*\?\s*'([^']+)'\s*:\s*'([^']+)'");
  
  Map<String, String> newKeys = {};
  
  await for (final entity in dir.list(recursive: true)) {
    if (entity is File && entity.path.endsWith('.dart') && !entity.path.contains('app_localizations.dart')) {
      String content = await entity.readAsString();
      bool modified = false;
      
      content = content.replaceAllMapped(regex, (match) {
        String ar = match.group(1)!;
        String en = match.group(2)!;
        
        // Handle interpolations specially if needed, but for now we look up English in map
        if (translations.containsKey(en)) {
          String key = en.replaceAll(RegExp(r'[^a-zA-Z0-9]'), '');
          key = key.substring(0, 1).toLowerCase() + key.substring(1);
          if (key.length > 25) key = key.substring(0, 25);
          
          newKeys[key] = en;
          modified = true;
          return 'l10n.$key';
        }
        return match.group(0)!; // leave untouched if not in map
      });
      
      if (modified) {
        await entity.writeAsString(content);
        print("Updated ${entity.path}");
      }
    }
  }
  
  // Also we need to append the keys to app_localizations.dart
  File locFile = File('c:/development/flutter-app/first_app/lib/l10n/app_localizations.dart');
  String locContent = await locFile.readAsString();
  
  // Find where to insert map entries
  for (String lang in ['en', 'ar', 'fr', 'de']) {
    int langIndex = ['en', 'ar', 'fr', 'de'].indexOf(lang);
    String insertStr = "";
    for (String key in newKeys.keys) {
      String enText = newKeys[key]!;
      String transText = translations[enText]![langIndex].replaceAll("'", "\\'");
      insertStr += "      '$key': '$transText',\n";
    }
    
    locContent = locContent.replaceFirst("'$lang': {", "'$lang': {\n$insertStr");
  }
  
  // Generate getters
  String gettersStr = "";
  for (String key in newKeys.keys) {
    if (!locContent.contains("String get $key =>")) {
      gettersStr += "  String get $key => _('$key');\n";
    }
  }
  
  locContent = locContent.replaceFirst("class AppLocalizationsDelegate", "$gettersStr\nclass AppLocalizationsDelegate");
  
  await locFile.writeAsString(locContent);
  print("Updated app_localizations.dart");
}

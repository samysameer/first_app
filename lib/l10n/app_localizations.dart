import 'package:flutter/material.dart';

class AppLocalizations {
  final Locale locale;
  AppLocalizations(this.locale);

  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations)!;
  }

  static const _localizedValues = {
    'en': {
      'aH': 'A**** H*****',
      'lettersonly': 'Letters only',
      'enteravalidemail': 'Enter a valid email',
      'invalidEgyptianphonenumbe': 'Invalid Egyptian phone number',
      'enterapassword': 'Enter a password',
      'requestacceptedPleasehead': 'Request accepted! Please head to the location.',
      'failedtoupdatestatus': 'Failed to update status',
      'responseRate': 'Response Rate',
      'nonearbyemergenciesatthem': 'No nearby emergencies at the moment',
      'unknownLocation': 'Unknown Location',
      'allmarkedasread': 'All marked as read',
      'nonewalerts': 'No new alerts',
      'yourdonationhasbeenrecord': 'Your donation has been recorded! Thank you for your contribution.',
      'openingrequest': 'Opening request...',
      'profilephotoupdatedsucces': 'Profile photo updated successfully!',
      'hEALTHINFORMATION': 'HEALTH INFORMATION',
      'requestacceptedsuccessful': 'Request accepted successfully!',
      'somethingwentwrong': 'Something went wrong',
      'emergencyDetails': 'Emergency Details',
      'needsyourhelp': 'Needs your help',
      'description': 'Description',
      'location': 'Location',
      'contactInformation': 'Contact Information',
      'acceptRequestGo': 'Accept Request & Go',
      'livelocationsharingenable': 'Live location sharing enabled',
      'livelocationsharingdisabl': 'Live location sharing disabled',
      'backgroundlocationenabled': 'Background location enabled',
      'backgroundlocationdisable': 'Background location disabled',
      'updateyourpersonalinforma': 'Update your personal information',
      'passwordresetemailsent': 'Password reset email sent!',
      'helloIamyourEAssistAIEmer': 'Hello! I am your E-Assist AI Emergency Assistant. How can I help you today? I can provide first aid advice, explain emergency procedures, or help you find resources.',
      'aIEmergencyAssistant': 'AI Emergency Assistant',
      'noteThisassistantisforgen': 'Note: This assistant is for general first aid advice. For critical emergencies, call 123 immediately.',
      'aIAssistantisthinking': 'AI Assistant is thinking...',
      'askEAssistAI': 'Ask E-Assist AI...',
      'norequestsyet': 'No requests yet',
      'accepted': 'Accepted',
      'activeSOS': 'Active SOS',
      'helpReceived': 'Help Received',
      'needImmediateHelp': 'Need Immediate Help?',
      'tapbelowtobroadcastemerge': 'Tap below to broadcast emergency request to nearby donors',
      'requestEmergencyAid': '🚨 Request Emergency Aid',
      'justnow': 'Just now',

      // Auth & Common
      'login': 'Login',
      'email': 'Email Address',
      'phone': 'Phone Number',
      'password': 'Password',
      'forgotPassword': 'Forgot Password?',
      'dontHaveAccount': "Don't have an account? ",
      'registerNow': 'Register Now',
      'welcomeBack': 'Welcome Back',
      'savingLives': 'Login to continue saving lives',
      'donor': 'Donor',
      'requester': 'Requester',
      'copyright': '© 2026 E-Assist. All rights reserved.',
      'developedBy': 'Developed by Eng Samy Sameer',
      'verifyEmail': 'Verify Your Email',
      'verifyMsg': 'A verification link has been sent to your email. Please verify your account before logging in.',
      'sessionExpired': 'Session expired. Please log in again for your security.',
      'chooseAccount': 'Choose Account Type',
      'howUse': 'How would you like to use E-Assist?',
      'continue': 'Continue',
      'createAccount': 'Create Account',
      'fullName': 'Full Name',
      'registeringAs': 'Registering as ',
      'chooseAccountType': 'Choose Account Type',
      'howToUse': 'How would you like to use E-Assist?',
      'donorDesc': 'Donate blood and save lives in your community.',
      'requesterDesc': 'Request blood and medical help when needed.',
      'continueBtn': 'Continue',
      'register': 'Register',
      'alreadyHaveAccount': 'Already have an account? ',
      'logout': 'Logout',
      'liveAvailability': 'Live Availability',
      'appLanguage': 'App Language',
      'available': 'Available',
      'notAvailable': 'Not Available',
      'memberSince': 'Member since',
      'enterEmail': 'Enter your email',
      'enterPassword': 'Enter your password',
      'bloodTypeLabel': 'Blood Type: ',
      'Egypt': 'Egypt',
      'user': 'User',
      'enterName': 'Enter your name',
      'ok': 'OK',
      'registrationFailed': 'Registration failed',
      'unexpectedError': 'An unexpected error occurred',
      'accept': 'Accept',
      'details': 'Details',
      'urgentBloodTransfusion': 'Urgent blood transfusion for accident victim',
      'emergencySuppliesNeeded': 'Emergency medical supplies needed',
      'hospitalCairoUniv': 'Cairo University Hospital',
      'hospitalDarElFouad': 'Dar El Fouad Hospital',
      'km': 'km',
      'editProfile': 'Edit Profile',
      'donationHistory': 'Donation History',
      'requestHistory': 'Request History',
      'badgesAchievements': 'Badges & Achievements',
      'locationSettings': 'Location Settings',
      'appSettings': 'App Settings',
      'privacySecurity': 'Privacy & Security',
      'rating': 'Rating',
      'yourImpact': 'Your Impact',
      'livesSavedLabel': 'Lives Saved',
      'startJourney': 'Start your journey to save lives today!',
      'topDonors': "You're in the top 5% of donors in Cairo!",
      'moreDonationsMilestone': 'more donations to reach next milestone',
      'thisWeek': 'This Week',
      'donationsCompleted': 'donations completed',
      'nearbyEmergencies': 'Nearby Emergencies',
      'active': 'Active',
      'critical': 'CRITICAL',
      'highPriorityLabel': 'High',
      'urgentTransfusion': 'Urgent blood transfusion for accident victim',
      'notifications': 'Notifications',
      'markAllRead': 'Mark all read',
      'all': 'All',
      'emergencyTab': 'Emergency',
      'updatesTab': 'Updates',
      'newEmergencyRequest': 'New Emergency Request',
      'highPriorityRequest': 'High Priority Request',
      'requestCompleted': 'Request Completed',
      'newBadgeEarned': 'New Badge Earned!',
      'reminder': 'Reminder',
      'viewRequest': 'View Request',
      'dismiss': 'Dismiss',
      'navHome': 'Home',
      'navMap': 'Map',
      'navAlerts': 'Alerts',
      'navProfile': 'Profile',
      'changePassword': 'Change Password',
      'updateCredentials': 'Update your login credentials',
      'twoFactorAuth': 'Two-Factor Authentication',
      'extraLayerSecurity': 'Add an extra layer of security',
      'profileVisibility': 'Profile Visibility',
      'chooseWhoSeesProfile': 'Choose who can see your donor profile',
      'dataPrivacy': 'Data & Privacy',
      'downloadMyData': 'Download My Data',
      'getCopyAccountInfo': 'Get a copy of your account information',
      'deleteAccount': 'Delete Account',
      'permanentlyRemoveAccount': 'Permanently remove your account and data',
      'preferences': 'PREFERENCES',
      'pushNotifications': 'Push Notifications',
      'receiveAlertsEmergencies': 'Receive alerts for emergencies near you',
      'darkMode': 'Dark Mode',
      'switchToDarkTheme': 'Switch to a dark color theme',
      'language': 'Language',
      'about': 'ABOUT',
      'termsOfService': 'Terms of Service',
      'privacyPolicy': 'Privacy Policy',
      'appVersion': 'App Version',
      'permissions': 'Permissions',
      'shareLiveLocation': 'Share Live Location',
      'allowOthersSeeLocation': 'Allow others to see your location during emergencies',
      'backgroundLocation': 'Background Location',
      'receiveAlertsAppClosed': 'Receive alerts even when the app is closed',
      'emergencySearchRadius': 'Emergency Search Radius',
      'openSystemSettings': 'Open System Settings',
      'lifeSaver': 'Life Saver',
      'firstResponder': 'First Responder',
      'frequentDonor': 'Frequent Donor',
      'bloodHero': 'Blood Hero',
      'nightOwl': 'Night Owl',
      'communityPillar': 'Community Pillar',
      'unlocked': 'Unlocked',
      'locked': 'Locked',
      'noDonationsYet': 'No donations yet',
      'bloodDonation': 'Blood Donation',
      'medicalDonation': 'Medical Donation',
      'completedStatus': 'Completed',
      'personalInformation': 'PERSONAL INFORMATION',
      'nameHint': 'Must contain at least 2 names (e.g. First and Last)',
      'phoneHint': 'Must be exactly 11 numbers',
      'changePasswordHeader': 'CHANGE PASSWORD',
      'leaveEmptyPassword': 'Leave empty to keep your current password',
      'newPassword': 'New Password',
      'passwordHint': 'At least 6 characters, including letters, numbers & symbols',
      'donorInformation': 'DONOR INFORMATION',
      'bloodType': 'Blood Type',
      'city': 'City',
      'saveChanges': 'Save Changes',
      'nameExampleHint': 'e.g. Ahmed Hassan',
      'selectBloodTypeHint': 'Select your blood type',
      'selectCityHint': 'Select your city',
      'enterNewPasswordHint': 'Enter new password',
      'failedLoadProfile': 'Failed to load profile data',
      'profileUpdatedSuccess': 'Profile updated successfully!',
      'failedUpdateProfile': 'Failed to update profile',
      'recentLoginRequired': 'Please log out and log back in to change your password.',
      'weakPassword': 'Password is too weak. Use at least 6 characters.',
      'enterFullName': 'Please enter your full name',
      'enterTwoNames': 'Please enter at least 2 names',
      'enterPhone': 'Please enter your phone number',
      'phoneLengthError': 'Phone must be exactly 11 numbers',
      'passwordLengthError': 'Password should be at least 6 characters',
      'passwordLetterError': 'Password must contain at least one letter',
      'passwordNumberError': 'Password must contain at least one number',
      'passwordSymbolError': 'Password must contain at least one symbol',
      'selectBloodType': 'Please select your blood type',
      'selectCity': 'Please select your city',
      'searchHint': 'Search location...',
      'locationNotFound': 'Location not found. Try another search.',
      'allMarkers': 'All',
      'bloodFilter': 'Blood',
      'medicalFilter': 'Medical',
      'rescueFilter': 'Rescue',
      'criticalPriority': 'Critical',
      'highPriority': 'High',
      'mediumPriority': 'Medium',
      'cairo': 'Cairo',
      'alexandria': 'Alexandria',
      'giza': 'Giza',
      'portSaid': 'Port Said',
      'suez': 'Suez',
      'luxor': 'Luxor',
      'mansoura': 'Mansoura',
      'tanta': 'Tanta',
      'asyut': 'Asyut',
      'ismailia': 'Ismailia',
      'fayoum': 'Fayoum',
      'zagazig': 'Zagazig',
      'aswan': 'Aswan',
      'damietta': 'Damietta',
      'minya': 'Minya',
      'beniSuef': 'Beni Suef',
      'qena': 'Qena',
      'sohag': 'Sohag',
      'hurghada': 'Hurghada',
      'aiEmergencyAssistant': 'AI Emergency Assistant',
      'aiAssistantDesc': 'Get instant first aid advice and help',
      'recentRequests': 'Your Recent Requests',
      'viewAll': 'View All',
      'noRecentRequests': 'No recent requests',
      'bloodRequest': 'Blood Request',
      'medicalSuppliesRequest': 'Medical Supplies',
      'rescueRequest': 'Rescue Request',
      'howItWorks': 'How It Works',
      'submitRequestStep': 'Submit Request',
      'submitRequestDesc': 'Tap SOS and fill emergency details',
      'aiMatchingStep': 'AI Matching',
      'aiMatchingDesc': 'System finds nearby verified donors',
      'getHelpStep': 'Get Help',
      'getHelpDesc': 'Donor arrives with needed assistance',
      'emergencyRequest': 'Emergency Request',
      'selectEmergencyType': 'Select emergency type',
      'provideDetails': 'Provide details',
      'whatHelpNeeded': 'What type of help do you need?',
      'bloodDonationDesc': 'Urgent blood transfusion needed',
      'medicalSuppliesDesc': 'Medicine or medical equipment',
      'emergencyRescue': 'Emergency Rescue',
      'emergencyRescueDesc': 'Immediate physical assistance',
      'urgencyLevel': 'Urgency Level',
      'criticalLabel': 'Critical',
      'highLabel': 'High',
      'mediumLabel': 'Medium',
      'bloodTypeNeeded': 'Blood Type Needed',
      'descriptionLabel': 'Description',
      'descriptionHint': 'Describe your emergency situation...',
      'aiAnalyzing': 'AI is analyzing your situation...',
      'smartAnalyzeAI': 'Smart Analyze with AI ✨',
      'aiFirstAidTipLabel': 'AI First Aid Tip',
      'yourName': 'Your Name',
      'yourNameHint': 'Full name',
      'phoneNumber': 'Phone Number',
      'submitEmergencyRequest': '🚨 Submit Emergency Request',
      'requestSent': 'Request Sent!',
      'broadcastingMsg': 'Broadcasting to nearby donors. You should receive a match within 2-5 minutes.',
      'backToHome': 'Back to Home',
      'fillAllDetails': 'Please fill in all details',
      'longerDescriptionAI': 'Please provide a longer description for AI to analyze',
      'aiAnalysisComplete': 'AI Analysis Complete ✨',
      'aiAnalysisFailed': 'AI Analysis failed',
    },
    'ar': {
      'aH': 'أ**** ح*****',
      'lettersonly': 'أحرف فقط',
      'enteravalidemail': 'البريد غير صحيح',
      'invalidEgyptianphonenumbe': 'رقم هاتف مصري غير صحيح',
      'enterapassword': 'أدخل كلمة المرور',
      'requestacceptedPleasehead': 'تم قبول الطلب! يرجى التوجه للموقع.',
      'failedtoupdatestatus': 'فشل تحديث الحالة',
      'responseRate': 'معدل الاستجابة',
      'nonearbyemergenciesatthem': 'لا توجد حالات طوارئ قريبة حالياً',
      'unknownLocation': 'موقع غير محدد',
      'allmarkedasread': 'تم تحديد الكل كمقروء',
      'nonewalerts': 'لا توجد تنبيهات جديدة',
      'yourdonationhasbeenrecord': 'تم تسجيل تبرعك بنجاح! شكراً لمساهمتك.',
      'openingrequest': 'فتح الطلب...',
      'profilephotoupdatedsucces': 'تم تحديث صورة الملف الشخصي بنجاح!',
      'hEALTHINFORMATION': 'معلومات الصحة',
      'requestacceptedsuccessful': 'تم قبول الطلب بنجاح!',
      'somethingwentwrong': 'حدث خطأ ما',
      'emergencyDetails': 'تفاصيل الحالة',
      'needsyourhelp': 'يحتاج إلى مساعدتك',
      'description': 'وصف الحالة',
      'location': 'الموقع',
      'contactInformation': 'معلومات التواصل',
      'acceptRequestGo': 'قبول الطلب والتوجه للموقع',
      'livelocationsharingenable': 'تم تفعيل مشاركة الموقع المباشر',
      'livelocationsharingdisabl': 'تم إيقاف مشاركة الموقع',
      'backgroundlocationenabled': 'تم تفعيل الموقع في الخلفية',
      'backgroundlocationdisable': 'تم إيقاف الموقع في الخلفية',
      'updateyourpersonalinforma': 'تحديث معلوماتك الشخصية',
      'passwordresetemailsent': 'تم إرسال رابط إعادة تعيين كلمة المرور!',
      'helloIamyourEAssistAIEmer': 'مرحباً! أنا مساعد E-Assist الذكي للطوارئ. كيف يمكنني مساعدتك اليوم؟ يمكنني تقديم إرشادات الإسعافات الأولية، شرح إجراءات الطوارئ، أو المساعدة في العثور على الموارد.',
      'aIEmergencyAssistant': 'مساعد الطوارئ الذكي',
      'noteThisassistantisforgen': 'ملاحظة: هذا المساعد لتقديم إرشادات الإسعافات الأولية العامة. في الحالات الخطيرة، اتصل فوراً بالرقم 123.',
      'aIAssistantisthinking': 'المساعد الذكي يفكر...',
      'askEAssistAI': 'اسأل مساعد الطوارئ...',
      'norequestsyet': 'لا توجد طلبات سابقة',
      'accepted': 'تم القبول',
      'activeSOS': 'طلبات نشطة',
      'helpReceived': 'مساعدة تمت',
      'needImmediateHelp': 'هل تحتاج إلى مساعدة فورية؟',
      'tapbelowtobroadcastemerge': 'اضغط أدناه لإرسال طلب طوارئ لجميع المتبرعين القريبين',
      'requestEmergencyAid': '🚨 اطلب مساعدة طارئة',
      'justnow': 'الآن',

      // Auth & Common
      'login': 'تسجيل الدخول',
      'email': 'البريد الإلكتروني',
      'phone': 'رقم الهاتف',
      'password': 'كلمة المرور',
      'forgotPassword': 'نسيت كلمة المرور؟',
      'dontHaveAccount': 'ليس لديك حساب؟ ',
      'registerNow': 'سجل الآن',
      'welcomeBack': 'مرحباً بعودتك',
      'savingLives': 'سجل دخولك للمساهمة في إنقاذ الأرواح',
      'donor': 'متبرع',
      'requester': 'طالب مساعدة',
      'copyright': '© 2026 E-Assist. جميع الحقوق محفوظة.',
      'developedBy': 'تم التطوير بواسطة م/ سامي سمير',
      'verifyEmail': 'تأكيد البريد الإلكتروني',
      'verifyMsg': 'تم إرسال رابط التأكيد إلى بريدك الإلكتروني. يرجى تأكيد حسابك قبل تسجيل الدخول.',
      'sessionExpired': 'انتهت الجلسة. يرجى تسجيل الدخول مرة أخرى لأمانك.',
      'chooseAccount': 'اختر نوع الحساب',
      'howUse': 'كيف تود استخدام E-Assist؟',
      'continue': 'استمرار',
      'createAccount': 'إنشاء حساب',
      'fullName': 'الاسم الكامل',
      'registeringAs': 'التسجيل كـ ',
      'chooseAccountType': 'اختر نوع الحساب',
      'howToUse': 'كيف تود استخدام E-Assist؟',
      'donorDesc': 'تبرع بالدم وأنقذ الأرواح في مجتمعك.',
      'requesterDesc': 'اطلب الدم والمساعدة الطبية عند الحاجة.',
      'continueBtn': 'متابعة',
      'register': 'تسجيل',
      'alreadyHaveAccount': 'لديك حساب بالفعل؟ ',
      'logout': 'تسجيل الخروج',
      'liveAvailability': 'التوافر المباشر',
      'appLanguage': 'لغة التطبيق',
      'available': 'متوفر',
      'notAvailable': 'غير متوفر',
      'memberSince': 'عضو منذ',
      'enterEmail': 'أدخل بريدك الإلكتروني',
      'enterPassword': 'أدخل كلمة المرور',
      'bloodTypeLabel': 'فصيلة الدم: ',
      'Egypt': 'مصر',
      'user': 'مستخدم',
      'enterName': 'أدخل اسمك',
      'ok': 'تم',
      'registrationFailed': 'فشل التسجيل',
      'unexpectedError': 'حدث خطأ غير متوقع',
      'accept': 'قبول',
      'details': 'التفاصيل',
      'urgentBloodTransfusion': 'نقل دم عاجل لضحية حادث',
      'emergencySuppliesNeeded': 'مستلزمات طبية طارئة مطلوبة',
      'hospitalCairoUniv': 'مستشفى جامعة القاهرة',
      'hospitalDarElFouad': 'مستشفى دار الفؤاد',
      'km': 'كم',
      'editProfile': 'تعديل الملف الشخصي',
      'donationHistory': 'سجل التبرعات',
      'requestHistory': 'سجل الطلبات',
      'badgesAchievements': 'الأوسمة والإنجازات',
      'locationSettings': 'إعدادات الموقع',
      'appSettings': 'إعدادات التطبيق',
      'privacySecurity': 'الخصوصية والأمان',
      'rating': 'التقييم',
      'yourImpact': 'تأثيرك',
      'livesSavedLabel': 'حياة تم إنقاذها',
      'startJourney': 'ابدأ رحلتك لإنقاذ الأرواح اليوم!',
      'topDonors': 'أنت ضمن أفضل 5٪ من المتبرعين في القاهرة!',
      'moreDonationsMilestone': 'تبرعات إضافية للوصول إلى الإنجاز التالي',
      'thisWeek': 'هذا الأسبوع',
      'donationsCompleted': 'تبرعات مكتملة',
      'nearbyEmergencies': 'حالات طوارئ قريبة',
      'active': 'نشط',
      'critical': 'حرجة',
      'highPriorityLabel': 'عالية',
      'urgentTransfusion': 'نقل دم عاجل لضحية حادث',
      'notifications': 'الإشعارات',
      'markAllRead': 'تحديد الكل كمقروء',
      'all': 'الكل',
      'emergencyTab': 'طوارئ',
      'updatesTab': 'تحديثات',
      'newEmergencyRequest': 'طلب طوارئ جديد',
      'highPriorityRequest': 'طلب عالي الأهمية',
      'requestCompleted': 'تم اكتمال الطلب',
      'newBadgeEarned': 'تم الحصول على شارة جديدة!',
      'reminder': 'تذكير',
      'viewRequest': 'عرض الطلب',
      'dismiss': 'تجاهل',
      'navHome': 'الرئيسية',
      'navMap': 'الخريطة',
      'navAlerts': 'التنبيهات',
      'navProfile': 'الملف الشخصي',
      'changePassword': 'تغيير كلمة المرور',
      'updateCredentials': 'تحديث بيانات الدخول الخاصة بك',
      'twoFactorAuth': 'المصادقة الثنائية',
      'extraLayerSecurity': 'إضافة طبقة إضافية من الأمان',
      'profileVisibility': 'ظهور الملف الشخصي',
      'chooseWhoSeesProfile': 'اختر من يمكنه رؤية ملفك الشخصي كمتبرع',
      'dataPrivacy': 'البيانات والخصوصية',
      'downloadMyData': 'تحميل بياناتي',
      'getCopyAccountInfo': 'احصل على نسخة من معلومات حسابك',
      'deleteAccount': 'حذف الحساب',
      'permanentlyRemoveAccount': 'إزالة حسابك وبياناتك نهائياً',
      'preferences': 'التفضيلات',
      'pushNotifications': 'إشعارات الدفع',
      'receiveAlertsEmergencies': 'تلقي تنبيهات لحالات الطوارئ القريبة منك',
      'darkMode': 'الوضع الداكن',
      'switchToDarkTheme': 'التبديل إلى سمة لون داكنة',
      'language': 'اللغة',
      'about': 'حول',
      'termsOfService': 'شروط الخدمة',
      'privacyPolicy': 'سياسة الخصوصية',
      'appVersion': 'إصدار التطبيق',
      'permissions': 'الأذونات',
      'shareLiveLocation': 'مشاركة الموقع المباشر',
      'allowOthersSeeLocation': 'السماح للآخرين برؤية موقعك أثناء حالات الطوارئ',
      'backgroundLocation': 'الموقع في الخلفية',
      'receiveAlertsAppClosed': 'تلقي التنبيهات حتى عندما يكون التطبيق مغلقاً',
      'emergencySearchRadius': 'نطاق البحث عن الطوارئ',
      'openSystemSettings': 'فتح إعدادات النظام',
      'lifeSaver': 'منقذ الأرواح',
      'firstResponder': 'المستجيب الأول',
      'frequentDonor': 'متبرع دائم',
      'bloodHero': 'بطل الدم',
      'nightOwl': 'بومة الليل',
      'communityPillar': 'ركيزة المجتمع',
      'unlocked': 'تم الفتح',
      'locked': 'مغلق',
      'noDonationsYet': 'لا توجد تبرعات بعد',
      'bloodDonation': 'تبرع بالدم',
      'medicalDonation': 'تبرع طبي',
      'completedStatus': 'مكتمل',
      'personalInformation': 'المعلومات الشخصية',
      'nameHint': 'يجب أن يحتوي على اسمين على الأقل (الأول والأخير)',
      'phoneHint': 'يجب أن يكون 11 رقماً بالضبط',
      'changePasswordHeader': 'تغيير كلمة المرور',
      'leaveEmptyPassword': 'اتركه فارغاً للحفاظ على كلمة المرور الحالية',
      'newPassword': 'كلمة مرور جديدة',
      'passwordHint': '6 أحرف على الأقل، تتضمن حروفاً وأرقاماً ورموزاً',
      'donorInformation': 'معلومات المتبرع',
      'bloodType': 'فصيلة الدم',
      'city': 'المدينة',
      'saveChanges': 'حفظ التغييرات',
      'nameExampleHint': 'مثال: أحمد حسن',
      'selectBloodTypeHint': 'اختر فصيلة دمك',
      'selectCityHint': 'اختر مدينتك',
      'enterNewPasswordHint': 'أدخل كلمة مرور جديدة',
      'failedLoadProfile': 'فشل تحميل بيانات الملف الشخصي',
      'profileUpdatedSuccess': 'تم تحديث الملف الشخصي بنجاح!',
      'failedUpdateProfile': 'فشل تحديث الملف الشخصي',
      'recentLoginRequired': 'يرجى تسجيل الخروج والعودة لتغيير كلمة المرور.',
      'weakPassword': 'كلمة المرور ضعيفة جداً. استخدم 6 أحرف على الأقل.',
      'enterFullName': 'يرجى إدخال اسمك الكامل',
      'enterTwoNames': 'يرجى إدخال اسمين على الأقل',
      'enterPhone': 'يرجى إدخال رقم هاتفك',
      'phoneLengthError': 'يجب أن يكون الهاتف 11 رقماً بالضبط',
      'passwordLengthError': 'يجب أن تكون كلمة المرور 6 أحرف على الأقل',
      'passwordLetterError': 'يجب أن تحتوي كلمة المرور على حرف واحد على الأقل',
      'passwordNumberError': 'يجب أن تحتوي كلمة المرور على رقم واحد على الأقل',
      'passwordSymbolError': 'يجب أن تحتوي كلمة المرور على رمز واحد على الأقل',
      'selectBloodType': 'يرجى اختيار فصيلة دمك',
      'selectCity': 'يرجى اختيار مدينتك',
      'searchHint': 'ابحث عن موقع...',
      'locationNotFound': 'الموقع غير موجود. حاول البحث مرة أخرى.',
      'allMarkers': 'الكل',
      'bloodFilter': 'دم',
      'medicalFilter': 'طبي',
      'rescueFilter': 'إنقاذ',
      'criticalPriority': 'حرجة',
      'highPriority': 'عالية',
      'mediumPriority': 'متوسطة',
      'cairo': 'القاهرة',
      'alexandria': 'الإسكندرية',
      'giza': 'الجيزة',
      'portSaid': 'بورسعيد',
      'suez': 'السويس',
      'luxor': 'الأقصر',
      'mansoura': 'المنصورة',
      'tanta': 'طنطا',
      'asyut': 'أسيوط',
      'ismailia': 'الإسماعيلية',
      'fayoum': 'الفيوم',
      'zagazig': 'الزقازيق',
      'aswan': 'أسوان',
      'damietta': 'دمياط',
      'minya': 'المنيا',
      'beniSuef': 'بني سويف',
      'qena': 'قنا',
      'sohag': 'سوهاج',
      'hurghada': 'الغردقة',
      'aiEmergencyAssistant': 'مساعد الطوارئ بالذكاء الاصطناعي',
      'aiAssistantDesc': 'احصل على نصائح فورية للإسعافات الأولية والمساعدة',
      'recentRequests': 'طلباتك الأخيرة',
      'viewAll': 'عرض الكل',
      'noRecentRequests': 'لا توجد طلبات سابقة',
      'bloodRequest': 'طلب دم',
      'medicalSuppliesRequest': 'مستلزمات طبية',
      'rescueRequest': 'طلب إنقاذ',
      'howItWorks': 'كيف يعمل التطبيق',
      'submitRequestStep': 'إرسال الطلب',
      'submitRequestDesc': 'اضغط على SOS واملأ تفاصيل الطوارئ',
      'aiMatchingStep': 'مطابقة الذكاء الاصطناعي',
      'aiMatchingDesc': 'النظام يجد متبرعين موثوقين قريبين منك',
      'getHelpStep': 'احصل على المساعدة',
      'getHelpDesc': 'يصل المتبرع مع المساعدة المطلوبة',
      'emergencyRequest': 'طلب طوارئ',
      'selectEmergencyType': 'اختر نوع الطوارئ',
      'provideDetails': 'قدم التفاصيل',
      'whatHelpNeeded': 'ما نوع المساعدة التي تحتاجها؟',
      'bloodDonationDesc': 'نقل دم عاجل مطلوب',
      'medicalSuppliesDesc': 'أدوية أو معدات طبية',
      'emergencyRescue': 'إنقاذ طارئ',
      'emergencyRescueDesc': 'مساعدة بدنية فورية',
      'urgencyLevel': 'مستوى الأهمية',
      'criticalLabel': 'حرجة',
      'highLabel': 'عالية',
      'mediumLabel': 'متوسطة',
      'bloodTypeNeeded': 'فصيلة الدم المطلوبة',
      'descriptionLabel': 'الوصف',
      'descriptionHint': 'صف حالة الطوارئ الخاصة بك...',
      'aiAnalyzing': 'الذكاء الاصطناعي يحلل حالتك...',
      'smartAnalyzeAI': 'تحليل ذكي بالذكاء الاصطناعي ✨',
      'aiFirstAidTipLabel': 'نصيحة الإسعافات الأولية من الذكاء الاصطناعي',
      'yourName': 'اسمك',
      'yourNameHint': 'الاسم الكامل',
      'phoneNumber': 'رقم الهاتف',
      'submitEmergencyRequest': '🚨 إرسال طلب الطوارئ',
      'requestSent': 'تم إرسال الطلب!',
      'broadcastingMsg': 'يتم البث للمتبرعين القريبين. يجب أن تحصل على استجابة خلال 2-5 دقائق.',
      'backToHome': 'العودة للرئيسية',
      'fillAllDetails': 'يرجى ملء جميع التفاصيل',
      'longerDescriptionAI': 'يرجى تقديم وصف أطول ليتمكن الذكاء الاصطناعي من تحليله',
      'aiAnalysisComplete': 'اكتمل تحليل الذكاء الاصطناعي ✨',
      'aiAnalysisFailed': 'فشل تحليل الذكاء الاصطناعي',
    },
    'fr': {
      'aH': 'A**** H*****',
      'lettersonly': 'Lettres uniquement',
      'enteravalidemail': 'Entrez un email valide',
      'invalidEgyptianphonenumbe': 'Numéro égyptien invalide',
      'enterapassword': 'Entrez un mot de passe',
      'requestacceptedPleasehead': 'Demande acceptée! Veuillez vous rendre sur place.',
      'failedtoupdatestatus': 'Échec de la mise à jour du statut',
      'responseRate': 'Taux de réponse',
      'nonearbyemergenciesatthem': 'Aucune urgence à proximité pour le moment',
      'unknownLocation': 'Lieu inconnu',
      'allmarkedasread': 'Tout marqué comme lu',
      'nonewalerts': 'Aucune nouvelle alerte',
      'yourdonationhasbeenrecord': 'Votre don a été enregistré! Merci pour votre contribution.',
      'openingrequest': 'Ouverture de la demande...',
      'profilephotoupdatedsucces': 'Photo de profil mise à jour avec succès!',
      'hEALTHINFORMATION': 'INFORMATIONS SUR LA SANTÉ',
      'requestacceptedsuccessful': 'Demande acceptée avec succès!',
      'somethingwentwrong': 'Un problème est survenu',
      'emergencyDetails': 'Détails de l\'urgence',
      'needsyourhelp': 'A besoin de votre aide',
      'description': 'Description',
      'location': 'Emplacement',
      'contactInformation': 'Coordonnées',
      'acceptRequestGo': 'Accepter la demande et y aller',
      'livelocationsharingenable': 'Partage de position en direct activé',
      'livelocationsharingdisabl': 'Partage de position en direct désactivé',
      'backgroundlocationenabled': 'Localisation en arrière-plan activée',
      'backgroundlocationdisable': 'Localisation en arrière-plan désactivée',
      'updateyourpersonalinforma': 'Mettre à jour vos informations',
      'passwordresetemailsent': 'Email de réinitialisation envoyé!',
      'helloIamyourEAssistAIEmer': 'Bonjour! Je suis votre assistant d\'urgence IA. Comment puis-je vous aider?',
      'aIEmergencyAssistant': 'Assistant d\'urgence IA',
      'noteThisassistantisforgen': 'Note: Pour les urgences critiques, appelez le 123.',
      'aIAssistantisthinking': 'L\'assistant IA réfléchit...',
      'askEAssistAI': 'Demander à l\'IA E-Assist...',
      'norequestsyet': 'Aucune demande pour le moment',
      'accepted': 'Accepté',
      'activeSOS': 'SOS actif',
      'helpReceived': 'Aide reçue',
      'needImmediateHelp': 'Besoin d\'aide immédiate?',
      'tapbelowtobroadcastemerge': 'Appuyez pour diffuser la demande',
      'requestEmergencyAid': '🚨 Demander une aide',
      'justnow': 'À l\'instant',

      // Auth & Common
      'login': 'Connexion',
      'email': 'Adresse e-mail',
      'phone': 'Numéro de téléphone',
      'password': 'Mot de passe',
      'forgotPassword': 'Mot de passe oublié ?',
      'dontHaveAccount': "Vous n'avez pas de compte ? ",
      'registerNow': "S'inscrire maintenant",
      'welcomeBack': 'Bon retour',
      'savingLives': 'Connectez-vous pour continuer à sauver des vies',
      'donor': 'Donneur',
      'requester': 'Demandeur',
      'copyright': '© 2026 E-Assist. Tous droits réservés.',
      'developedBy': "Développé par l'ingénieur Samy Sameer",
      'verifyEmail': 'Vérifiez votre e-mail',
      'verifyMsg': 'Un lien de vérification a été envoyé à votre adresse e-mail. Veuillez vérifier votre compte avant de vous connecter.',
      'sessionExpired': 'Session expirée. Veuillez vous reconnecter pour votre sécurité.',
      'chooseAccount': 'Choisir le type de compte',
      'howUse': 'Comment aimeriez-vous utiliser E-Assist ?',
      'continue': 'Continuer',
      'createAccount': 'Créer un compte',
      'fullName': 'Nom complet',
      'registeringAs': 'Inscription en tant que ',
      'chooseAccountType': 'Choisir le type de compte',
      'howToUse': 'Comment aimeriez-vous utiliser E-Assist ?',
      'donorDesc': 'Faites un don de sang et sauvez des vies dans votre communauté.',
      'requesterDesc': "Demandez du sang et de l'aide médicale en cas de besoin.",
      'continueBtn': 'Continuer',
      'register': 'S\'inscrire',
      'alreadyHaveAccount': 'Vous avez déjà un compte ? ',
      'logout': 'Déconnexion',
      'liveAvailability': 'Disponibilité en direct',
      'appLanguage': 'Langue de l\'application',
      'available': 'Disponible',
      'notAvailable': 'Non disponible',
      'memberSince': 'Membre depuis',
      'enterEmail': 'Entrez votre e-mail',
      'enterPassword': 'Entrez votre mot de passe',
      'bloodTypeLabel': 'Groupe sanguin : ',
      'Egypt': 'Égypte',
      'user': 'Utilisateur',
      'enterName': 'Entrez votre nom',
      'ok': 'OK',
      'registrationFailed': 'L\'inscription a échoué',
      'unexpectedError': 'Une erreur inattendue est survenue',
      'accept': 'Accepter',
      'details': 'Détails',
      'urgentBloodTransfusion': 'Transfusion sanguine urgente pour victime d\'accident',
      'emergencySuppliesNeeded': 'Fournitures médicales d\'urgence nécessaires',
      'hospitalCairoUniv': 'Hôpital universitaire du Caire',
      'hospitalDarElFouad': 'Hôpital Dar El Fouad',
      'km': 'km',
      'editProfile': 'Modifier le profil',
      'donationHistory': 'Historique des dons',
      'requestHistory': 'Historique des demandes',
      'badgesAchievements': 'Badges & Succès',
      'locationSettings': 'Paramètres de localisation',
      'appSettings': 'Paramètres de l\'app',
      'privacySecurity': 'Confidentialité & Sécurité',
      'rating': 'Évaluation',
      'yourImpact': 'Votre Impact',
      'livesSavedLabel': 'Vies sauvées',
      'startJourney': 'Commencez votre voyage pour sauver des vies aujourd\'hui !',
      'topDonors': 'Vous faites partie des top 5% des donneurs au Caire !',
      'moreDonationsMilestone': 'dons supplémentaires pour le prochain jalon',
      'thisWeek': 'Cette semaine',
      'donationsCompleted': 'dons effectués',
      'nearbyEmergencies': 'Urgences à proximité',
      'active': 'Actif',
      'critical': 'CRITIQUE',
      'highPriorityLabel': 'Haute',
      'urgentTransfusion': 'Transfusion sanguine urgente pour victime d\'accident',
      'notifications': 'Notifications',
      'markAllRead': 'Tout marquer comme lu',
      'all': 'Tout',
      'emergencyTab': 'Urgence',
      'updatesTab': 'Mises à jour',
      'newEmergencyRequest': 'Nouvelle demande d\'urgence',
      'highPriorityRequest': 'Demande de haute priorité',
      'requestCompleted': 'Demande terminée',
      'newBadgeEarned': 'Nouveau badge obtenu !',
      'reminder': 'Rappel',
      'viewRequest': 'Voir la demande',
      'dismiss': 'Ignorer',
      'navHome': 'Accueil',
      'navMap': 'Carte',
      'navAlerts': 'Alertes',
      'navProfile': 'Profil',
      'changePassword': 'Modifier le mot de passe',
      'updateCredentials': 'Mettre à jour vos identifiants de connexion',
      'twoFactorAuth': 'Authentification à deux facteurs',
      'extraLayerSecurity': 'Ajouter une couche de sécurité supplémentaire',
      'profileVisibility': 'Visibilité du profil',
      'chooseWhoSeesProfile': 'Choisissez qui peut voir votre profil de donneur',
      'dataPrivacy': 'Données & Confidentialité',
      'downloadMyData': 'Télécharger mes données',
      'getCopyAccountInfo': 'Obtenez une copie des informations de votre compte',
      'deleteAccount': 'Supprimer le compte',
      'permanentlyRemoveAccount': 'Supprimer définitivement votre compte et vos données',
      'preferences': 'PRÉFÉRENCES',
      'pushNotifications': 'Notifications Push',
      'receiveAlertsEmergencies': 'Recevoir des alertes pour les urgences proches de vous',
      'darkMode': 'Mode sombre',
      'switchToDarkTheme': 'Passer à un thème de couleur sombre',
      'language': 'Langue',
      'about': 'À PROPOS',
      'termsOfService': 'Conditions d\'utilisation',
      'privacyPolicy': 'Politique de confidentialité',
      'appVersion': 'Version de l\'app',
      'permissions': 'Autorisations',
      'shareLiveLocation': 'Partager la position en direct',
      'allowOthersSeeLocation': 'Autoriser les autres à voir votre position pendant les urgences',
      'backgroundLocation': 'Position en arrière-plan',
      'receiveAlertsAppClosed': 'Recevoir des alertes même si l\'application est fermée',
      'emergencySearchRadius': 'Rayon de recherche d\'urgence',
      'openSystemSettings': 'Ouvrir les paramètres système',
      'lifeSaver': 'Sauveur de vies',
      'firstResponder': 'Premier répondant',
      'frequentDonor': 'Donneur fréquent',
      'bloodHero': 'Héros du sang',
      'nightOwl': 'Oiseau de nuit',
      'communityPillar': 'Pilier de la communauté',
      'unlocked': 'Déverrouillé',
      'locked': 'Verrouillé',
      'noDonationsYet': 'Aucun don pour le moment',
      'bloodDonation': 'Don de sang',
      'medicalDonation': 'Don médical',
      'completedStatus': 'Terminé',
      'personalInformation': 'INFORMATIONS PERSONNELLES',
      'nameHint': 'Doit contenir au moins 2 noms (ex. Prénom et Nom)',
      'phoneHint': 'Doit comporter exactement 11 chiffres',
      'changePasswordHeader': 'CHANGER LE MOT DE PASSE',
      'leaveEmptyPassword': 'Laisser vide pour conserver le mot de passe actuel',
      'newPassword': 'Nouveau mot de passe',
      'passwordHint': 'Au moins 6 caractères, comprenant lettres, chiffres & symboles',
      'donorInformation': 'INFORMATIONS DU DONNEUR',
      'bloodType': 'Groupe sanguin',
      'city': 'Ville',
      'saveChanges': 'Enregistrer',
      'nameExampleHint': 'ex. Ahmed Hassan',
      'selectBloodTypeHint': 'Sélectionnez votre groupe sanguin',
      'selectCityHint': 'Sélectionnez votre ville',
      'enterNewPasswordHint': 'Entrez le nouveau mot de passe',
      'failedLoadProfile': 'Échec du chargement du profil',
      'profileUpdatedSuccess': 'Profil mis à jour avec succès !',
      'failedUpdateProfile': 'Échec de la mise à jour du profil',
      'recentLoginRequired': 'Veuillez vous déconnecter et vous reconnecter pour changer de mot de passe.',
      'weakPassword': 'Mot de passe trop faible. Utilisez au moins 6 caractères.',
      'enterFullName': 'Veuillez entrer votre nom complet',
      'enterTwoNames': 'Veuillez entrer au moins 2 noms',
      'enterPhone': 'Veuillez entrer votre numéro de téléphone',
      'phoneLengthError': 'Le téléphone doit comporter exactement 11 chiffres',
      'passwordLengthError': 'Le mot de passe doit comporter au moins 6 caractères',
      'passwordLetterError': 'Le mot de passe doit contenir au moins une lettre',
      'passwordNumberError': 'Le mot de passe doit contenir au moins un chiffre',
      'passwordSymbolError': 'Le mot de passe doit contenir au moins un symbole',
      'selectBloodType': 'Veuillez sélectionner votre groupe sanguin',
      'selectCity': 'Veuillez sélectionner votre ville',
      'searchHint': 'Rechercher un lieu...',
      'locationNotFound': 'Lieu introuvable. Réessayez.',
      'allMarkers': 'Tout',
      'bloodFilter': 'Sang',
      'medicalFilter': 'Médical',
      'rescueFilter': 'Secours',
      'criticalPriority': 'Critique',
      'highPriority': 'Haute',
      'mediumPriority': 'Moyenne',
      'cairo': 'Le Caire',
      'alexandria': 'Alexandrie',
      'giza': 'Gizeh',
      'portSaid': 'Port-Saïd',
      'suez': 'Suez',
      'luxor': 'Louxor',
      'mansoura': 'Mansourah',
      'tanta': 'Tanta',
      'asyut': 'Assiout',
      'ismailia': 'Ismaïlia',
      'fayoum': 'Fayoum',
      'zagazig': 'Zagazig',
      'aswan': 'Assouan',
      'damietta': 'Damiette',
      'minya': 'Minya',
      'beniSuef': 'Beni Suef',
      'qena': 'Qena',
      'sohag': 'Sohag',
      'hurghada': 'Hurghada',
      'aiEmergencyAssistant': 'Assistant d\'urgence IA',
      'aiAssistantDesc': 'Obtenez des conseils de premiers secours instantanés',
      'recentRequests': 'Vos demandes récentes',
      'viewAll': 'Voir tout',
      'noRecentRequests': 'Aucune demande récente',
      'bloodRequest': 'Demande de sang',
      'medicalSuppliesRequest': 'Fournitures médicales',
      'rescueRequest': 'Demande de secours',
      'howItWorks': 'Comment ça marche',
      'submitRequestStep': 'Soumettre la demande',
      'submitRequestDesc': 'Appuyez sur SOS et remplissez les détails',
      'aiMatchingStep': 'Correspondance IA',
      'aiMatchingDesc': 'Le système trouve des donneurs vérifiés à proximité',
      'getHelpStep': 'Obtenir de l\'aide',
      'getHelpDesc': 'Le donneur arrive avec l\'aide demandée',
      'emergencyRequest': 'Demande d\'urgence',
      'selectEmergencyType': 'Sélectionner le type d\'urgence',
      'provideDetails': 'Fournir des détails',
      'whatHelpNeeded': 'De quel type d\'aide avez-vous besoin ?',
      'bloodDonationDesc': 'Transfusion sanguine urgente requise',
      'medicalSuppliesDesc': 'Médicaments ou équipements médicaux',
      'emergencyRescue': 'Secours d\'urgence',
      'emergencyRescueDesc': 'Assistance physique immédiate',
      'urgencyLevel': 'Niveau d\'urgence',
      'criticalLabel': 'Critique',
      'highLabel': 'Haute',
      'mediumLabel': 'Moyenne',
      'bloodTypeNeeded': 'Groupe sanguin requis',
      'descriptionLabel': 'Description',
      'descriptionHint': 'Décrivez votre situation d\'urgence...',
      'aiAnalyzing': 'L\'IA analyse votre situation...',
      'smartAnalyzeAI': 'Analyse intelligente IA ✨',
      'aiFirstAidTipLabel': 'Conseil de premiers secours IA',
      'yourName': 'Votre nom',
      'yourNameHint': 'Nom complet',
      'phoneNumber': 'Numéro de téléphone',
      'submitEmergencyRequest': '🚨 Envoyer la demande d\'urgence',
      'requestSent': 'Demande envoyée !',
      'broadcastingMsg': 'Diffusion aux donneurs proches. Vous devriez recevoir une réponse dans 2 à 5 minutes.',
      'backToHome': 'Retour à l\'accueil',
      'fillAllDetails': 'Veuillez remplir tous les détails',
      'longerDescriptionAI': 'Veuillez fournir une description plus longue pour l\'analyse IA',
      'aiAnalysisComplete': 'Analyse IA terminée ✨',
      'aiAnalysisFailed': 'L\'analyse IA a échoué',
    },
    'de': {
      'aH': 'A**** H*****',
      'lettersonly': 'Nur Buchstaben',
      'enteravalidemail': 'Gültige E-Mail eingeben',
      'invalidEgyptianphonenumbe': 'Ungültige ägyptische Nummer',
      'enterapassword': 'Passwort eingeben',
      'requestacceptedPleasehead': 'Anfrage akzeptiert! Bitte begeben Sie sich zum Ort.',
      'failedtoupdatestatus': 'Statusaktualisierung fehlgeschlagen',
      'responseRate': 'Rücklaufquote',
      'nonearbyemergenciesatthem': 'Derzeit keine Notfälle in der Nähe',
      'unknownLocation': 'Unbekannter Ort',
      'allmarkedasread': 'Alle als gelesen markiert',
      'nonewalerts': 'Keine neuen Benachrichtigungen',
      'yourdonationhasbeenrecord': 'Ihre Spende wurde registriert! Danke für Ihren Beitrag.',
      'openingrequest': 'Anfrage wird geöffnet...',
      'profilephotoupdatedsucces': 'Profilbild erfolgreich aktualisiert!',
      'hEALTHINFORMATION': 'GESUNDHEITSINFORMATIONEN',
      'requestacceptedsuccessful': 'Anfrage erfolgreich akzeptiert!',
      'somethingwentwrong': 'Etwas ist schiefgelaufen',
      'emergencyDetails': 'Notfalldetails',
      'needsyourhelp': 'Braucht Ihre Hilfe',
      'description': 'Beschreibung',
      'location': 'Standort',
      'contactInformation': 'Kontaktinformationen',
      'acceptRequestGo': 'Anfrage annehmen & Los',
      'livelocationsharingenable': 'Live-Standortfreigabe aktiviert',
      'livelocationsharingdisabl': 'Live-Standortfreigabe deaktiviert',
      'backgroundlocationenabled': 'Hintergrundstandort aktiviert',
      'backgroundlocationdisable': 'Hintergrundstandort deaktiviert',
      'updateyourpersonalinforma': 'Aktualisieren Sie Ihre persönlichen Daten',
      'passwordresetemailsent': 'Passwort-Reset-E-Mail gesendet!',
      'helloIamyourEAssistAIEmer': 'Hallo! Ich bin Ihr KI-Notfallassistent. Wie kann ich helfen?',
      'aIEmergencyAssistant': 'KI-Notfallassistent',
      'noteThisassistantisforgen': 'Hinweis: Rufen Sie in kritischen Notfällen sofort 123 an.',
      'aIAssistantisthinking': 'KI-Assistent denkt nach...',
      'askEAssistAI': 'Fragen Sie E-Assist KI...',
      'norequestsyet': 'Noch keine Anfragen',
      'accepted': 'Akzeptiert',
      'activeSOS': 'Aktives SOS',
      'helpReceived': 'Hilfe erhalten',
      'needImmediateHelp': 'Brauchen Sie sofortige Hilfe?',
      'tapbelowtobroadcastemerge': 'Tippen Sie hier, um die Anfrage zu senden',
      'requestEmergencyAid': '🚨 Notfallhilfe anfordern',
      'justnow': 'Gerade eben',

      // Auth & Common
      'login': 'Einloggen',
      'email': 'E-Mail-Adresse',
      'phone': 'Telefonnummer',
      'password': 'Passwort',
      'forgotPassword': 'Passwort vergessen?',
      'dontHaveAccount': 'Haben Sie kein Konto? ',
      'registerNow': 'Jetzt registrieren',
      'welcomeBack': 'Willkommen zurück',
      'savingLives': 'Loggen Sie sich ein, um weiterhin Leben zu retten',
      'donor': 'Spender',
      'requester': 'Empfänger',
      'copyright': '© 2026 E-Assist. Alle Rechte vorbehalten.',
      'developedBy': 'Entwickelt von Ing. Samy Sameer',
      'verifyEmail': 'E-Mail verifizieren',
      'verifyMsg': 'Ein Bestätigungslink wurde an Ihre E-Mail gesendet. Bitte verifizieren Sie Ihr Konto vor dem Anmelden.',
      'sessionExpired': 'Sitzung abgelaufen. Bitte melden Sie sich zu Ihrer Sicherheit erneut an.',
      'chooseAccount': 'Kontotyp wählen',
      'howUse': 'Wie möchten Sie E-Assist nutzen?',
      'continue': 'Weiter',
      'createAccount': 'Konto erstellen',
      'fullName': 'Vollständiger Name',
      'registeringAs': 'Registrierung als ',
      'chooseAccountType': 'Kontotyp wählen',
      'howToUse': 'Wie möchten Sie E-Assist nutzen?',
      'donorDesc': 'Spenden Sie Blut und retten Sie Leben in Ihrer Gemeinschaft.',
      'requesterDesc': 'Fordern Sie bei Bedarf Blut und medizinische Hilfe an.',
      'continueBtn': 'Weiter',
      'register': 'Registrieren',
      'alreadyHaveAccount': 'Haben Sie bereits ein Konto? ',
      'logout': 'Abmelden',
      'liveAvailability': 'Live-Verfügbarkeit',
      'appLanguage': 'App-Sprache',
      'available': 'Verfügbar',
      'notAvailable': 'Nicht verfügbar',
      'memberSince': 'Mitglied seit',
      'enterEmail': 'Geben Sie Ihre E-Mail ein',
      'enterPassword': 'Geben Sie Ihr Passwort ein',
      'bloodTypeLabel': 'Blutgruppe: ',
      'Egypt': 'Ägypten',
      'user': 'Benutzer',
      'enterName': 'Geben Sie Ihren Namen ein',
      'ok': 'OK',
      'registrationFailed': 'Registrierung fehlgeschlagen',
      'unexpectedError': 'Ein unerwarteter Fehler ist aufgetreten',
      'accept': 'Akzeptieren',
      'details': 'Details',
      'urgentBloodTransfusion': 'Dringende Bluttransfusion für Unfallopfer',
      'emergencySuppliesNeeded': 'Dringend benötigter medizinischer Bedarf',
      'hospitalCairoUniv': 'Cairo University Hospital',
      'hospitalDarElFouad': 'Dar El Fouad Hospital',
      'km': 'km',
      'editProfile': 'Profil bearbeiten',
      'donationHistory': 'Spendenhistorie',
      'requestHistory': 'Anfrageverlauf',
      'badgesAchievements': 'Abzeichen & Erfolge',
      'locationSettings': 'Standorteinstellungen',
      'appSettings': 'App-Einstellungen',
      'privacySecurity': 'Datenschutz & Sicherheit',
      'rating': 'Bewertung',
      'yourImpact': 'Ihr Einfluss',
      'livesSavedLabel': 'Gerettete Leben',
      'startJourney': 'Beginnen Sie noch heute Ihre Reise, um Leben zu retten!',
      'topDonors': 'Sie gehören zu den besten 5% der Spender in Kairo!',
      'moreDonationsMilestone': 'weitere Spenden bis zum nächsten Meilenstein',
      'thisWeek': 'Diese Woche',
      'donationsCompleted': 'Spenden abgeschlossen',
      'nearbyEmergencies': 'Notfälle in der Nähe',
      'active': 'Aktiv',
      'critical': 'KRITISCH',
      'highPriorityLabel': 'Hoch',
      'urgentTransfusion': 'Dringende Bluttransfusion für Unfallopfer',
      'notifications': 'Benachrichtigungen',
      'markAllRead': 'Alle als gelesen markieren',
      'all': 'Alle',
      'emergencyTab': 'Notfall',
      'updatesTab': 'Updates',
      'newEmergencyRequest': 'Neue Notfallanfrage',
      'highPriorityRequest': 'Anfrage mit hoher Priorität',
      'requestCompleted': 'Anfrage abgeschlossen',
      'newBadgeEarned': 'Neues Abzeichen erhalten!',
      'reminder': 'Erinnerung',
      'viewRequest': 'Anfrage anzeigen',
      'dismiss': 'Verwerfen',
      'navHome': 'Startseite',
      'navMap': 'Karte',
      'navAlerts': 'Warnungen',
      'navProfile': 'Profil',
      'changePassword': 'Passwort ändern',
      'updateCredentials': 'Aktualisieren Sie Ihre Zugangsdaten',
      'twoFactorAuth': 'Zwei-Faktor-Authentifizierung',
      'extraLayerSecurity': 'Zusätzliche Sicherheitsstufe hinzufügen',
      'profileVisibility': 'Profilsichtbarkeit',
      'chooseWhoSeesProfile': 'Wählen Sie, wer Ihr Spenderprofil sehen kann',
      'dataPrivacy': 'Daten & Datenschutz',
      'downloadMyData': 'Meine Daten herunterladen',
      'getCopyAccountInfo': 'Fordern Sie eine Kopie Ihrer Kontoinformationen an',
      'deleteAccount': 'Konto löschen',
      'permanentlyRemoveAccount': 'Löschen Sie Ihr Konto und Ihre Daten dauerhaft',
      'preferences': 'EINSTELLUNGEN',
      'pushNotifications': 'Push-Benachrichtigungen',
      'receiveAlertsEmergencies': 'Erhalten Sie Warnungen für Notfälle in Ihrer Nähe',
      'darkMode': 'Dunkelmodus',
      'switchToDarkTheme': 'Zu einem dunklen Farbthema wechseln',
      'language': 'Sprache',
      'about': 'ÜBER UNS',
      'termsOfService': 'Nutzungsbedingungen',
      'privacyPolicy': 'Datenschutz-Bestimmungen',
      'appVersion': 'App-Version',
      'permissions': 'Berechtigungen',
      'shareLiveLocation': 'Live-Standort teilen',
      'allowOthersSeeLocation': 'Anderen erlauben, Ihren Standort bei Notfällen zu sehen',
      'backgroundLocation': 'Hintergrund-Standort',
      'receiveAlertsAppClosed': 'Warnungen erhalten, auch wenn die App geschlossen ist',
      'emergencySearchRadius': 'Notfallsuchradius',
      'openSystemSettings': 'Systemeinstellungen öffnen',
      'lifeSaver': 'Lebensretter',
      'firstResponder': 'Ersthelfer',
      'frequentDonor': 'Häufiger Spender',
      'bloodHero': 'Blutheld',
      'nightOwl': 'Nachtschwärmer',
      'communityPillar': 'Stütze der Gemeinschaft',
      'unlocked': 'Freigeschaltet',
      'locked': 'Gesperrt',
      'noDonationsYet': 'Noch keine Spenden',
      'bloodDonation': 'Blutspende',
      'medicalDonation': 'Medizinische Spende',
      'completedStatus': 'Abgeschlossen',
      'personalInformation': 'PERSÖNLICHE ANGABEN',
      'nameHint': 'Muss mindestens 2 Namen enthalten (z.B. Vor- und Nachname)',
      'phoneHint': 'Muss genau 11 Zahlen lang sein',
      'changePasswordHeader': 'PASSWORT ÄNDERN',
      'leaveEmptyPassword': 'Leer lassen, um das aktuelle Passwort zu behalten',
      'newPassword': 'Neues Passwort',
      'passwordHint': 'Mindestens 6 Zeichen, einschließlich Buchstaben, Zahlen & Symbole',
      'donorInformation': 'SPENDERINFORMATIONEN',
      'bloodType': 'Blutgruppe',
      'city': 'Stadt',
      'saveChanges': 'Änderungen speichern',
      'nameExampleHint': 'z.B. Ahmed Hassan',
      'selectBloodTypeHint': 'Wählen Sie Ihre Blutgruppe',
      'selectCityHint': 'Wählen Sie Ihre Stadt',
      'enterNewPasswordHint': 'Neues Passwort eingeben',
      'failedLoadProfile': 'Profildaten konnten nicht geladen werden',
      'profileUpdatedSuccess': 'Profil erfolgreich aktualisiert!',
      'failedUpdateProfile': 'Profilaktualisierung fehlgeschlagen',
      'recentLoginRequired': 'Bitte melden Sie sich ab und wieder an, um Ihr Passwort zu ändern.',
      'weakPassword': 'Passwort ist zu schwach. Verwenden Sie mindestens 6 Zeichen.',
      'enterFullName': 'Bitte geben Sie Ihren vollständigen Namen ein',
      'enterTwoNames': 'Bitte geben Sie mindestens 2 Namen ein',
      'enterPhone': 'Bitte geben Sie Ihre Telefonnummer ein',
      'phoneLengthError': 'Die Telefonnummer muss genau 11 Ziffern lang sein',
      'passwordLengthError': 'Das Passwort muss mindestens 6 Zeichen lang sein',
      'passwordLetterError': 'Das Passwort muss mindestens einen Buchstaben enthalten',
      'passwordNumberError': 'Das Passwort muss mindestens eine Zahl enthalten',
      'passwordSymbolError': 'Das Passwort muss mindestens ein Sonderzeichen enthalten',
      'selectBloodType': 'Bitte wählen Sie Ihre Blutgruppe',
      'selectCity': 'Bitte wählen Sie Ihre Stadt',
      'searchHint': 'Ort suchen...',
      'locationNotFound': 'Ort nicht gefunden. Versuchen Sie es erneut.',
      'allMarkers': 'Alle',
      'bloodFilter': 'Blut',
      'medicalFilter': 'Medizinisch',
      'rescueFilter': 'Rettung',
      'criticalPriority': 'Kritisch',
      'highPriority': 'Hoch',
      'mediumPriority': 'Mittel',
      'cairo': 'Kairo',
      'alexandria': 'Alexandria',
      'giza': 'Gizeh',
      'portSaid': 'Port Said',
      'suez': 'Suez',
      'luxor': 'Luxor',
      'mansoura': 'Mansoura',
      'tanta': 'Tanta',
      'asyut': 'Asyut',
      'ismailia': 'Ismailia',
      'fayoum': 'Fayoum',
      'zagazig': 'Zagazig',
      'aswan': 'Assuan',
      'damietta': 'Damietta',
      'minya': 'Minya',
      'beniSuef': 'Beni Suef',
      'qena': 'Qena',
      'sohag': 'Sohag',
      'hurghada': 'Hurghada',
      'aiEmergencyAssistant': 'KI-Notfallassistent',
      'aiAssistantDesc': 'Erhalten Sie sofortige Erste-Hilfe-Ratschläge',
      'recentRequests': 'Ihre letzten Anfragen',
      'viewAll': 'Alle anzeigen',
      'noRecentRequests': 'Keine letzten Anfragen',
      'bloodRequest': 'Blutanforderung',
      'medicalSuppliesRequest': 'Medizinischer Bedarf',
      'rescueRequest': 'Rettungsanfrage',
      'howItWorks': 'Wie es funktioniert',
      'submitRequestStep': 'Anfrage senden',
      'submitRequestDesc': 'Tippen Sie auf SOS und geben Sie Details ein',
      'aiMatchingStep': 'KI-Matching',
      'aiMatchingDesc': 'Das System findet verifizierte Spender in der Nähe',
      'getHelpStep': 'Hilfe erhalten',
      'getHelpDesc': 'Der Spender trifft mit der benötigten Hilfe ein',
      'emergencyRequest': 'Notfallanfrage',
      'selectEmergencyType': 'Notfallart auswählen',
      'provideDetails': 'Details angeben',
      'whatHelpNeeded': 'Welche Art von Hilfe benötigen Sie?',
      'bloodDonationDesc': 'Dringende Bluttransfusion erforderlich',
      'medicalSuppliesDesc': 'Medikamente oder medizinische Geräte',
      'emergencyRescue': 'Notfallrettung',
      'emergencyRescueDesc': 'Sofortige körperliche Hilfe',
      'urgencyLevel': 'Dringlichkeitsstufe',
      'criticalLabel': 'Kritisch',
      'highLabel': 'Hoch',
      'mediumLabel': 'Mittel',
      'bloodTypeNeeded': 'Benötigte Blutgruppe',
      'descriptionLabel': 'Beschreibung',
      'descriptionHint': 'Beschreiben Sie Ihre Notfallsituation...',
      'aiAnalyzing': 'KI analysiert Ihre Situation...',
      'smartAnalyzeAI': 'Intelligente KI-Analyse ✨',
      'aiFirstAidTipLabel': 'KI Erste-Hilfe-Tipp',
      'yourName': 'Ihr Name',
      'yourNameHint': 'Vollständiger Name',
      'phoneNumber': 'Telefonnummer',
      'submitEmergencyRequest': '🚨 Notfallanfrage senden',
      'requestSent': 'Anfrage gesendet!',
      'broadcastingMsg': 'Übertragung an Spender in der Nähe. Sie sollten innerhalb von 2-5 Minuten eine Antwort erhalten.',
      'backToHome': 'Zurück zur Startseite',
      'fillAllDetails': 'Bitte füllen Sie alle Details aus',
      'longerDescriptionAI': 'Bitte geben Sie eine längere Beschreibung für die KI-Analyse an',
      'aiAnalysisComplete': 'KI-Analyse abgeschlossen ✨',
      'aiAnalysisFailed': 'KI-Analyse fehlgeschlagen',
    }
  };

  bool get isArabic => locale.languageCode == 'ar';

  String _(String key) {
    return _localizedValues[locale.languageCode]?[key] ?? 
           _localizedValues['en']?[key] ?? 
           key;
  }

  // Base Auth & Common
  String get login => _('login');
  String get email => _('email');
  String get password => _('password');
  String get forgotPassword => _('forgotPassword');
  String get dontHaveAccount => _('dontHaveAccount');
  String get registerNow => _('registerNow');
  String get welcomeBack => _('welcomeBack');
  String get savingLives => _('savingLives');
  String get donor => _('donor');
  String get requester => _('requester');
  String get copyright => _('copyright');
  String get verifyEmail => _('verifyEmail');
  String get verifyMsg => _('verifyMsg');
  String get sessionExpired => _('sessionExpired');
  String get chooseAccount => _('chooseAccount');
  String get howUse => _('howUse');
  String get continueText => _('continue');
  String get createAccount => _('createAccount');
  String get registeringAs => _('registeringAs');
  
  // Registration & General UI
  String get chooseAccountType => _('chooseAccountType');
  String get howToUse => _('howToUse');
  String get donorDesc => _('donorDesc');
  String get requesterDesc => _('requesterDesc');
  String get continueBtn => _('continueBtn');
  String get register => _('register');
  String get alreadyHaveAccount => _('alreadyHaveAccount');
  String get logout => _('logout');
  String get liveAvailability => _('liveAvailability');
  String get appLanguage => _('appLanguage');
  String get available => _('available');
  String get notAvailable => _('notAvailable');
  String get memberSince => _('memberSince');
  String get enterEmail => _('enterEmail');
  String get enterPassword => _('enterPassword');
  String get bloodTypeLabel => _('bloodTypeLabel');
  String get Egypt => _('Egypt');
  String get user => _('user');
  String get enterName => _('enterName');
  String get ok => _('ok');
  String get registrationFailed => _('registrationFailed');
  String get unexpectedError => _('unexpectedError');
  String get developedBy => _('developedBy');
  String get accept => _('accept');
  String get details => _('details');
  String get urgentBloodTransfusion => _('urgentBloodTransfusion');
  String get emergencySuppliesNeeded => _('emergencySuppliesNeeded');
  String get hospitalCairoUniv => _('hospitalCairoUniv');
  String get hospitalDarElFouad => _('hospitalDarElFouad');
  String get km => _('km');
  
  // Shared UI Section Headers
  String get editProfile => _('editProfile');
  String get donationHistory => _('donationHistory');
  String get requestHistory => _('requestHistory');
  String get badgesAchievements => _('badgesAchievements');
  String get locationSettings => _('locationSettings');
  String get appSettings => _('appSettings');
  String get privacySecurity => _('privacySecurity');

  // Home & Stats
  String get rating => _('rating');
  String get yourImpact => _('yourImpact');
  String get livesSavedLabel => _('livesSavedLabel');
  String get startJourney => _('startJourney');
  String get topDonors => _('topDonors');
  String get moreDonationsMilestone => _('moreDonationsMilestone');
  String get thisWeek => _('thisWeek');
  String get donationsCompleted => _('donationsCompleted');
  String get nearbyEmergencies => _('nearbyEmergencies');
  String get active => _('active');
  String get critical => _('critical');
  String get highPriorityLabel => _('highPriorityLabel');
  String get urgentTransfusion => _('urgentTransfusion');

  // Notifications
  String get notifications => _('notifications');
  String get markAllRead => _('markAllRead');
  String get all => _('all');
  String get emergencyTab => _('emergencyTab');
  String get updatesTab => _('updatesTab');
  String get newEmergencyRequest => _('newEmergencyRequest');
  String get highPriorityRequest => _('highPriorityRequest');
  String get requestCompleted => _('requestCompleted');
  String get newBadgeEarned => _('newBadgeEarned');
  String get reminder => _('reminder');
  String get viewRequest => _('viewRequest');
  String get dismiss => _('dismiss');

  // Navigation
  String get navHome => _('navHome');
  String get navMap => _('navMap');
  String get navAlerts => _('navAlerts');
  String get navProfile => _('navProfile');

  // Privacy & Security Details
  String get changePassword => _('changePassword');
  String get updateCredentials => _('updateCredentials');
  String get twoFactorAuth => _('twoFactorAuth');
  String get extraLayerSecurity => _('extraLayerSecurity');
  String get profileVisibility => _('profileVisibility');
  String get chooseWhoSeesProfile => _('chooseWhoSeesProfile');
  String get dataPrivacy => _('dataPrivacy');
  String get downloadMyData => _('downloadMyData');
  String get getCopyAccountInfo => _('getCopyAccountInfo');
  String get deleteAccount => _('deleteAccount');
  String get permanentlyRemoveAccount => _('permanentlyRemoveAccount');

  // App Settings Details
  String get preferences => _('preferences');
  String get pushNotifications => _('pushNotifications');
  String get receiveAlertsEmergencies => _('receiveAlertsEmergencies');
  String get darkMode => _('darkMode');
  String get switchToDarkTheme => _('switchToDarkTheme');
  String get language => _('language');
  String get about => _('about');
  String get termsOfService => _('termsOfService');
  String get privacyPolicy => _('privacyPolicy');
  String get appVersion => _('appVersion');

  // Location Settings Details
  String get permissions => _('permissions');
  String get shareLiveLocation => _('shareLiveLocation');
  String get allowOthersSeeLocation => _('allowOthersSeeLocation');
  String get backgroundLocation => _('backgroundLocation');
  String get receiveAlertsAppClosed => _('receiveAlertsAppClosed');
  String get emergencySearchRadius => _('emergencySearchRadius');
  String get openSystemSettings => _('openSystemSettings');

  // Badges Details
  String get lifeSaver => _('lifeSaver');
  String get firstResponder => _('firstResponder');
  String get frequentDonor => _('frequentDonor');
  String get bloodHero => _('bloodHero');
  String get nightOwl => _('nightOwl');
  String get communityPillar => _('communityPillar');
  String get unlocked => _('unlocked');
  String get locked => _('locked');

  // Donation History Details
  String get noDonationsYet => _('noDonationsYet');
  String get bloodDonation => _('bloodDonation');
  String get medicalDonation => _('medicalDonation');
  String get completedStatus => _('completedStatus');

  // Edit Profile Details
  String get personalInformation => _('personalInformation');
  String get fullName => _('fullName');
  String get nameHint => _('nameHint');
  String get phone => _('phone');
  String get phoneHint => _('phoneHint');
  String get changePasswordHeader => _('changePasswordHeader');
  String get leaveEmptyPassword => _('leaveEmptyPassword');
  String get newPassword => _('newPassword');
  String get passwordHint => _('passwordHint');
  String get donorInformation => _('donorInformation');
  String get bloodType => _('bloodType');
  String get city => _('city');
  String get saveChanges => _('saveChanges');

  // Edit Profile Hints & Validation
  String get nameExampleHint => _('nameExampleHint');
  String get selectBloodTypeHint => _('selectBloodTypeHint');
  String get selectCityHint => _('selectCityHint');
  String get enterNewPasswordHint => _('enterNewPasswordHint');
  String get failedLoadProfile => _('failedLoadProfile');
  String get profileUpdatedSuccess => _('profileUpdatedSuccess');
  String get failedUpdateProfile => _('failedUpdateProfile');
  String get recentLoginRequired => _('recentLoginRequired');
  String get weakPassword => _('weakPassword');
  String get enterFullName => _('enterFullName');
  String get enterTwoNames => _('enterTwoNames');
  String get enterPhone => _('enterPhone');
  String get phoneLengthError => _('phoneLengthError');
  String get passwordLengthError => _('passwordLengthError');
  String get passwordLetterError => _('passwordLetterError');
  String get passwordNumberError => _('passwordNumberError');
  String get passwordSymbolError => _('passwordSymbolError');
  String get selectBloodType => _('selectBloodType');
  String get selectCity => _('selectCity');

  // Map
  String get searchHint => _('searchHint');
  String get locationNotFound => _('locationNotFound');
  String get allMarkers => _('allMarkers');
  String get bloodFilter => _('bloodFilter');
  String get medicalFilter => _('medicalFilter');
  String get rescueFilter => _('rescueFilter');
  String get criticalPriority => _('criticalPriority');
  String get highPriority => _('highPriority');
  String get mediumPriority => _('mediumPriority');

  // Cities
  String get cairo => _('cairo');
  String get alexandria => _('alexandria');
  String get giza => _('giza');
  String get portSaid => _('portSaid');
  String get suez => _('suez');
  String get luxor => _('luxor');
  String get mansoura => _('mansoura');
  String get tanta => _('tanta');
  String get asyut => _('asyut');
  String get ismailia => _('ismailia');
  String get fayoum => _('fayoum');
  String get zagazig => _('zagazig');
  String get aswan => _('aswan');
  String get damietta => _('damietta');
  String get minya => _('minya');
  String get beniSuef => _('beniSuef');
  String get qena => _('qena');
  String get sohag => _('sohag');
  String get hurghada => _('hurghada');

  // Requester Home & AI
  String get aiEmergencyAssistant => _('aiEmergencyAssistant');
  String get aiAssistantDesc => _('aiAssistantDesc');
  String get recentRequests => _('recentRequests');
  String get viewAll => _('viewAll');
  String get noRecentRequests => _('noRecentRequests');
  String get bloodRequest => _('bloodRequest');
  String get medicalSuppliesRequest => _('medicalSuppliesRequest');
  String get rescueRequest => _('rescueRequest');
  String get howItWorks => _('howItWorks');
  String get submitRequestStep => _('submitRequestStep');
  String get submitRequestDesc => _('submitRequestDesc');
  String get aiMatchingStep => _('aiMatchingStep');
  String get aiMatchingDesc => _('aiMatchingDesc');
  String get getHelpStep => _('getHelpStep');
  String get getHelpDesc => _('getHelpDesc');

  // Emergency Form
  String get emergencyRequest => _('emergencyRequest');
  String get selectEmergencyType => _('selectEmergencyType');
  String get provideDetails => _('provideDetails');
  String get whatHelpNeeded => _('whatHelpNeeded');
  String get bloodDonationDesc => _('bloodDonationDesc');
  String get medicalSuppliesDesc => _('medicalSuppliesDesc');
  String get emergencyRescue => _('emergencyRescue');
  String get emergencyRescueDesc => _('emergencyRescueDesc');
  String get urgencyLevel => _('urgencyLevel');
  String get criticalLabel => _('criticalLabel');
  String get highLabel => _('highLabel');
  String get mediumLabel => _('mediumLabel');
  String get bloodTypeNeeded => _('bloodTypeNeeded');
  String get descriptionLabel => _('descriptionLabel');
  String get descriptionHint => _('descriptionHint');
  String get aiAnalyzing => _('aiAnalyzing');
  String get smartAnalyzeAI => _('smartAnalyzeAI');
  String get aiFirstAidTipLabel => _('aiFirstAidTipLabel');
  String get yourName => _('yourName');
  String get yourNameHint => _('yourNameHint');
  String get phoneNumber => _('phoneNumber');
  String get submitEmergencyRequest => _('submitEmergencyRequest');
  String get requestSent => _('requestSent');
  String get broadcastingMsg => _('broadcastingMsg');
  String get backToHome => _('backToHome');
  String get fillAllDetails => _('fillAllDetails');
  String get longerDescriptionAI => _('longerDescriptionAI');
  String get aiAnalysisComplete => _('aiAnalysisComplete');
  String get aiAnalysisFailed => _('aiAnalysisFailed');
  String get aH => _('aH');
  String get lettersonly => _('lettersonly');
  String get enteravalidemail => _('enteravalidemail');
  String get invalidEgyptianphonenumbe => _('invalidEgyptianphonenumbe');
  String get enterapassword => _('enterapassword');
  String get requestacceptedPleasehead => _('requestacceptedPleasehead');
  String get failedtoupdatestatus => _('failedtoupdatestatus');
  String get responseRate => _('responseRate');
  String get nonearbyemergenciesatthem => _('nonearbyemergenciesatthem');
  String get unknownLocation => _('unknownLocation');
  String get allmarkedasread => _('allmarkedasread');
  String get nonewalerts => _('nonewalerts');
  String get yourdonationhasbeenrecord => _('yourdonationhasbeenrecord');
  String get openingrequest => _('openingrequest');
  String get profilephotoupdatedsucces => _('profilephotoupdatedsucces');
  String get hEALTHINFORMATION => _('hEALTHINFORMATION');
  String get requestacceptedsuccessful => _('requestacceptedsuccessful');
  String get somethingwentwrong => _('somethingwentwrong');
  String get emergencyDetails => _('emergencyDetails');
  String get needsyourhelp => _('needsyourhelp');
  String get description => _('description');
  String get location => _('location');
  String get contactInformation => _('contactInformation');
  String get acceptRequestGo => _('acceptRequestGo');
  String get livelocationsharingenable => _('livelocationsharingenable');
  String get livelocationsharingdisabl => _('livelocationsharingdisabl');
  String get backgroundlocationenabled => _('backgroundlocationenabled');
  String get backgroundlocationdisable => _('backgroundlocationdisable');
  String get updateyourpersonalinforma => _('updateyourpersonalinforma');
  String get passwordresetemailsent => _('passwordresetemailsent');
  String get helloIamyourEAssistAIEmer => _('helloIamyourEAssistAIEmer');
  String get aIEmergencyAssistant => _('aIEmergencyAssistant');
  String get noteThisassistantisforgen => _('noteThisassistantisforgen');
  String get aIAssistantisthinking => _('aIAssistantisthinking');
  String get askEAssistAI => _('askEAssistAI');
  String get norequestsyet => _('norequestsyet');
  String get accepted => _('accepted');
  String get activeSOS => _('activeSOS');
  String get helpReceived => _('helpReceived');
  String get needImmediateHelp => _('needImmediateHelp');
  String get tapbelowtobroadcastemerge => _('tapbelowtobroadcastemerge');
  String get requestEmergencyAid => _('requestEmergencyAid');
  String get justnow => _('justnow');
}

class AppLocalizationsDelegate extends LocalizationsDelegate<AppLocalizations> {
  const AppLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) => ['en', 'ar', 'fr', 'de'].contains(locale.languageCode);

  @override
  Future<AppLocalizations> load(Locale locale) async => AppLocalizations(locale);

  @override
  bool shouldReload(AppLocalizationsDelegate old) => false;
}

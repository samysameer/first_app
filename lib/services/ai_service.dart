import 'package:google_generative_ai/google_generative_ai.dart';
import 'dart:convert';

class AIService {
  // Replace with your actual API Key from Google AI Studio
  static const String _apiKey = 'YOUR_GEMINI_API_KEY';
  
  static final GenerativeModel _model = GenerativeModel(
    model: 'gemini-2.5-flash',
    apiKey: _apiKey,
  );

  /// Chats with the emergency AI assistant using conversation history.
  static Future<String> chatWithAI(List<Map<String, String>> history, String message) async {
    if (_apiKey == 'YOUR_GEMINI_API_KEY' || _apiKey.isEmpty) {
      return _generateSmartLocalResponse(message);
    }

    try {
      final StringBuffer prompt = StringBuffer();
      
      // System instructions
      prompt.writeln("System Instruction: You are E-Assist AI, an expert emergency response assistant. "
        "Your mission is to provide accurate first aid advice, explain emergency procedures clearly, "
        "and help users handle crisis situations calmly and safely. Keep responses concise, supportive, and safety-focused. "
        "If the user describes a critical medical emergency, always advise them to call official emergency numbers (like 123 in Egypt). "
        "IMPORTANT: You MUST respond entirely in the exact same language that the user used in their most recent message (e.g., Arabic, English, French, German, etc.).\n");

      // Append history
      for (var msg in history) {
        final isUser = msg['role'] == 'user';
        if (isUser) {
          prompt.writeln("User: ${msg['content']}");
        } else {
          prompt.writeln("E-Assist AI: ${msg['content']}");
        }
      }

      // Add the new message
      prompt.writeln("User: $message");
      prompt.writeln("E-Assist AI:");

      final response = await _model.generateContent([Content.text(prompt.toString())]);
      return response.text ?? "I'm sorry, I couldn't generate a response.";
    } catch (e) {
      print('AI Chat Error: $e');
      if (_apiKey != 'YOUR_GEMINI_API_KEY' && _apiKey.isNotEmpty) {
        return "Error from Gemini: $e";
      }
      return _generateSmartLocalResponse(message);
    }
  }

  static String _generateSmartLocalResponse(String message) {
    final lower = message.toLowerCase();
    if (lower.contains('bleed') || lower.contains('blood') || lower.contains('نزيف') || lower.contains('دم')) {
      return "🩸 **First Aid for Bleeding:**\n\n"
          "1. Apply direct pressure to the wound with a clean cloth or bandage.\n"
          "2. Keep pressure applied until the bleeding stops.\n"
          "3. Elevate the injured limb above heart level if possible.\n"
          "4. Do not remove the bandage if it gets soaked; add more clean cloth on top.\n"
          "5. Seek emergency medical attention if bleeding is severe or doesn't stop.";
    } else if (lower.contains('burn') || lower.contains('fire') || lower.contains('حرق') || lower.contains('نار')) {
      return "🔥 **First Aid for Burns:**\n\n"
          "1. Cool the burn under cool running water for 10 to 20 minutes. Do not use ice.\n"
          "2. Remove rings or tight items from the burned area before it swells.\n"
          "3. Cover the burn loosely with a sterile, non-stick bandage or clean wrap.\n"
          "4. Do not pop blisters or apply butter, grease, or ointments.\n"
          "5. Seek professional medical help for severe or large burns.";
    } else if (lower.contains('cpr') || lower.contains('heart') || lower.contains('انعاش') || lower.contains('قلب')) {
      return "🫀 **How to Perform Hands-Only CPR:**\n\n"
          "1. Call your emergency medical number immediately.\n"
          "2. Place the heel of one hand in the center of the person's chest.\n"
          "3. Place your other hand on top and interlock your fingers.\n"
          "4. Push hard and fast in the center of the chest: 100 to 120 compressions per minute (to the beat of 'Staying Alive').\n"
          "5. Continue compressions until medical help arrives or the person starts breathing.";
    } else if (lower.contains('choke') || lower.contains('اختناق')) {
      return "💨 **First Aid for Choking (Heimlich Maneuver):**\n\n"
          "1. Stand behind the person and wrap your arms around their waist.\n"
          "2. Make a fist with one hand and place it just above their navel.\n"
          "3. Grasp your fist with the other hand.\n"
          "4. Perform quick, upward and inward thrusts into the abdomen.\n"
          "5. Repeat until the object is expelled or the person loses consciousness (in which case, start CPR).";
    } else if (lower.contains('fracture') || lower.contains('broken') || lower.contains('كسر')) {
      return "🦴 **First Aid for Fractures/Broken Bones:**\n\n"
          "1. Stop any bleeding by applying pressure with a sterile dressing.\n"
          "2. Immobilize the injured area. Do not try to realign the bone.\n"
          "3. Apply ice packs wrapped in a cloth to reduce swelling.\n"
          "4. Treat the person for shock (keep them lying down and warm).\n"
          "5. Call emergency services immediately.";
    } else {
      return "✨ **Hello! I am your E-Assist AI Emergency Assistant.**\n\n"
          "I can help you handle emergency situations safely. Ask me about first aid procedures like:\n"
          "- 🩸 How to stop **bleeding**\n"
          "- 🔥 How to treat **burns**\n"
          "- 🫀 How to perform **CPR**\n"
          "- 💨 What to do for **choking**\n"
          "- 🦴 First aid for **fractures**\n\n"
          "_Please remember: in any life-threatening situation, always contact your local emergency services immediately._";
    }
  }

  /// Analyzes an emergency description and returns a JSON with urgency and recommended type.
  static Future<Map<String, dynamic>> analyzeEmergency(String description) async {
    if (_apiKey == 'YOUR_GEMINI_API_KEY') {
      return _smartLocalAnalyze(description);
    }

    final prompt = '''
    Analyze the following emergency description and categorize it.
    
    Description: "$description"
    
    Respond ONLY with a JSON object in this format:
    {
      "urgency": "critical" | "high" | "medium",
      "type": "blood" | "medical" | "rescue",
      "summary": "Short 1-sentence summary of the situation",
      "first_aid_tip": "Immediate first aid advice for this situation"
    }
    ''';

    try {
      final content = [Content.text(prompt)];
      final response = await _model.generateContent(content);
      
      final text = response.text;
      if (text == null) throw Exception('Empty response from AI');
      
      // Extract JSON if model wraps it in markdown
      final jsonString = text.contains('```json') 
          ? text.split('```json')[1].split('```')[0].trim()
          : text.trim();
          
      return json.decode(jsonString);
    } catch (e) {
      print('AI Error: $e');
      return _smartLocalAnalyze(description);
    }
  }

  static Map<String, dynamic> _smartLocalAnalyze(String description) {
    final lower = description.toLowerCase();
    
    if (lower.contains('bleed') || lower.contains('blood') || lower.contains('نزيف') || lower.contains('دم')) {
      return {
        'urgency': 'critical',
        'type': 'blood',
        'summary': 'Severe bleeding emergency requiring immediate pressure and attention.',
        'first_aid_tip': '1. Apply direct pressure to the wound with a clean cloth.\n2. Elevate the injured limb if possible.\n3. Keep pressure applied until help arrives.'
      };
    } else if (lower.contains('burn') || lower.contains('fire') || lower.contains('حرق') || lower.contains('نار')) {
      return {
        'urgency': 'high',
        'type': 'medical',
        'summary': 'Burn injury needing cooling and infection prevention.',
        'first_aid_tip': '1. Cool the burn under cool running water for 10-20 minutes.\n2. Cover loosely with sterile dressing.\n3. Do not apply ice or pop blisters.'
      };
    } else if (lower.contains('cpr') || lower.contains('heart') || lower.contains('chest') || lower.contains('انعاش') || lower.contains('قلب')) {
      return {
        'urgency': 'critical',
        'type': 'medical',
        'summary': 'Potential cardiac arrest or severe chest pain.',
        'first_aid_tip': '1. Call ambulance immediately.\n2. Keep the person calm.\n3. Prepare to perform hands-only CPR if they lose consciousness.'
      };
    } else if (lower.contains('choke') || lower.contains('breath') || lower.contains('اختناق') || lower.contains('تنفس')) {
      return {
        'urgency': 'critical',
        'type': 'rescue',
        'summary': 'Airway obstruction or choking emergency.',
        'first_aid_tip': '1. Stand behind the person and perform upward abdominal thrusts (Heimlich Maneuver).\n2. If they lose consciousness, perform CPR.'
      };
    } else if (lower.contains('accident') || lower.contains('crash') || lower.contains('fracture') || lower.contains('broken') || lower.contains('حادث') || lower.contains('كسر')) {
      return {
        'urgency': 'high',
        'type': 'rescue',
        'summary': 'Physical trauma or possible broken bones from an accident.',
        'first_aid_tip': '1. Keep the person completely still.\n2. Do not attempt to move or realign suspected fractures.\n3. Apply a cold pack wrapped in cloth to reduce swelling.'
      };
    } else {
      return {
        'urgency': 'medium',
        'type': 'medical',
        'summary': 'General medical emergency request.',
        'first_aid_tip': '1. Keep the patient comfortable and calm.\n2. Monitor their breathing and level of consciousness.\n3. Prepare to guide emergency responders.'
      };
    }
  }
}

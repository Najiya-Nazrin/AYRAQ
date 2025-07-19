// import 'package:flutter/material.dart';
// import 'package:ayraq_app/models/threat_model.dart';
// import 'package:ayraq_app/utils/nlp_model_inference.dart';
// import 'package:ayraq_app/components/threat_detection/threat_detector.dart';
// import 'package:ayraq_app/components/threat_detection/threat_floating_button.dart';
// import 'package:ayraq_app/components/threat_detection/legal_suggestion_service.dart';
// import 'package:ayraq_app/components/threat_detection/emotion_assistant_chatbot.dart';
// import 'package:ayraq_app/components/threat_detection/trusted_contact_service.dart';

// class TestThreatDetectionScreen extends StatefulWidget {
//   const TestThreatDetectionScreen({super.key});

//   @override
//   State<TestThreatDetectionScreen> createState() => _TestThreatDetectionScreenState();
// }

// class _TestThreatDetectionScreenState extends State<TestThreatDetectionScreen> {
//   final TextEditingController messageController = TextEditingController();
//   Threat? detectedThreat;
//   String? legalAdvice;
//   String chatbotReply = "";

//   Future<void> analyzeThreat() async {
//     String message = messageController.text.trim();
//     ThreatDetector detector = ThreatDetector();
//     Threat? result = await detector.scanMessage(message);

//     if (result != null) {
//       setState(() {
//         detectedThreat = result;
//         legalAdvice = LegalSuggestionService().getSuggestion(result.category);
//       });
//     } else {
//       setState(() {
//         detectedThreat = null;
//         legalAdvice = null;
//       });
//     }

//     // Chatbot part
//     setState(() {
//       chatbotReply = EmotionAssistantChatbot(userInput: message).getReply();
//     });
//   }

//   void takeScreenshot() {
//     ScaffoldMessenger.of(context).showSnackBar(
//       const SnackBar(content: Text("Screenshot button pressed (simulate)")),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: const Text("Threat Detection Test")),
//       floatingActionButton: ThreatFloatingButton(onPress: takeScreenshot),
//       body: Padding(
//         padding: const EdgeInsets.all(16),
//         child: Column(
//           children: [
//             TextField(
//               controller: messageController,
//               decoration: const InputDecoration(labelText: "Enter message to analyze"),
//             ),
//             const SizedBox(height: 16),
//             ElevatedButton(
//               onPressed: analyzeThreat,
//               child: const Text("Analyze"),
//             ),
//             const SizedBox(height: 24),
//             if (detectedThreat != null)
//               Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text("⚠️ Threat Detected: ${detectedThreat!.category}",
//                       style: const TextStyle(color: Colors.red, fontSize: 18)),
//                   const SizedBox(height: 8),
//                   Text("🧾 Legal Suggestion: $legalAdvice"),
//                 ],
//               )
//             else
//               const Text("✅ No threat detected.", style: TextStyle(color: Colors.green)),
//             const SizedBox(height: 24),
//             if (chatbotReply.isNotEmpty)
//               Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   const Text("🧠 Emotional GPT Response:", style: TextStyle(fontWeight: FontWeight.bold)),
//                   Text(chatbotReply),
//                 ],
//               ),
//           ],
//         ),
//       ),
//     );
//   }
// }

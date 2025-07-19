// import 'package:flutter/material.dart';
// import 'package:android_intent_plus/android_intent.dart';
// import 'package:android_intent_plus/flag.dart';
// import 'package:permission_handler/permission_handler.dart';

// class SettingsPage extends StatelessWidget {
//   const SettingsPage({super.key});

//   // Opens Accessibility Settings
//   Future<void> openAccessibilitySettings() async {
//     final intent = AndroidIntent(
//       action: 'android.settings.ACCESSIBILITY_SETTINGS',
//       flags: <int>[Flag.FLAG_ACTIVITY_NEW_TASK],
//     );
//     await intent.launch();
//   }

//   // Requests SYSTEM_ALERT_WINDOW Permission
//   Future<void> requestOverlayPermission() async {
//     final status = await Permission.systemAlertWindow.status;
//     if (!status.isGranted) {
//       await openAppSettings(); // Redirects to system settings
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('AYRAQ Settings'),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(20),
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             ElevatedButton(
//               onPressed: openAccessibilitySettings,
//               child: const Text('Enable Accessibility Service'),
//             ),
//             const SizedBox(height: 20),
//             ElevatedButton(
//               onPressed: requestOverlayPermission,
//               child: const Text('Grant Overlay Permission'),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

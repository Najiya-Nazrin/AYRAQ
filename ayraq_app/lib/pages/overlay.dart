import 'package:flutter/material.dart';
import 'package:screenshot/screenshot.dart';
import 'dart:io';
import 'dart:typed_data';
import 'package:path_provider/path_provider.dart';

// Top-level function for overlay entry point
@pragma("vm:entry-point")
void showOverlay() {
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      home: OverlayWidget(),
    ),
  );
}

class OverlayWidget extends StatefulWidget {
  const OverlayWidget({super.key});

  @override
  State<OverlayWidget> createState() => _OverlayWidgetState();
}

class _OverlayWidgetState extends State<OverlayWidget> {
  final ScreenshotController screenshotController = ScreenshotController();

  Future<void> _showPopupMenu(BuildContext context, Offset offset) async {
    final result = await showMenu(
      context: context,
      position: RelativeRect.fromLTRB(offset.dx, offset.dy, 0, 0),
      items: const [
        PopupMenuItem(value: 'screenshot', child: Text('Take Screenshot')),
        PopupMenuItem(value: 'other', child: Text('Do Something')),
      ],
    );

    if (result == 'screenshot') {
      _takeScreenshot();
    } else if (result == 'other') {
      print("Other action selected.");
    }
  }

  Future<void> _takeScreenshot() async {
    final Uint8List? imageBytes = await screenshotController.capture();
    if (imageBytes != null) {
      final directory = await getApplicationDocumentsDirectory();
      final filePath =
          '${directory.path}/screenshot_${DateTime.now().millisecondsSinceEpoch}.png';
      final file = File(filePath);
      await file.writeAsBytes(imageBytes);
      print('Screenshot saved to $filePath');
    } else {
      print('Failed to capture screenshot.');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Screenshot(
      controller: screenshotController,
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Align(
          alignment: Alignment.bottomRight,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Builder(
              builder: (context) => FloatingActionButton(
                onPressed: () async {
                  final RenderBox button =
                      context.findRenderObject() as RenderBox;
                  final offset = button.localToGlobal(Offset.zero);
                  _showPopupMenu(context, offset);
                },
                child: const Icon(Icons.more_vert),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
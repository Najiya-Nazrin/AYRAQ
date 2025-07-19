package com.example.ayraq_app

import android.accessibilityservice.AccessibilityService
import android.view.accessibility.AccessibilityEvent
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.embedding.engine.FlutterEngineCache
import io.flutter.plugin.common.MethodChannel

class ThreatDetectionService : AccessibilityService() {
    private lateinit var channel: MethodChannel

    override fun onServiceConnected() {
        val engine = FlutterEngine(this)
        engine.dartExecutor.executeDartEntrypoint(
            io.flutter.embedding.engine.dart.DartExecutor.DartEntrypoint.createDefault()
        )
        FlutterEngineCache.getInstance().put("threat_engine", engine)

        channel = MethodChannel(engine.dartExecutor.binaryMessenger, "threat_channel")
    }

    override fun onAccessibilityEvent(event: AccessibilityEvent) {
        val content = event.text?.joinToString(" ") ?: return
        channel.invokeMethod("checkThreat", content)
    }

    override fun onInterrupt() {}
}

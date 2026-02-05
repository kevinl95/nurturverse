package com.nurturverse.app

import android.content.Intent
import androidx.core.content.ContextCompat
import com.nurturverse.app.boinc.BoincEventBus
import com.nurturverse.app.boinc.BoincForegroundService
import com.nurturverse.app.boinc.BoincRuntime
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.EventChannel
import io.flutter.plugin.common.MethodChannel

class MainActivity : FlutterActivity() {
    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)

        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, "nurturverse/boinc").setMethodCallHandler { call, result ->
            when (call.method) {
                "start" -> {
                    startBoincService()
                    result.success(true)
                }
                "stop" -> {
                    stopBoincService()
                    result.success(true)
                }
                "isRunning" -> {
                    result.success(BoincRuntime.isRunning)
                }
                else -> result.notImplemented()
            }
        }

        EventChannel(flutterEngine.dartExecutor.binaryMessenger, "nurturverse/boinc_events").setStreamHandler(object : EventChannel.StreamHandler {
            override fun onListen(arguments: Any?, events: EventChannel.EventSink?) {
                BoincEventBus.attach(events)
            }

            override fun onCancel(arguments: Any?) {
                BoincEventBus.detach()
            }
        })
    }

    private fun startBoincService() {
        val intent = Intent(this, BoincForegroundService::class.java)
        ContextCompat.startForegroundService(this, intent)
    }

    private fun stopBoincService() {
        val intent = Intent(this, BoincForegroundService::class.java)
        stopService(intent)
    }
}

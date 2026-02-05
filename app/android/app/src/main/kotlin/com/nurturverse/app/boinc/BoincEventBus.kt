package com.nurturverse.app.boinc

import io.flutter.plugin.common.EventChannel

object BoincEventBus {
    private var eventSink: EventChannel.EventSink? = null

    fun attach(sink: EventChannel.EventSink?) {
        eventSink = sink
    }

    fun detach() {
        eventSink = null
    }

    fun emitMinutes(minutes: Int) {
        eventSink?.success(minutes)
    }
}

package com.nurturverse.app.boinc

import android.os.Handler
import android.os.Looper

object BoincRuntime {
    @Volatile
    var isRunning: Boolean = false
        private set

    private val handler = Handler(Looper.getMainLooper())
    private var tickRunnable: Runnable? = null

    fun start() {
        if (isRunning) return
        isRunning = true
        startTicks()
    }

    fun stop() {
        isRunning = false
        tickRunnable?.let { handler.removeCallbacks(it) }
        tickRunnable = null
    }

    private fun startTicks() {
        tickRunnable = object : Runnable {
            override fun run() {
                if (!isRunning) return
                // TODO: Replace with real BOINC runtime minutes reported from the client.
                BoincEventBus.emitMinutes(1)
                handler.postDelayed(this, 60_000)
            }
        }
        handler.postDelayed(tickRunnable!!, 60_000)
    }
}

package com.example.focus

import android.content.BroadcastReceiver
import android.content.Context
import android.content.Intent
import android.media.AudioManager
import android.telephony.TelephonyManager
import android.util.Log

class CallReceiver : BroadcastReceiver() {
    companion object {
        private var lastState = TelephonyManager.CALL_STATE_IDLE
    }

    override fun onReceive(context: Context?, intent: Intent?) {
        if (intent?.action != TelephonyManager.ACTION_PHONE_STATE_CHANGED) return
        val stateStr = intent.getStringExtra(TelephonyManager.EXTRA_STATE)
        val number = intent.getStringExtra(TelephonyManager.EXTRA_INCOMING_NUMBER)
        val state = when (stateStr) {
            TelephonyManager.EXTRA_STATE_RINGING -> "RINGING"
            TelephonyManager.EXTRA_STATE_OFFHOOK -> "OFFHOOK"
            TelephonyManager.EXTRA_STATE_IDLE -> "IDLE"
            else -> "UNKNOWN"
        }

        val audioMgr = context?.getSystemService(Context.AUDIO_SERVICE) as AudioManager
        val ringerMode = audioMgr.ringerMode

        Log.d("FocusCallReceiver", "Broadcasting call: $state – $number")
        val bIntent = Intent("com.focus.CALL_EVENT").apply {
            putExtra("state", state)
            putExtra("number", number)
            putExtra("ringerMode", ringerMode)
        }
        context?.sendBroadcast(bIntent)
        lastState = state.hashCode()
    }
}

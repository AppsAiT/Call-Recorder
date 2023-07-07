package com.appsait.call_recorder

import android.annotation.TargetApi
import android.content.Context
import android.content.ContextWrapper
import android.content.Intent
import android.content.IntentFilter
import android.media.MediaRecorder
import android.os.BatteryManager
import android.os.Build
import android.os.Bundle
import android.telephony.PhoneStateListener
import android.telephony.TelephonyManager
import android.widget.Toast
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel


class MainActivity: FlutterActivity(){

    private val CHANNEL = "com.appsait.call_recorder/call_recorder"
    var recorder = MediaRecorder()






    override fun configureFlutterEngine( flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        MethodChannel(flutterEngine.getDartExecutor(), CHANNEL).setMethodCallHandler {
            // This method is invoked on the main thread.
                call, result ->
            if (call.method == "getBatteryLevel") {
                val batteryLevel = getBatteryLevel()

                if (batteryLevel != -1) {
                    result.success(batteryLevel)
                } else {
                    result.error("UNAVAILABLE", "Battery level not available.", null)
                }
            } else {
                result.notImplemented()
            }
        }
    }


    @TargetApi(Build.VERSION_CODES.LOLLIPOP)
    private fun getBatteryLevel(): Int {
//        // Get a reference to the BatteryManager instance
//        val batteryManager = context.getSystemService(BATTERY_SERVICE) as BatteryManager
//// Get the battery level
//        val batteryLevel = batteryManager.getIntProperty(BATTERY_PROPERTY_CAPACITY)
//        return batteryLevel

        recorder.setAudioSource(MediaRecorder.AudioSource.VOICE_COMMUNICATION);
        recorder.setOutputFormat(MediaRecorder.OutputFormat.THREE_GPP);
        recorder.setAudioEncoder(MediaRecorder.AudioEncoder.AMR_NB);
        recorder.setOutputFile("/storage/emulated/0/Download/myFile.3gp");
        recorder.prepare();
        val telephonyManager = getSystemService(Context.TELEPHONY_SERVICE) as TelephonyManager

        val callStateListener: PhoneStateListener = object : PhoneStateListener() {
            override fun onCallStateChanged(state: Int, incomingNumber: String) {
                if (state == TelephonyManager.CALL_STATE_RINGING) {
                    Toast.makeText(
                        getApplicationContext(), "Phone Is Ringing",
                        Toast.LENGTH_LONG
                    ).show()
                }
                if (state == TelephonyManager.CALL_STATE_OFFHOOK) {
                    recorder.start()
                    Toast.makeText(
                        getApplicationContext(), "Phone is Currently in A call",
                        Toast.LENGTH_LONG
                    ).show()
                }
                if (state == TelephonyManager.CALL_STATE_IDLE) {
                    recorder.stop()
                    Toast.makeText(
                        getApplicationContext(), "phone is neither ringing nor in a call",
                        Toast.LENGTH_LONG
                    ).show()
                }
            }
        }
        telephonyManager.listen(callStateListener, PhoneStateListener.LISTEN_CALL_STATE)


        val batteryLevel: Int
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.LOLLIPOP) {
            val batteryManager = getSystemService(Context.BATTERY_SERVICE) as BatteryManager
            batteryLevel = batteryManager.getIntProperty(BatteryManager.BATTERY_PROPERTY_CAPACITY)
        } else {
            val intent = ContextWrapper(applicationContext).registerReceiver(null, IntentFilter(
                Intent.ACTION_BATTERY_CHANGED)
            )
            batteryLevel = intent!!.getIntExtra(BatteryManager.EXTRA_LEVEL, -1) * 100 / intent.getIntExtra(
                BatteryManager.EXTRA_SCALE, -1)
        }

        return batteryLevel


    }
}

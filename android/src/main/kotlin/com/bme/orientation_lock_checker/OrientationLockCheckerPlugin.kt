package com.bme.orientation_state

import android.content.Context
import android.content.pm.ActivityInfo
import android.provider.Settings
import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result

/** OrientationStateCheckerPlugin */
class OrientationStateCheckerPlugin : FlutterPlugin, MethodCallHandler {
    /// The MethodChannel that will handle communication between Flutter and native Android
    private lateinit var channel: MethodChannel
    private lateinit var context: Context

    private fun getScreenOrientationStateStatus(): Boolean {
        try {
            val OrientationState = Settings.System.getInt(
                context.contentResolver,
                Settings.System.ACCELEROMETER_ROTATION
            )
            // Eğer değer 0 ise ekran döndürme kilidi açık, 1 ise kapalı
            return OrientationState == 0
        } catch (e: Settings.SettingNotFoundException) {
            e.printStackTrace()
        }
        return false
    }

    private fun setOrientationStateStatus(enabled: Boolean) {
        try {
            // Ekran döndürme kilidini ayarla
            Settings.System.putInt(
                context.contentResolver,
                Settings.System.ACCELEROMETER_ROTATION,
                if (enabled) 0 else 1
            )
        } catch (e: Exception) {
            e.printStackTrace()
        }
    }

    override fun onAttachedToEngine(flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
        channel = MethodChannel(flutterPluginBinding.binaryMessenger, "orientation_state")
        channel.setMethodCallHandler(this)
        context = flutterPluginBinding.applicationContext
    }

    override fun onMethodCall(call: MethodCall, result: Result) {
        when (call.method) {
            "isDeviceOrientationStateed" -> {
                // Ekran döndürme kilidinin durumunu kontrol et
                result.success(getScreenOrientationStateStatus())
            }
            "setOrientationState" -> {
                // Ekran döndürme kilidini ayarla
                val enabled = call.argument<Boolean>("enabled") ?: false
                setOrientationStateStatus(enabled)
                result.success(null)
            }
            else -> result.notImplemented()
        }
    }

    override fun onDetachedFromEngine(binding: FlutterPlugin.FlutterPluginBinding) {
        channel.setMethodCallHandler(null)
    }
}

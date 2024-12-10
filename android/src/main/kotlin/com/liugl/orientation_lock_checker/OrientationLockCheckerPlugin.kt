package com.liugl.orientation_lock_checker

import android.content.Context
import android.content.pm.ActivityInfo
import android.provider.Settings
import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result

/** OrientationLockCheckerPlugin */
class OrientationLockCheckerPlugin : FlutterPlugin, MethodCallHandler {
    /// The MethodChannel that will handle communication between Flutter and native Android
    private lateinit var channel: MethodChannel
    private lateinit var context: Context

    private fun getScreenOrientationLockStatus(): Boolean {
        try {
            val orientationLock = Settings.System.getInt(
                context.contentResolver,
                Settings.System.ACCELEROMETER_ROTATION
            )
            // Eğer değer 0 ise ekran döndürme kilidi açık, 1 ise kapalı
            return orientationLock == 0
        } catch (e: Settings.SettingNotFoundException) {
            e.printStackTrace()
        }
        return false
    }

    private fun setOrientationLockStatus(enabled: Boolean) {
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
        channel = MethodChannel(flutterPluginBinding.binaryMessenger, "orientation_lock_checker")
        channel.setMethodCallHandler(this)
        context = flutterPluginBinding.applicationContext
    }

    override fun onMethodCall(call: MethodCall, result: Result) {
        when (call.method) {
            "isDeviceOrientationLocked" -> {
                // Ekran döndürme kilidinin durumunu kontrol et
                result.success(getScreenOrientationLockStatus())
            }
            "setOrientationLock" -> {
                // Ekran döndürme kilidini ayarla
                val enabled = call.argument<Boolean>("enabled") ?: false
                setOrientationLockStatus(enabled)
                result.success(null)
            }
            else -> result.notImplemented()
        }
    }

    override fun onDetachedFromEngine(binding: FlutterPlugin.FlutterPluginBinding) {
        channel.setMethodCallHandler(null)
    }
}

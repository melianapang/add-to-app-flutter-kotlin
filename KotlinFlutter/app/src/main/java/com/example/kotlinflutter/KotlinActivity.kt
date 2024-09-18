package com.example.kotlinflutter

import android.Manifest
import android.content.Intent
import android.content.pm.PackageManager
import android.os.Bundle
import androidx.appcompat.app.AppCompatActivity
import androidx.core.app.ActivityCompat
import androidx.core.content.ContextCompat
import com.example.kotlinflutter.databinding.ActivityMainBinding
import io.flutter.embedding.android.FlutterActivity
import io.flutter.plugin.common.MethodChannel

enum class KotlinMethodChannelLabels(val label: String) {
    LiveClassParam("liveClassParam"),
    SmallLiveClassParam("smallLiveClassParam"),

    authenticationKeys("authenticationKeys"),
    apiKey("apiKey"),
    uid("uid"),
    mcsToken("mcsToken"),
}

class KotlinActivity : AppCompatActivity() {

    companion object {
        const val REQUEST_CAMERA_MIC_CODE = 123
        const val REQUEST_CAMERA_MIC_SETTING_CODE = 1232
    }

    private lateinit var binding: ActivityMainBinding
    private lateinit var userSession: UserSession

    private val permissions = arrayOf(Manifest.permission.CAMERA, Manifest.permission.RECORD_AUDIO)

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        binding = ActivityMainBinding.inflate(layoutInflater)
        setContentView(binding.root)

        userSession = UserSession(this)

        // 'api-key': 'dcE6iUtu4b80ENV50Mje80B3Ze2jq8',
        // 'UID': '15C17EE504BBA7A561CFEDB873DC0216',
        userSession.uid = "15C17EE504BBA7A561CFEDB873DC0216"
        userSession.apiKey = "dcE6iUtu4b80ENV50Mje80B3Ze2jq8"


        val latestEngine = (application as? MyApplication)?.flutterEngine ?: return
        val liveClassChannel = MethodChannel(
            latestEngine.dartExecutor,
            FLUTTER_LIVE_CLASS_CHANNEL
        )
        val authChannel = MethodChannel(
            latestEngine.dartExecutor,
            FLUTTER_AUTH_CHANNEL
        )

        liveClassChannel.setMethodCallHandler { call, result ->
            when(call.method) {
//                KotlinMethodChannelLabels.ValidationPreference.label -> {
//                    val apiKey = call.argument<String>("apiKey")
//                    val uid = call.argument<String>("uid")
//                    val mcsToken = call.argument<String>("mcsToken")
//
//                    userSession.apiKey = apiKey
//                    userSession.uid = uid
//                    userSession.mcsToken = mcsToken
//                }
                KotlinMethodChannelLabels.LiveClassParam.label -> {}
                else -> result.notImplemented()
            }
        }
//        authChannel.setMethodCallHandler()

        sendSmallLiveClassParam(liveClassChannel)
//        sendLiveClassParam(liveClassChannel)
        sendTokenUidApiKey(authChannel)

        requestCameraMicPermission()

        binding.button.setOnClickListener {
            if (!it.isEnabled) return@setOnClickListener
            startActivity(
                FlutterActivity
                    .withCachedEngine(FLUTTER_ENGINE_ID)
                    .build(this)
            )
        }
    }

    private fun sendLiveClassParam(channel: MethodChannel) {
        val data = mapOf(
            "meetingId" to "71067000022710",
            "onlineLessonId" to "22710",
            "subjectId" to "2",
            "levelId" to "3",
            "className" to "P3 Substraction",
            "wsUrl" to "wss://livekit-01.dev.geniebook.dev"
        )
        channel.invokeMethod(KotlinMethodChannelLabels.LiveClassParam.label, data)
    }

    private fun sendSmallLiveClassParam(channel: MethodChannel) {
        val data = mapOf(
            "className" to "P4 Math Subtraction",
            "meetingId" to "32881000022648",
            "onlineLessonId" to "22648",
            "subjectId" to "2",
            "levelId" to "3",
            "className" to "P3 Substraction",
            "wsUrl" to "wss://livekit-01.dev.geniebook.dev"
        )
        channel.invokeMethod(KotlinMethodChannelLabels.SmallLiveClassParam.label, data)
    }

    private fun sendTokenUidApiKey(channel: MethodChannel) {
        val data = mapOf(
            "apiKey" to userSession.apiKey,
            "uid" to userSession.uid,
            "mcsToken" to userSession.mcsToken,
        )
        channel.invokeMethod(KotlinMethodChannelLabels.authenticationKeys.label, data)
    }


    //region request permissions
    override fun onActivityResult(requestCode: Int, resultCode: Int, data: Intent?) {
        super.onActivityResult(requestCode, resultCode, data)
        if (requestCode == REQUEST_CAMERA_MIC_SETTING_CODE) {
            if (isCameraPermissionGranted()) {
                binding.button.isEnabled =true
            } else {
                binding.button.isEnabled =false

                if (shouldShowRequestPermissionRationale(Manifest.permission.RECORD_AUDIO)
                    || shouldShowRequestPermissionRationale(Manifest.permission.CAMERA)
                ) {
                    showPhoneAudioCameraPermissionRationale()
                }
            }
        }
    }

    override fun onRequestPermissionsResult(requestCode: Int, permissions: Array<out String>, grantResults: IntArray) {
        super.onRequestPermissionsResult(requestCode, permissions, grantResults)
        if (requestCode == REQUEST_CAMERA_MIC_CODE) {
            if (grantResults.isNotEmpty() && grantResults.all { it == PackageManager.PERMISSION_GRANTED }) {
                binding.button.isEnabled =true
            } else {
                binding.button.isEnabled =false

                if (shouldShowRequestPermissionRationale(Manifest.permission.RECORD_AUDIO)
                    || shouldShowRequestPermissionRationale(Manifest.permission.CAMERA)
                ) {
                    showPhoneAudioCameraPermissionRationale()
                }
            }
        }
    }

    private fun isCameraPermissionGranted() = permissions.all {
        ContextCompat.checkSelfPermission(this, it) == PackageManager.PERMISSION_GRANTED
    }

    private fun requestCameraMicPermission() {
        ActivityCompat.requestPermissions(this, permissions, REQUEST_CAMERA_MIC_CODE)
    }

    private fun showPhoneAudioCameraPermissionRationale() {
    }
    //endregion
}
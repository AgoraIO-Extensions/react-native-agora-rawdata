package io.agora.rtc.rawdata.react

import com.facebook.react.bridge.Promise
import com.facebook.react.bridge.ReactApplicationContext
import com.facebook.react.bridge.ReactContextBaseJavaModule
import com.facebook.react.bridge.ReactMethod
import io.agora.rtc.rawdata.base.AudioFrame
import io.agora.rtc.rawdata.base.IAudioFrameObserver
import io.agora.rtc.rawdata.base.IVideoFrameObserver
import io.agora.rtc.rawdata.base.VideoFrame
import java.util.*

class AgoraRawdataModule(reactContext: ReactApplicationContext) : ReactContextBaseJavaModule(reactContext) {
  override fun getName(): String {
    return "AgoraRawdata"
  }

  @ReactMethod
  fun registerAudioFrameObserver(engineHandle: Double, promise: Promise) {
    object : IAudioFrameObserver(engineHandle.toLong()) {
      override fun onRecordAudioFrame(audioFrame: AudioFrame): Boolean {
        return true
      }

      override fun onPlaybackAudioFrame(audioFrame: AudioFrame): Boolean {
        return true
      }

      override fun onMixedAudioFrame(audioFrame: AudioFrame): Boolean {
        return true
      }

      override fun onPlaybackAudioFrameBeforeMixing(uid: Int, audioFrame: AudioFrame): Boolean {
        return true
      }
    }.registerAudioFrameObserver()
    promise.resolve(0)
  }

  @ReactMethod
  fun registerVideoFrameObserver(engineHandle: Double, promise: Promise) {
    object : IVideoFrameObserver(engineHandle.toLong()) {
      override fun onCaptureVideoFrame(videoFrame: VideoFrame): Boolean {
        Arrays.fill(videoFrame.getuBuffer(), 0)
        Arrays.fill(videoFrame.getvBuffer(), 0)
        return true
      }

      override fun onRenderVideoFrame(uid: Int, videoFrame: VideoFrame): Boolean {
        Arrays.fill(videoFrame.getuBuffer(), -128)
        Arrays.fill(videoFrame.getvBuffer(), -128)
        return true
      }
    }.registerVideoFrameObserver()
    promise.resolve(0)
  }

  companion object {
    // Used to load the 'native-lib' library on application startup.
    init {
      System.loadLibrary("cpp")
    }
  }
}

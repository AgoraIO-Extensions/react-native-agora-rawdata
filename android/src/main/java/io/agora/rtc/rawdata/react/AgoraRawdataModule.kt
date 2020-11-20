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
  private var audioObserver: IAudioFrameObserver? = null
  private var videoObserver: IVideoFrameObserver? = null

  override fun getName(): String {
    return "AgoraRawdata"
  }

  @ReactMethod
  fun registerAudioFrameObserver(engineHandle: Double, promise: Promise) {
    if (audioObserver == null) {
      audioObserver = object : IAudioFrameObserver(engineHandle.toLong()) {
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
      }
    }
    audioObserver?.registerAudioFrameObserver()
    promise.resolve(null)
  }

  @ReactMethod
  fun unregisterAudioFrameObserver(promise: Promise) {
    audioObserver?.let {
      it.unregisterAudioFrameObserver()
      audioObserver = null
    }
    promise.resolve(null)
  }

  @ReactMethod
  fun registerVideoFrameObserver(engineHandle: Double, promise: Promise) {
    if (videoObserver == null) {
      videoObserver = object : IVideoFrameObserver(engineHandle.toLong()) {
        override fun onCaptureVideoFrame(videoFrame: VideoFrame): Boolean {
          Arrays.fill(videoFrame.getuBuffer(), 0)
          Arrays.fill(videoFrame.getvBuffer(), 0)
          return true
        }

        override fun onRenderVideoFrame(uid: Int, videoFrame: VideoFrame): Boolean {
          // unsigned char value 255
          Arrays.fill(videoFrame.getuBuffer(), -1)
          Arrays.fill(videoFrame.getvBuffer(), -1)
          return true
        }
      }
    }
    videoObserver?.registerVideoFrameObserver()
    promise.resolve(null)
  }

  @ReactMethod
  fun unregisterVideoFrameObserver(promise: Promise) {
    videoObserver?.let {
      it.unregisterVideoFrameObserver()
      videoObserver = null
    }
    promise.resolve(null)
  }

  companion object {
    // Used to load the 'native-lib' library on application startup.
    init {
      System.loadLibrary("cpp")
    }
  }
}

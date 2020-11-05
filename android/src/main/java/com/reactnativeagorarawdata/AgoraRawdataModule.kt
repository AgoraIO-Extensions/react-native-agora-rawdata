package com.reactnativeagorarawdata

import com.facebook.react.bridge.ReactApplicationContext
import com.facebook.react.bridge.ReactContextBaseJavaModule
import com.facebook.react.bridge.ReactMethod
import com.facebook.react.bridge.Promise

class AgoraRawdataModule(reactContext: ReactApplicationContext) : ReactContextBaseJavaModule(reactContext) {

    override fun getName(): String {
        return "AgoraRawdata"
    }

    // Example method
    // See https://facebook.github.io/react-native/docs/native-modules-android
    @ReactMethod
    fun multiply(a: Int, b: Int, promise: Promise) {
    
      promise.resolve(nativeMultiply(a, b));
    
    }

    
    external fun nativeMultiply(a: Int, b: Int): Int;

    companion object
    {

        // Used to load the 'native-lib' library on application startup.
        init
        {
            System.loadLibrary("cpp")
        }
    }
    
}

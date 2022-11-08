package com.agorarawdata;

import androidx.annotation.NonNull;

import com.facebook.react.bridge.ReactApplicationContext;
import com.facebook.react.bridge.ReactContextBaseJavaModule;
import com.facebook.react.bridge.ReactMethod;
import com.facebook.react.module.annotations.ReactModule;

import io.agora.rtc.plugin.AgoraRawDataPlugin;

@ReactModule(name = AgoraRawdataModule.NAME)
public class AgoraRawdataModule extends ReactContextBaseJavaModule {
  public static final String NAME = "AgoraRawdata";
  private AgoraRawDataPlugin plugin;

  public AgoraRawdataModule(ReactApplicationContext reactContext) {
    super(reactContext);
  }

  @Override
  @NonNull
  public String getName() {
    return NAME;
  }

  @ReactMethod(isBlockingSynchronousMethod = true)
  public void createPlugin(String engineHandle) {
    if (plugin == null) {
      plugin = new AgoraRawDataPlugin(Long.parseUnsignedLong(engineHandle));
    }
  }

  @ReactMethod(isBlockingSynchronousMethod = true)
  public void destroyPlugin() {
    if (plugin != null) {
      plugin.destroy();
      plugin = null;
    }
  }

  @ReactMethod(isBlockingSynchronousMethod = true)
  public boolean enablePlugin() {
    if (plugin != null) {
      return plugin.enablePlugin();
    }
    return false;
  }

  @ReactMethod(isBlockingSynchronousMethod = true)
  public boolean disablePlugin() {
    if (plugin != null) {
      return plugin.disablePlugin();
    }
    return false;
  }
}

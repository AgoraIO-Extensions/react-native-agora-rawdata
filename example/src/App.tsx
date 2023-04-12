import React, { useEffect, useState } from 'react';

import { StyleSheet, View } from 'react-native';
import { createAgoraRtcEngine, RtcSurfaceView } from 'react-native-agora';
import {
  createPlugin,
  destroyPlugin,
  disablePlugin,
  enablePlugin,
} from 'react-native-agora-rawdata';

export default function App() {
  const [startPreview, setStartPreview] = useState(false);

  useEffect(() => {
    const engine = createAgoraRtcEngine();
    engine.initialize({ appId: YOU_APPID });
    engine.enableVideo();
    engine.startPreview();
    setStartPreview(true);
    createPlugin(engine.getNativeHandle());
    enablePlugin();
    return () => {
      disablePlugin();
      destroyPlugin();
      engine.release();
    };
  }, []);

  return (
    <View style={styles.container}>
      {startPreview ? (
        <RtcSurfaceView style={styles.container} canvas={{ uid: 0 }} />
      ) : undefined}
    </View>
  );
}

const styles = StyleSheet.create({
  container: {
    flex: 1,
  },
});

import * as React from 'react';

import { StyleSheet, View } from 'react-native';
import { createAgoraRtcEngine, RtcSurfaceView } from 'react-native-agora';
import { createPlugin, enablePlugin } from 'react-native-agora-rawdata';

export default function App() {
  React.useEffect(() => {
    const engine = createAgoraRtcEngine();
    engine.initialize({ appId: 'aab8b8f5a8cd4469a63042fcfafe7063' });
    engine.enableVideo();
    engine.startPreview();
    createPlugin(0);
    enablePlugin();
  }, []);

  return (
    <View style={styles.container}>
      <RtcSurfaceView canvas={{ uid: 0 }} />
    </View>
  );
}

const styles = StyleSheet.create({
  container: {
    flex: 1,
    alignItems: 'center',
    justifyContent: 'center',
  },
  box: {
    width: 60,
    height: 60,
    marginVertical: 20,
  },
});

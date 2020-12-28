import * as React from 'react';
import { PermissionsAndroid, ScrollView, StyleSheet, View } from 'react-native';
import AgoraRawdata from 'react-native-agora-rawdata';
import RtcEngine, { RtcLocalView, RtcRemoteView } from 'react-native-agora';

const config = require('../agora.config.json');

export default function App() {
  const [engine, setEngine] = React.useState<RtcEngine>();
  const [remoteUid, setRemoteUid] = React.useState<number[]>([]);

  React.useEffect(() => {
    console.warn('mounted');

    (async function () {
      await PermissionsAndroid.requestMultiple([
        PermissionsAndroid.PERMISSIONS.CAMERA,
        PermissionsAndroid.PERMISSIONS.RECORD_AUDIO,
      ]);

      const agora = await RtcEngine.create(config.appId);
      setEngine(() => agora);
      agora.addListener('JoinChannelSuccess', (channel, uid, elapsed) => {
        console.info('JoinChannelSuccess', channel, uid, elapsed);
      });
      agora?.addListener('UserJoined', (uid, elapsed) => {
        console.info('UserJoined', uid, elapsed);
        setRemoteUid((value) => [...value, uid]);
      });
      agora?.addListener('UserOffline', (uid, reason) => {
        console.info('UserOffline', uid, reason);
        setRemoteUid((value) => value.filter((v) => v !== uid));
      });
      await agora.enableVideo();
      await agora.startPreview();
      await AgoraRawdata.registerAudioFrameObserver(
        await agora.getNativeHandle()
      );
      await AgoraRawdata.registerVideoFrameObserver(
        await agora.getNativeHandle()
      );
      await agora.joinChannel(
        config.token,
        config.channelId,
        undefined,
        config.uid
      );
    })();

    return function () {
      console.warn('unmounted');

      (async function () {
        await AgoraRawdata.unregisterAudioFrameObserver();
        await AgoraRawdata.unregisterVideoFrameObserver();
        setEngine((value) => {
          value?.destroy();
          return undefined;
        });
      })();
    };
  }, []);

  return (
    <View style={styles.container}>
      {engine !== undefined && (
        <RtcLocalView.SurfaceView style={styles.container} />
      )}
      {remoteUid !== undefined && (
        <ScrollView horizontal={true} style={styles.remoteContainer}>
          {remoteUid.map((value) => (
            <RtcRemoteView.SurfaceView
              key={value}
              style={styles.remote}
              uid={value}
              zOrderMediaOverlay={true}
            />
          ))}
        </ScrollView>
      )}
    </View>
  );
}

const styles = StyleSheet.create({
  container: {
    flex: 1,
  },
  remoteContainer: {
    position: 'absolute',
    left: 0,
    top: 0,
  },
  remote: {
    width: 120,
    height: 120,
  },
});

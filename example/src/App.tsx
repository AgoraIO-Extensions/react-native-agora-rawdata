import * as React from 'react';
import { PermissionsAndroid, StyleSheet, Text, View } from 'react-native';
import AgoraRawdata from 'react-native-agora-rawdata';
import Agora, { RtcLocalView, RtcRemoteView } from 'react-native-agora';

const config = require('../../../agora.config.json');

export default function App() {
  const [joined, setJoined] = React.useState<boolean>();

  React.useEffect(() => {
    const test = async () => {
      await PermissionsAndroid.requestMultiple([
        PermissionsAndroid.PERMISSIONS.CAMERA,
        PermissionsAndroid.PERMISSIONS.RECORD_AUDIO,
      ]);
      const agora = await Agora.create(config.appId);
      agora.addListener('JoinChannelSuccess', () => {
        setJoined(true);
      });
      await agora.enableVideo();
      await AgoraRawdata.registerAudioFrameObserver(
        await agora.getNativeHandle()
      );
      await AgoraRawdata.registerVideoFrameObserver(
        await agora.getNativeHandle()
      );
      await agora.joinChannel(config.token, config.channelId, undefined, 456);
    };

    // eslint-disable-next-line jest/no-disabled-tests
    test();
  }, []);

  return (
    <View style={styles.container}>
      <Text>isJoined: {joined}</Text>
      {joined && <RtcLocalView.SurfaceView style={styles.container} />}
      {joined && (
        <RtcRemoteView.SurfaceView style={styles.container} uid={123} />
      )}
    </View>
  );
}

const styles = StyleSheet.create({
  container: {
    flex: 1,
  },
});

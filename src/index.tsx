import { NativeModules } from 'react-native';

type AgoraRawdataType = {
  registerAudioFrameObserver(engineHandle: number): Promise<void>;

  unregisterAudioFrameObserver(): Promise<void>;

  registerVideoFrameObserver(engineHandle: number): Promise<void>;

  unregisterVideoFrameObserver(): Promise<void>;
};

const { AgoraRawdata } = NativeModules;

export default AgoraRawdata as AgoraRawdataType;

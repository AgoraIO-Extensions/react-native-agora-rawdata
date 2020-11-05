import { NativeModules } from 'react-native';

type AgoraRawdataType = {
  multiply(a: number, b: number): Promise<number>;
};

const { AgoraRawdata } = NativeModules;

export default AgoraRawdata as AgoraRawdataType;

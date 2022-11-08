import { NativeModules, Platform } from 'react-native';

const LINKING_ERROR =
  `The package 'react-native-agora-rawdata' doesn't seem to be linked. Make sure: \n\n` +
  Platform.select({ ios: "- You have run 'pod install'\n", default: '' }) +
  '- You rebuilt the app after installing the package\n' +
  '- You are not using Expo Go\n';

const AgoraRawdata = NativeModules.AgoraRawdata
  ? NativeModules.AgoraRawdata
  : new Proxy(
      {},
      {
        get() {
          throw new Error(LINKING_ERROR);
        },
      }
    );

export function createPlugin(engineHandle: number): void {
  AgoraRawdata.createPlugin(`${engineHandle}`);
}

export function destroyPlugin(): void {
  AgoraRawdata.destroyPlugin();
}

export function enablePlugin(): boolean {
  return AgoraRawdata.enablePlugin();
}

export function disablePlugin(): boolean {
  return AgoraRawdata.disablePlugin();
}

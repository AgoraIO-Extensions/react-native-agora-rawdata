# react-native-agora-rawdata

The rawdata plugin for [react-native-agora](https://www.npmjs.com/package/react-native-agora).

## Important

The plugin only exports four methods to the javascript layer that can register or unregister the observer.

```ts
type AgoraRawdataType = {
  registerAudioFrameObserver(engineHandle: number): Promise<void>;

  unregisterAudioFrameObserver(): Promise<void>;

  registerVideoFrameObserver(engineHandle: number): Promise<void>;

  unregisterVideoFrameObserver(): Promise<void>;
};
```

The plugin changes the color of the video stream by the default:

* Change local video to green
* Change remote video to pink

You can find the code at:

* Android: [AgoraRawdataModule.kt](android/src/main/java/io/agora/rtc/rawdata/react/AgoraRawdataModule.kt)
  * Local video: `onCaptureVideoFrame`
  * Remote video: `onRenderVideoFrame`
* iOS: [AgoraRawdata.swift](ios/React/AgoraRawdata.swift)
  * Local video: `onCapture`
  * Remote video: `onRenderVideoFrame`

**If you can program with C++, you should process raw data on the C++ layer to improve performance and remove code about
calling Android and iOS.**

You can find the code at:

* Android:
  * Audio: [AudioFrameObserver.cpp](cpp/android/AudioFrameObserver.cpp)
  * Video: [VideoFrameObserver.cpp](cpp/android/VideoFrameObserver.cpp)
* iOS:
  * Audio: [AgoraAudioFrameObserver.mm](ios/Base/AgoraAudioFrameObserver.mm)
  * Video: [AgoraVideoFrameObserver.mm](ios/Base/AgoraVideoFrameObserver.mm)

## Installation

```shell
npm install react-native-agora-rawdata
```

**You should fork this repository, and modify the code to implement your requirement, such as use third-party beauty SDK.**

## Usage

```js
import AgoraRawdata from "react-native-agora-rawdata";
import RtcEngine from 'react-native-agora';

const agora = await RtcEngine.create(appId);
await AgoraRawdata.registerAudioFrameObserver(
  await agora.getNativeHandle()
);
await AgoraRawdata.registerVideoFrameObserver(
  await agora.getNativeHandle()
);
```

## Resources

* [Doc](https://docs.agora.io/en/Interactive%20Broadcast/landing-page?platform=React%20Native) for `react-native-agora`
* [Doc](https://docs.agora.io/en/Interactive%20Broadcast/raw_data_video_android?platform=Android) for Android raw video
  data
* [Doc](https://docs.agora.io/en/Interactive%20Broadcast/raw_data_video_apple?platform=iOS) for iOS raw video data

## Contributing

See the [contributing guide](CONTRIBUTING.md) to learn how to contribute to the repository and the development workflow.

## License

MIT

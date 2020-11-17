//
//  AgoraRawdataBridge.m
//  react-native-agora-rawdata
//
//  Created by LXH on 2020/11/11.
//

#import <React/RCTBridgeModule.h>

@interface RCT_EXTERN_MODULE (AgoraRawdata, NSObject)

RCT_EXTERN_METHOD(registerAudioFrameObserver
                  : (NSNumber *_Nonnull)engineHandle
                  : (RCTPromiseResolveBlock)resolve
                  : (RCTPromiseRejectBlock)reject)

RCT_EXTERN_METHOD(unregisterAudioFrameObserver
                  : (RCTPromiseResolveBlock)resolve
                  : (RCTPromiseRejectBlock)reject)

RCT_EXTERN_METHOD(registerVideoFrameObserver
                  : (NSNumber *_Nonnull)engineHandle
                  : (RCTPromiseResolveBlock)resolve
                  : (RCTPromiseRejectBlock)reject)

RCT_EXTERN_METHOD(unregisterVideoFrameObserver
                  : (RCTPromiseResolveBlock)resolve
                  : (RCTPromiseRejectBlock)reject)

@end

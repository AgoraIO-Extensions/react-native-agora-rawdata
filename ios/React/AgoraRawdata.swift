//
//  AgoraRawdata.swift
//  AgoraRawdata
//
//  Created by LXH on 2020/11/11.
//  Copyright © 2020 Facebook. All rights reserved.
//

import Foundation

@objc(AgoraRawdata)
class AgoraRawdata: NSObject, RCTBridgeModule, AgoraAudioFrameDelegate, AgoraVideoFrameDelegate {
    static let REACT_CLASS = "AgoraRawdata"

    private var audioObserver: AgoraAudioFrameObserver?
    private var videoObserver: AgoraVideoFrameObserver?

    static func moduleName() -> String! {
        return AgoraRawdata.REACT_CLASS
    }

    static func requiresMainQueueSetup() -> Bool {
        return true
    }

    var methodQueue: DispatchQueue! = DispatchQueue.main

    @objc func registerAudioFrameObserver(_ engineHandle: NSNumber, _ resolve: RCTPromiseResolveBlock?, _: RCTPromiseRejectBlock?) {
        if audioObserver == nil {
            audioObserver = AgoraAudioFrameObserver(engineHandle: engineHandle.uintValue)
        }
        audioObserver?.delegate = self
        audioObserver?.register()
        resolve?(0)
    }

    @objc func unregisterAudioFrameObserver(_ resolve: RCTPromiseResolveBlock?, _: RCTPromiseRejectBlock?) {
        if audioObserver != nil {
            audioObserver?.delegate = nil
            audioObserver?.unregisterAudioFrameObserver()
            audioObserver = nil
        }
        resolve?(0)
    }

    @objc func registerVideoFrameObserver(_ engineHandle: NSNumber, _ resolve: RCTPromiseResolveBlock?, _: RCTPromiseRejectBlock?) {
        if videoObserver == nil {
            videoObserver = AgoraVideoFrameObserver(engineHandle: engineHandle.uintValue)
        }
        videoObserver?.delegate = self
        videoObserver?.register()
        resolve?(0)
    }

    @objc func unregisterVideoFrameObserver(_ resolve: RCTPromiseResolveBlock?, _: RCTPromiseRejectBlock?) {
        if videoObserver != nil {
            videoObserver?.delegate = nil
            videoObserver?.unregisterVideoFrameObserver()
            videoObserver = nil
        }
        resolve?(0)
    }

    func onRecord(_: AgoraAudioFrame) -> Bool {
        return true
    }

    func onPlaybackAudioFrame(_: AgoraAudioFrame) -> Bool {
        return true
    }

    func onMixedAudioFrame(_: AgoraAudioFrame) -> Bool {
        return true
    }

    func onPlaybackAudioFrame(beforeMixing _: AgoraAudioFrame, uid _: UInt) -> Bool {
        return true
    }

    func onCapture(_: AgoraVideoFrame) -> Bool {
        return true
    }

    func onRenderVideoFrame(_ videoFrame: AgoraVideoFrame, uid _: UInt) -> Bool {
        memset(videoFrame.uBuffer, 0, Int(videoFrame.uStride * videoFrame.height) / 2)
        memset(videoFrame.vBuffer, 0, Int(videoFrame.vStride * videoFrame.height) / 2)
        return true
    }
}

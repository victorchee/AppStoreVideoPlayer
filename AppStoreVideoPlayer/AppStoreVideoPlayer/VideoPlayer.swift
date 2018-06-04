//
//  VideoPlayer.swift
//  AppStoreVideoPlayer
//
//  Created by Migu on 2018/5/25.
//  Copyright © 2018年 VIctorChee. All rights reserved.
//

import Foundation
import AVFoundation

class VideoPlayer {
    private var player:AVPlayer
    private(set) var playerLayer: AVPlayerLayer
    
    weak var playbackDelegate: VideoPlayerPlaybackDelegate?
    
    enum PlayerStatus {
        case playing, paused, buffering
    }
    private(set) var status = PlayerStatus.paused {
        didSet {
            playbackDelegate?.playerStatusDidChange(self, status: self.status)
        }
    }
    
    var isMuted: Bool {
        get { return player.isMuted }
        set {
            player.isMuted = newValue
            playbackDelegate?.playerMuteDidChange(self, muted: self.isMuted)
        }
    }
    
    init(_ url: URL) {
        player = AVPlayer(url: url)
        playerLayer = AVPlayerLayer(player: player)
    }
    
    func play() {
        player.play()
        status = .playing
        playbackDelegate?.playerDidPlay(self)
    }
    
    func pause() {
        player.pause()
        status = .paused
        playbackDelegate?.playerDidPause(self)
    }
}

protocol VideoPlayerPlaybackDelegate: AnyObject {
    func playerDidPlay(_ player: VideoPlayer)
    func playerDidPause(_ player: VideoPlayer)
    func playerStatusDidChange(_ player: VideoPlayer, status: VideoPlayer.PlayerStatus)
    func playerMuteDidChange(_ player: VideoPlayer, muted: Bool)
}

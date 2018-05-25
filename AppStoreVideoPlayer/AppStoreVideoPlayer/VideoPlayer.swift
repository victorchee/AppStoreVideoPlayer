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
    var playerLayer: AVPlayerLayer
    
    var isMuted: Bool {
        get {
            return player.isMuted
        }
        set {
            player.isMuted = newValue
        }
    }
    
    init(_ url: URL) {
        let url = Bundle.main.url(forResource: "hubblecast", withExtension: "m4v")!
        player = AVPlayer(url: url)
        
        playerLayer = AVPlayerLayer(player: player)
    }
    
    func play() {
        player.play()
    }
    
    func pause() {
        player.pause()
    }
}

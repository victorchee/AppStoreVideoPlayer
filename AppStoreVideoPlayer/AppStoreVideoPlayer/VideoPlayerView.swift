//
//  VideoPlayerView.swift
//  AppStoreVideoPlayer
//
//  Created by Migu on 2018/5/25.
//  Copyright © 2018年 VIctorChee. All rights reserved.
//

import UIKit

typealias ButtonHandler = (UIButton) -> ()

class VideoPlayerView: UIView {
    weak var player: VideoPlayer? {
        didSet {
            guard let player = self.player else { return }
            player.playerLayer.frame = self.bounds
            layer.insertSublayer(player.playerLayer, at: 0)
            
            player.playbackDelegate = self
        }
    }
    @IBOutlet weak var playButton: UIButton!
    @IBOutlet weak var fullscreenButton: UIButton!
    @IBOutlet weak var muteButton: UIButton!
    
    var fullscreenHandler: ButtonHandler?

    override func layoutSubviews() {
        super.layoutSubviews()
        player?.playerLayer.frame = bounds
    }
    
    @IBAction func playButtonTapped(_ sender: UIButton) {
        if player?.status == .playing || player?.status == .buffering {
            player?.pause()
        } else {
            player?.play()
        }
    }
    
    @IBAction func fullscreenButtonTapped(_ sender: UIButton) {
        fullscreenHandler?(sender)
    }
    
    @IBAction func muteButtonTapped(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
        player?.isMuted = sender.isSelected;
    }
}

extension VideoPlayerView: VideoPlayerPlaybackDelegate {
    func playerDidPlay(_ player: VideoPlayer) {
        playButton.isSelected = true
    }
    
    func playerDidPause(_ player: VideoPlayer) {
        playButton.isSelected = false
    }
    
    func playerStatusDidChange(_ player: VideoPlayer, status: VideoPlayer.PlayerStatus) {
    }
    
    func playerMuteDidChange(_ player: VideoPlayer, muted: Bool) {
        muteButton.isSelected = muted
    }
}

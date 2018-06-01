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
        }
    }
    
    var fullscreenHandler: ButtonHandler?

    override func layoutSubviews() {
        super.layoutSubviews()
        player?.playerLayer.frame = bounds
    }

    @IBAction func fullscreenButtonTapped(_ sender: UIButton) {
        fullscreenHandler?(sender)
    }
}

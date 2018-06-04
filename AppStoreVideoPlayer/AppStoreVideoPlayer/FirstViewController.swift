//
//  FirstViewController.swift
//  AppStoreVideoPlayer
//
//  Created by Migu on 2018/5/25.
//  Copyright © 2018年 VIctorChee. All rights reserved.
//

import UIKit

class FirstViewController: UIViewController {
    @IBOutlet weak var contentView: UIView!
    var player: VideoPlayer!
    var playerView: VideoPlayerView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib
        let url = Bundle.main.url(forResource: "hubblecast", withExtension: "m4v")!
        player = VideoPlayer(url)
        
        playerView = Bundle.main.loadNibNamed(String(describing: VideoPlayerView.self), owner: nil, options: [:])?.first as? VideoPlayerView
        playerView?.player = player
        playerView?.fullscreenHandler = { [unowned self] sender in
            guard let playerController = self.storyboard?.instantiateViewController(withIdentifier: String(describing: VideoPlayerFullscreenViewController.self)) as? VideoPlayerFullscreenViewController else { return }
            playerController.player = self.player
            playerController.miniscreenHandler = { [unowned self] sender in
                self.playerView?.player = self.player
            }
            playerController.modalTransitionStyle = UIModalTransitionStyle.crossDissolve
            self.present(playerController, animated: true) { }
        }
        if let playerView = playerView {
            contentView.addSubview(playerView)
        }
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        playerView?.frame = contentView.bounds
    }
}


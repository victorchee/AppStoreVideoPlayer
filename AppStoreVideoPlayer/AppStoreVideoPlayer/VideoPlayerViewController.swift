//
//  VideoPlayerViewController.swift
//  AppStoreVideoPlayer
//
//  Created by Migu on 2018/5/25.
//  Copyright © 2018年 VIctorChee. All rights reserved.
//

import UIKit

class VideoPlayerViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        playerLayer.frame = view.bounds
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        player.play()
    }
    
    @IBAction func fullscreenButtonTapped(_ sender: UIButton) {
    }
    
    @IBAction func muteButtonTapped(_ sender: UIButton) {
    }
    
    @IBAction func pauseButtonTapped(_ sender: UIButton) {
    }
    
    @IBAction func tap(_ sender: UITapGestureRecognizer) {
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

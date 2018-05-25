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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        guard let player = storyboard?.instantiateViewController(withIdentifier: String(describing: VideoPlayerViewController.self)) else { return }
        addChildViewController(player)
        contentView.addSubview(player.view)
        player.view.translatesAutoresizingMaskIntoConstraints = false
        player.view.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
        player.view.leftAnchor.constraint(equalTo: contentView.leftAnchor).isActive = true
        player.view.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
        player.view.rightAnchor.constraint(equalTo: contentView.rightAnchor).isActive = true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}


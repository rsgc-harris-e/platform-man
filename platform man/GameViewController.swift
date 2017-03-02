//
//  GameViewController.swift
//  platform man
//
//  Created by Student on 2017-02-28.
//  Copyright © 2017 Student. All rights reserved.
//

import UIKit
import SpriteKit

class GameViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let scene = GameScene(size:CGSize(width: 2048, height:1536))
                // Set the scale mode to scale to fit the window
              let skview = self.view as! SKView
            skview.showsFPS = true
            skview.showsNodeCount = true
            skview.ignoresSiblingOrder = true
            scene.scaleMode = .aspectFill //scene will expand if necessary
                // Present the scene
                skview.presentScene(scene)
        }
    override var prefersStatusBarHidden: Bool {
        return true
    }
}

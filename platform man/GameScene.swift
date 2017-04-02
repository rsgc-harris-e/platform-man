//
//  GameScene.swift
//  platform man
//
//  Created by Student on 2017-02-28.
//  Copyright © 2017 Student. All rights reserved.
//

import SpriteKit


class GameScene: SKScene {
 let koala = SKSpriteNode(imageNamed: "koala") // we want to be able to manipulate the koala for the game
    
    override func didMove(to view: SKView){
        backgroundColor = SKColor.black
        let background = SKSpriteNode(imageNamed: "forest")
        background.position = CGPoint(x:size.width/2, y:size.height/2)//anchor image middle of screen horizontally and vertically as well
        background.size = self.frame.size
        background.zPosition = -1
        addChild(background)
        koala.setScale(2)
        koala.position = CGPoint(x: size.width/2, y: 300)
        addChild(koala)
        
    //spawns obstacle after koala
        spawnobstacle()
    
        
}
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else {
            return
        }
        //get location of first touch
        let touchlocation = touch.location(in: self)
        print(touchlocation.x)
        print(touchlocation.y)
        //moves koala horizontally
        let destination = CGPoint(x: touchlocation.x, y: koala.position.y)
        
        let actionMove = SKAction.move(to: destination, duration: 2)
        koala.run(actionMove)
    }
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else {
            return
        }
         //get location of first touch
        let touchlocation = touch.location(in: self)
        let destination = CGPoint(x: touchlocation.x, y: koala.position.y)
        
        let actionMove = SKAction.move(to: destination, duration: 2)
        koala.run(actionMove)

       

    }
    //simple method for an enemy
    func spawnobstacle(){
        let snake = SKSpriteNode(imageNamed: "snake")
        snake.setScale(0.5)
        let startingposition = CGPoint(x: 2000, y: 300)
        snake.position = startingposition
        addChild(snake)
        let endingposition = CGPoint(x:0, y: 300)
        let ActionMove = SKAction.move(to: endingposition, duration: 10)
        snake.run(ActionMove)
    }
}



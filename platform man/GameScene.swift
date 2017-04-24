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
    //label a variable to track score
    
    let scorelabel = SKLabelNode(fontNamed: "Cambria")
    var score = 0 //this tracks score
    
    
    override func didMove(to view: SKView){
        backgroundColor = SKColor.black
        let background = SKSpriteNode(imageNamed: "forest")
        background.position = CGPoint(x:size.width/2, y:size.height/2)//anchor image middle of screen horizontally and vertically as well
        background.size = self.frame.size
        background.zPosition = -1
        //background established
        addChild(background)
        koala.setScale(2)
        koala.position = CGPoint(x: size.width/2, y: 300)
        addChild(koala)
        koala.physicsBody = SKPhysicsBody(rectangleOf: koala.frame.size)
        self.physicsBody = SKPhysicsBody(edgeLoopFrom: frame)

        
        //periodically spawns obstacles
        let spawnwait = SKAction.wait(forDuration:4) //set time between obstacle spawns
        let actionspawn = SKAction.run() {[weak self]in self?.spawnobstacle()} //tell run function what function should be run
        let actionsequence = SKAction.sequence([spawnwait,actionspawn])
        let actionobstaclerepeat = SKAction.repeatForever(actionsequence)
        run(actionobstaclerepeat)//function will now repeat itself forever
        //add display to show the score
        scorelabel.text = String(score)
        scorelabel.color = SKColor.red
        scorelabel.fontSize = 96
        scorelabel.zPosition = 150 //make sure display is above all other things in the scene
        scorelabel.position = CGPoint(x:size.width - size.width/2, y: size.height - size.height/4)
        addChild(scorelabel)
    }
    //this function moves about 60 times per second
    override func update(_ currentTime: TimeInterval) {
        checkCollisions()
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
        //create instance of the obstacle
        let snake = SKSpriteNode(imageNamed: "snake")
        snake.setScale(0.5)
        //defines the starting position of obstacle
        let startingposition = CGPoint(x: 2000, y: 60)
        snake.position = startingposition
        //create a name for the obstacle
        snake.name = "snake"
        addChild(snake)
        let endingposition = CGPoint(x:0, y: 60)
        let ActionMove = SKAction.move(to: endingposition, duration: 10)
        let actionremove = SKAction.removeFromParent()
        let actionsequence = SKAction.sequence([ActionMove,actionremove])
        snake.run(actionsequence)
    }
    //this function checks for collsions between the koala and obstacles
    func checkCollisions(){
        var hitObstacles : [SKSpriteNode] = []
        //find obstacles colliding with the koala
        enumerateChildNodes(withName: "snake", using: {
            node, _ in
            
            //get a reference to node that was found
            let obstacle = node as! SKSpriteNode
            //check to see if the obstacle is intersecting with the koala
            if obstacle.frame.insetBy(dx: 10, dy: 10).intersects(self.koala.frame.insetBy(dx: 20, dy:20)){
                hitObstacles.append(obstacle)
            }
        })
        for obstacle in hitObstacles{
            koalaHit(by: obstacle)
        }
    }
    func koalaHit(by obstacle: SKSpriteNode){
        //reduce the score
        score+=1
        //update score label
        scorelabel.text = String(score)
        //snake node is removed from the program
        obstacle.removeFromParent()
        
    }
}



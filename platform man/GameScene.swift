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
        koala.position = CGPoint(x: 700, y: 400)
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
        let crocspawnwait = SKAction.wait(forDuration:5) //set time between obstacle spawns
        let crocactionspawn = SKAction.run() {[weak self]in self?.spawncroc()} //tell run function what function should be run
        //to avoid a memory leak we run the function with a "weak reference"
        let crocactionsequence = SKAction.sequence([crocspawnwait,crocactionspawn])
        let crocactionobstaclerepeat = SKAction.repeatForever(crocactionsequence)
        run(crocactionobstaclerepeat)//function will now repeat itself forever
    }
    //this function moves about 60 times per second
    override func update(_ currentTime: TimeInterval) {
        checkCollisions()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {        //get location of
        if let body = koala.physicsBody{
            body.applyImpulse(CGVector(dx:0,dy: 1200))
        }

    }
    //simple method for a sprite
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
    func spawncroc(){
         let croc = SKSpriteNode(imageNamed: "croc")
        croc.setScale(1)
        let horizontalposition = CGFloat(arc4random_uniform(UInt32(size.height)))
        //create instance of the obstacle
        //defines the starting position of obstacle
        let startingposition = CGPoint(x: horizontalposition+700, y: 100)
        croc.position = startingposition
        //create a name for the obstacle
        croc.name = "croc"
        addChild(croc)
        let endingposition = CGPoint(x:0, y: 100)
        
        let ActionMove = SKAction.move(to: endingposition, duration: 10)
        let actionremove = SKAction.removeFromParent()
        //defines sequence for what should happen for the croc node
        //it moves horizontally across the screen and if it goes off then it is removed from the game
        //ActionMove is run and actionremove is removing the node
        let actionsequence = SKAction.sequence([ActionMove,actionremove])
        croc.run(actionsequence)
    }

       //this function checks for collisions between the koala and obstacles
    func checkCollisions(){
        
        var hitSnakes : [SKSpriteNode] = []

        // Iterate over all the child nodes in the scene
        for node in self.children {
            
            // Only check on nodes that have a name
            if let nodeName = node.name {
                
                // Is this is a snake or a koala?
                if nodeName == "snake" {

                    //get a reference to node that was found
                    let obstacle = node as! SKSpriteNode
                    //check to see if the obstacle is intersecting with the koala
                    if obstacle.frame.insetBy(dx:20,dy: 50).intersects(self.koala.frame.insetBy(dx:5,dy:10)){
                        hitSnakes.append(obstacle)
                    }
                    
                } else if nodeName == "croc" {
                    
                    // Game over
                    print("game over, man")
                }
            }
            
        }
        
        // Do what we need to do when the koala hero is hit by a snake
        for snake in hitSnakes{
            koalaHit(by: snake)
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



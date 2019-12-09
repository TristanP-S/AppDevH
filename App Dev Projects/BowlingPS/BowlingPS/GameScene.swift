//
//  GameScene.swift
//  BowlingPS
//
//  Created by Tristan Pudell-Spatscheck on 12/9/19.
//  Copyright © 2019 Tristan Pudell-Spatscheck. All rights reserved.
//
import SpriteKit
import GameplayKit

class GameScene: SKScene {
    //MARK - Sprites
    var ball = SKSpriteNode()
    var pin1 = SKSpriteNode()
    var pin2 = SKSpriteNode()
    var pin3 = SKSpriteNode()
    var pin4 = SKSpriteNode()
    var pin5 = SKSpriteNode()
    var pin6 = SKSpriteNode()
    var pin7 = SKSpriteNode()
    var pin8 = SKSpriteNode()
    var pin9 = SKSpriteNode()
    var pin10 = SKSpriteNode()
    override func didMove(to view: SKView) {
        ball = self.childNode(withName: "bowlingBall") as! SKSpriteNode
        ball.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: 100, height: 100))
        disableDefaults(sprite: ball)
        pin1 = self.childNode(withName: "pin1") as! SKSpriteNode
        pin2 = self.childNode(withName: "pin2") as! SKSpriteNode
        pin3 = self.childNode(withName: "pin3") as! SKSpriteNode
        pin4 = self.childNode(withName: "pin4") as! SKSpriteNode
        pin5 = self.childNode(withName: "pin5") as! SKSpriteNode
        pin6 = self.childNode(withName: "pin6") as! SKSpriteNode
        pin7 = self.childNode(withName: "pin7") as! SKSpriteNode
        pin8 = self.childNode(withName: "pin8") as! SKSpriteNode
        pin9 = self.childNode(withName: "pin9") as! SKSpriteNode
        pin10 = self.childNode(withName: "pin10") as! SKSpriteNode
        //sets up border of screen as border
        let border = SKPhysicsBody(edgeLoopFrom: self.frame)
        border.friction = 0
        border.restitution = 0
        border.isDynamic = false
        self.physicsBody = border
        //sets up pins
        resetPins()
    }
    //resets pins to original spots + sizes
    func resetPins(){
        pinSetup(pin: pin1, xPos: 0, yPos: 0)
        pinSetup(pin: pin2, xPos: -100, yPos: 160)
        pinSetup(pin: pin3, xPos: 100, yPos: 160)
        pinSetup(pin: pin4, xPos: -200, yPos: 300)
        pinSetup(pin: pin5, xPos: 0, yPos: 300)
        pinSetup(pin: pin6, xPos: 200, yPos: 300)
        pinSetup(pin: pin7, xPos: -280, yPos: 450)
        pinSetup(pin: pin8, xPos: -100, yPos: 450)
        pinSetup(pin: pin9, xPos: 100, yPos: 450)
        pinSetup(pin: pin10, xPos: 280, yPos: 450)
    }
    //used to make resetPins concise (actual setup per pin)
    func pinSetup(pin: SKSpriteNode, xPos: CGFloat, yPos: CGFloat){
        pin.position.x = xPos
        pin.position.y = yPos
        pin.size.width = 50
        pin.size.height = 100
        pin.zRotation = 0
        pin.texture = SKTexture(imageNamed: "bowlingPin")
        pin.physicsBody?.velocity = CGVector(dx: 0, dy: 0)
        disableDefaults(sprite: pin)
    }
    //disables some default physics stuff that isn't needed
    func disableDefaults(sprite: SKSpriteNode){
        sprite.physicsBody?.affectedByGravity = false
        sprite.physicsBody?.allowsRotation = true
        sprite.physicsBody?.isDynamic = true
        sprite.physicsBody?.restitution = 0
        sprite.physicsBody?.friction = 0
        sprite.physicsBody?.linearDamping = 0
        sprite.physicsBody?.angularDamping = 0
    }
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
    }
}

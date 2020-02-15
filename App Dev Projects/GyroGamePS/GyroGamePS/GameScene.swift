/*
  GameScene.swift
  GyroGamePS
  Created by Tristan Pudell-Spatscheck on 2/11/20.
  Copyright © 2020 Tristan Pudell-Spatscheck. All rights reserved.
Note from teacher (Matthew Horner) when I asked about using accelerometer instead: In general, I want one of this app and whatever we do next to involve gyroscope, and one to involve accelerometer. However, if you can give me a write-up in this one of what the gyroscope is giving you and why it's not the best choice for your particular app, I'd be fine with that.
Write up as to why I used accelerometer instead of gyroscope:
 The gyroscope measures the velocity of my phone while the acclerometer measures the acceleration. Due to how the iPhone handles velocity and accleration, the "velocity" it simply compares the location in a set time interval, meaning your phone must constantly be turning right and can't be held in a single position. The accelerometer on the other hand will measure the difference in acceleration in a given time interval, which will tend to give direction instead of speed, allowing it to measure the direction the phone is in a lot better and allows the user to control the player better. After testing both of them, the accelerometer just worked better for this application. If I wanted to control this using the gyroscope, all I would have to do is change the values in setupGyro to .gyroupdateinterval, startGyroUpdates, and .rotationRate respectively. 
 */
import SpriteKit
import GameplayKit
import CoreMotion
class GameScene: SKScene {
    //MARK: variables
    var motionManager : CMMotionManager = CMMotionManager()
    private var spawnedWalls: [[SKSpriteNode]] = []
    private var scoreLbl: SKLabelNode?
    private var playAgainLbl: SKLabelNode?
    private var player: SKSpriteNode?
    private var playBtn: SKSpriteNode?
    private var time: Double = 0
    private var score: Int = 0
    private var highScore: Int = 0
    private var active: Bool = true
    private var menu: Bool = false
    //MARK: functions
    override func didMove(to view: SKView) {
        //Sets up nodes
        self.scoreLbl = self.childNode(withName: "scoreLbl") as? SKLabelNode
        self.player = self.childNode(withName: "playerSprite") as? SKSpriteNode
        setupPlayer()
        //Sets up other stuff
        self.highScore = UserDefaults.standard.integer(forKey: "highScore")
        self.score = 0
        self.scoreLbl?.text = "Score: \(score)"
        setupBorder()
        setupGyro()
        moveObject(x: 0)
        nextWall()
    }
    //MARK: setup/generation functions
    //Sets up player node
    func setupPlayer(){
        player?.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: 25, height: 25))
        player?.size = CGSize(width: 25, height: 25)
        player?.position = CGPoint(x: 0, y: 0)
        setDefaults(sprite: player!, mass: 0.000000000000000000000001, zPosition: 2, affectedByGravity: true, isDyamic: true)
        player?.physicsBody?.restitution = 0.2
    }
    //Makes a wall
    func generateWall(width: CGFloat, height: CGFloat, position: CGPoint) -> SKSpriteNode{
        let wall = SKSpriteNode(color: .blue, size: CGSize(width: width, height: height))
        wall.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: width, height: height))
        wall.position = position
        setDefaults(sprite: wall, mass: 100000, zPosition: 1, affectedByGravity: false, isDyamic: true)
        wall.physicsBody?.velocity = CGVector(dx: 0, dy: 100)
        return wall
    }
    //Makes a entire wall with one piece missing
    func nextWall(){
        let width: CGFloat = 100
        let height: CGFloat = 25
        let wall1: SKSpriteNode = generateWall(width: width, height: height, position: CGPoint(x: -width / 2, y: -650))
        let wall2: SKSpriteNode = generateWall(width: width, height: height, position: CGPoint(x: width / 2, y: -650))
        let wall3: SKSpriteNode = generateWall(width: width, height: height, position: CGPoint(x: -(width * 1.5), y: -650))
        let wall4: SKSpriteNode = generateWall(width: width, height: height, position: CGPoint(x: (width * 1.5), y: -650))
        let wall5: SKSpriteNode = generateWall(width: width, height: height, position: CGPoint(x: -(width * 2.5), y: -650))
        let wall6: SKSpriteNode = generateWall(width: width, height: height, position: CGPoint(x: (width * 2.5), y: -650))
        let wall7: SKSpriteNode = generateWall(width: width, height: height, position: CGPoint(x: -(width * 3.5), y: -650))
        let wall8: SKSpriteNode = generateWall(width: width, height: height, position: CGPoint(x: (width * 3.5), y: -650))
        var fullWall: [SKSpriteNode] = [wall1, wall2, wall3, wall4, wall5, wall6, wall7, wall8]
        fullWall.remove(at: Int.random(in: 0...fullWall.count - 1)) //removes a random wall
        for wall in fullWall{ //adds wall to scene
            self.addChild(wall)
        }
        spawnedWalls.append(fullWall)
    }
    //Sets up border of screen as its own physics body
    func setupBorder(){
        //sets up border of screen as border
        let border = SKPhysicsBody(edgeLoopFrom: self.frame)
        border.friction = 0
        border.restitution = 0
        border.isDynamic = false
        self.physicsBody = border
    }
    //Sets up gyroscope sensor data
    func setupGyro(){
        motionManager.accelerometerUpdateInterval = 0.2
        motionManager.startAccelerometerUpdates(to: OperationQueue.current!) { (data, error) in
            print(data as Any)
            if let trueData = data {
                let x = trueData.acceleration.x
                let y = trueData.acceleration.y
                let z = trueData.acceleration.z
                //do motion here
                print("X: \(x), Y: \(y), Z: \(z)")
                self.moveObject(x: x)
            }
        }
    }
    //Creates the "menu" upon death
    func setMenu(){
        print("setCalled")
        //removes any walls left over
        if (spawnedWalls.count > 0){
            for walls in spawnedWalls{
                for wall in walls{
                    wall.removeFromParent()
                }
            }
        }
        closeMenu()
    }
    func closeMenu(){
        menu = false
    }
    //MARK: physics functions
    //Moves the object
    func moveObject(x: Double){
        let moveY: Double = Double((player?.physicsBody?.velocity.dy)!)
        let tempX = x * 1000 //increases x by 1000 so the player will actaully move
        var moveX: Double = 0
        if(tempX > 500){
            moveX = 500
        }
        else if(tempX < -500){
            moveX = -500
        }
        else {
            moveX = tempX
        }
        player?.physicsBody?.velocity = CGVector(dx: moveX, dy: moveY)
    }
    //MARK: useful/shortcut functions
    func setDefaults(sprite: SKSpriteNode, mass : CGFloat, zPosition: CGFloat, affectedByGravity: Bool, isDyamic: Bool){
        sprite.physicsBody?.affectedByGravity = affectedByGravity
        sprite.physicsBody?.isDynamic = isDyamic
        sprite.physicsBody?.allowsRotation = false
        sprite.physicsBody?.angularDamping = 0
        sprite.physicsBody?.linearDamping = 0
        sprite.physicsBody?.friction = 0
        sprite.physicsBody?.restitution = 0
        sprite.physicsBody?.mass = mass
        sprite.zRotation = 0
        sprite.zPosition = zPosition
    }
    //Touch detector
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) { //detects screen taps to start game and such
        let touch = touches.first!
        let location = touch.location(in: self)
        if(!active){ //if game was lost / hasn't started
            if (menu && playBtn!.contains(location)){ // if playBtn has a detected tap
                closeMenu()
            } else if (!menu){ //if game was tapped and not in menu, start game
                player?.position = CGPoint(x: 0, y: 0)
                self.addChild(player!)
                active = true
            } else { //if tap was detected anywhere else in menu, do nothing
                print("Loc Tapped: \(location)")
            }
        }
    }
    //MARK: update function
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
        if(active){ //if game is active/running
            self.time += (1/60)
            if(time > 1){ //spawns wall every second (based on FPS)
                nextWall()
                time = 0
            }
            if(spawnedWalls.count > 0 && spawnedWalls[0][0].position.y > 500){ //despawns first wall when it goes over 300
                for wall in spawnedWalls[0]{
                    wall.removeFromParent()
                }
                spawnedWalls.remove(at: 0)
                self.score += 1
                self.scoreLbl?.text = "Score: \(self.score)"
            }
            if(player!.position.y > 500){ //"kills" player then calls the reset function
                player?.removeFromParent()
                active = false
                menu = true
                setMenu()
            }
            if(player!.position.y < -650 + player!.size.height) { //if player hits bottom, moves them up and rewards them with 5 extra points
                score += 5
                scoreLbl?.text = "Score: \(score)"
                player!.position.y = -300
                player!.physicsBody?.velocity.dy = 0
            }
            if(score > highScore){
                highScore = score
                UserDefaults.standard.set(highScore, forKey: "highScore")
            }
        }
        else if (menu){ //if in "menu"
            
        }
        else { //if game isn't active & out of menu
            
        }
    }
}

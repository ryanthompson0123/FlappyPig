//
//  MyScene.m
//  FlappyPig
//
//  Created by Ryan Thompson on 4/2/14.
//  Copyright (c) 2014 Ryan Thompson. All rights reserved.
//

#import "MyScene.h"

@interface MyScene () <SKPhysicsContactDelegate>

@property (nonatomic) NSTimeInterval lastUpdateTimeInterval;
@property (nonatomic) NSTimeInterval lastGateSpawnTimeInterval;
@property (nonatomic) NSTimeInterval lastBackgroundTimeInterval;
@property (nonatomic) Piggy *player;
@property (nonatomic) int score;

@end

@implementation MyScene

- (id)initWithSize:(CGSize)size
{
    if (self = [super initWithSize:size]) {
        /* Setup your scene here */
        
        // Set up the physics world
        self.physicsWorld.gravity = CGVectorMake(0, -5);
        self.physicsWorld.contactDelegate = self;
        
        // Set up the player
        self.player = [[Piggy alloc] init];
        self.player.position = CGPointMake(self.player.size.width/2 + 100,
                                           self.frame.size.height - self.player.size.height/2 + 100);
        [self addChild:self.player];
        
        // Set this to make the background spawn immediately
        self.lastBackgroundTimeInterval = 31;
    }
    return self;
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    /* Called when a touch begins */
    
    // If the game is running, then any touch flaps the pig
    if (self.player && !self.player.isDead) {
        [self.player flap];
        return;
    }
}

- (void)update:(CFTimeInterval)currentTime
{
    /* Called before each frame is rendered */
    
    // Handle time delta.
    // If we drop below 60fps, we still want everything to move the same distance.
    CFTimeInterval timeSinceLast = currentTime - self.lastUpdateTimeInterval;
    self.lastUpdateTimeInterval = currentTime;
    if (timeSinceLast > 1) { // more than a second since last update
        timeSinceLast = 1.0 / 60.0;
        self.lastUpdateTimeInterval = currentTime;
    }
    
    [self updateWithTimeSinceLastUpdate:timeSinceLast];
}

- (void)updateWithTimeSinceLastUpdate:(CFTimeInterval)timeSinceLast
{
    // Update spawn tracker
    self.lastGateSpawnTimeInterval += timeSinceLast;
    self.lastBackgroundTimeInterval += timeSinceLast;
    
    // Don't do anything if the player is dead
    if (!self.player || self.player.isDead) {
        return;
    }
    
    // Check to see if it's time to spawn a gate
    if (self.lastGateSpawnTimeInterval > 4) {
        self.lastGateSpawnTimeInterval = 0;
        [self addGate];
    }
    
    // Check to see if we need to restart the background motion
    if (self.lastBackgroundTimeInterval > 30) {
        self.lastBackgroundTimeInterval = 0;
        [self restartBackground];
    }
    
    // Check to see if the player is above the screen
    if (self.player.position.y + self.player.size.height/2 >= self.frame.size.height) {
        // Apply momentum equal to inverse of
        // current momentum if the player is travelling up
        if (self.player.physicsBody.velocity.dy > 0.0f) {
            CGFloat momentum = -(self.player.physicsBody.mass * self.player.physicsBody.velocity.dy);
            [self.player.physicsBody applyImpulse:CGVectorMake(0.0f, momentum)];
        }
    }
    
    // Check to see if the player is below the screen
    if (self.player.position.y + self.player.size.height/2 <= 0) {
        [self gameOver];
    }
}

- (void)didBeginContact:(SKPhysicsContact *)contact
{
    SKPhysicsBody *firstBody, *secondBody;
    
    // Sort the bodies
    if (contact.bodyA.categoryBitMask < contact.bodyB.categoryBitMask) {
        firstBody = contact.bodyA;
        secondBody = contact.bodyB;
    } else {
        firstBody = contact.bodyB;
        secondBody = contact.bodyA;
    }
    
    // Check to see if player contacted a pipe
    if ((firstBody.categoryBitMask & pipeCategory) != 0 &&
        (secondBody.categoryBitMask & playerCategory) != 0)
    {
        // Player contacted a pipe - GAME OVER!
        [self gameOver];
        return;
    }
    
    // Check to see if the player contacted a goal
    if ((firstBody.categoryBitMask & goalCategory) != 0 &&
        (secondBody.categoryBitMask & playerCategory) != 0)
    {
        // Player contacted the goal - SCORE!
        self.score++;
    }
}


- (void)addGate {
    // Determine where the center of the gate will be
    int minY = 200;
    int maxY = self.frame.size.height - 200;
    int rangeY = maxY - minY;
    int yCenter = (arc4random() % rangeY) + minY;
    
    // Create the gate and position it
    Gate *gate = [[Gate alloc] initWithPipeGap:300.f];
    gate.position = CGPointMake(self.frame.size.width + gate.size.width/2, yCenter);
    
    [self addChild:gate];
    
    // Slide the gate
    [gate slideToPosition:CGPointMake(-gate.size.width/2, yCenter)
             withDuration:8.0];
}

- (void)restartBackground {
    Background *background = [[Background alloc] init];
    background.position = CGPointMake(background.size.width/2,
                                      background.size.height/2);
    
    [self addChild:background];
    
    [background slideToPosition:CGPointMake(0, background.size.height/2) withDuration:30.0];
}

- (void)gameOver
{
    if (self.player.isDead) {
        return; // Already dead
    }
    
    // Kill the player
    self.player.isDead = YES;
    
    // Stop all animations except the player
    for (SKNode *node in self.children) {
        if ([node.name isEqualToString:@"player"]) {
            continue;
        }
        
        [node removeAllActions];
    }
}


@end

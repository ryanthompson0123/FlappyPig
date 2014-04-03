//
//  MyScene.m
//  FlappyPig
//
//  Created by Ryan Thompson on 4/2/14.
//  Copyright (c) 2014 Ryan Thompson. All rights reserved.
//

#import "MyScene.h"

@interface MyScene ()

@property (nonatomic) NSTimeInterval lastUpdateTimeInterval;
@property (nonatomic) NSTimeInterval lastGateSpawnTimeInterval;

@end

@implementation MyScene

- (id)initWithSize:(CGSize)size
{
    if (self = [super initWithSize:size]) {
        /* Setup your scene here */
        
        // Set the background color (not needed once we put background motion in)
        self.backgroundColor = [SKColor colorWithRed:0.15 green:0.15 blue:0.3 alpha:1.0];

    }
    return self;
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    /* Called when a touch begins */
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
    
    // Check to see if it's time to spawn a gate
    if (self.lastGateSpawnTimeInterval > 4) {
        self.lastGateSpawnTimeInterval = 0;
        [self addGate];
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

@end

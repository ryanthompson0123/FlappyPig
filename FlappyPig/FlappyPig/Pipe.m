//
//  Pipe.m
//  FlappyPig
//
//  Created by Ryan Thompson on 2/17/14.
//  Copyright (c) 2014 Ryan Thompson. All rights reserved.
//

#import "Pipe.h"

@implementation Pipe
- (id)initInverted:(BOOL)inverted
{
    if (self = [super initWithImageNamed:@"pipe"]) {
        
        self.zPosition = -1.0;
        
        if (inverted) {
            self.zRotation = M_PI;
        }
        
        // Set up physics stuff
        self.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:self.size];
        self.physicsBody.dynamic = NO;  // Isn't moved by physics engine
        self.physicsBody.categoryBitMask = pipeCategory;
        self.physicsBody.contactTestBitMask = playerCategory;
        
        // Set up fire emitter for non-inverted pipes
        if (!inverted) {
            SKEmitterNode *emitter =  [NSKeyedUnarchiver unarchiveObjectWithFile:[[NSBundle mainBundle] pathForResource:@"PipeFlames" ofType:@"sks"]];
            
            // Place the emitter at the top of th
            emitter.position = CGPointMake(0, self.size.height/2);
            emitter.name = @"fire";
            
            [self addChild:emitter];
        }
    }
    
    return self;
}
@end

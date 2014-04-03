//
//  Goal.m
//  FlappyPig
//
//  Created by Ryan Thompson on 2/17/14.
//  Copyright (c) 2014 Ryan Thompson. All rights reserved.
//

#import "Goal.h"

@implementation Goal

-(id)init
{
    if (self = [super initWithImageNamed:@"goal"]) {
        // Set up physics stuff
        self.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:self.size];
        self.physicsBody.dynamic = NO;
        self.physicsBody.categoryBitMask = goalCategory;
        self.physicsBody.contactTestBitMask = playerCategory;
    }
    
    return self;
}

@end

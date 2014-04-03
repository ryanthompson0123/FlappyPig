//
//  Gate.m
//  FlappyPig
//
//  Created by Ryan Thompson on 2/17/14.
//  Copyright (c) 2014 Ryan Thompson. All rights reserved.
//

#import "Gate.h"

@interface Gate()

@property (nonatomic) Pipe *topPipe;
@property (nonatomic) Pipe *bottomPipe;
@property (nonatomic) Goal *goal;

@end

@implementation Gate

- (id)initWithPipeGap:(CGFloat)gap
{
    if (self = [super init]) {
        // Allocate the objects
        self.topPipe = [[Pipe alloc] initInverted:YES];
        self.bottomPipe = [[Pipe alloc] initInverted:NO];
        self.goal = [[Goal alloc] init];
        
        // Calculate the 'size' of this node
        self.size = CGSizeMake(self.bottomPipe.size.width + self.goal.size.width,
                               self.bottomPipe.size.height + gap + self.topPipe.size.height);
        
        // Set positions of the objects
        self.topPipe.position = CGPointMake(-(self.size.width/2 - self.topPipe.size.width/2),
                                            gap/2 + self.topPipe.size.height/2);
        
        self.bottomPipe.position = CGPointMake(-(self.size.width/2 - self.bottomPipe.size.width/2),
                                               -(gap/2 + self.bottomPipe.size.height/2));
        
        self.goal.position = CGPointMake(self.size.width/2 - self.goal.size.width/2, 0);

        // Add the objects as children
        [self addChild:self.topPipe];
        [self addChild:self.bottomPipe];
        [self addChild:self.goal];
    }
    
    return self;
}

- (void)slideToPosition:(CGPoint)position withDuration:(NSTimeInterval)duration
{
    // Set up move actions
    SKAction *actionMove = [SKAction moveTo:position duration:duration];
    SKAction *actionMoveDone = [SKAction removeFromParent];
    
    // Run actions
    [self runAction:[SKAction sequence:@[actionMove, actionMoveDone]]];
}

@end

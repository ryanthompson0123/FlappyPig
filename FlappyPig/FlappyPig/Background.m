//
//  Background.m
//  FlappyPig
//
//  Created by Ryan Thompson on 3/30/14.
//  Copyright (c) 2014 Ryan Thompson. All rights reserved.
//

#import "Background.h"

@interface Background ()

@property (nonatomic) SKSpriteNode *leftPane;
@property (nonatomic) SKSpriteNode *rightPane;

@end

@implementation Background

- (id)init
{
    if (self = [super init]) {
        self.leftPane = [[SKSpriteNode alloc] initWithImageNamed:@"background"];
        self.leftPane.position = CGPointMake(-self.leftPane.size.width/2, 0);
        self.leftPane.zPosition = -500;
        
        [self addChild:self.leftPane];
        
        self.rightPane = [[SKSpriteNode alloc] initWithImageNamed:@"background"];
        self.rightPane.position = CGPointMake(self.rightPane.size.width/2, 0);
        self.rightPane.zPosition = -500;
        [self addChild:self.rightPane];
        
        self.size = CGSizeMake(self.leftPane.size.width * 2, self.leftPane.size.height);
    }
    
    return self;
}

- (void)slideToPosition:(CGPoint)position withDuration:(NSTimeInterval)duration
{
    SKAction *slide = [SKAction moveTo:position duration:duration];
    SKAction *removeFromParent = [SKAction removeFromParent];
    
    // Run them
    [self runAction:[SKAction sequence:@[slide, removeFromParent]]];
}

@end

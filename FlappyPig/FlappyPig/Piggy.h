//
//  Piggy.h
//  FlappyPig
//
//  Created by Ryan Thompson on 2/17/14.
//  Copyright (c) 2014 Ryan Thompson. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>

@interface Piggy : SKSpriteNode
@property (nonatomic) BOOL isDead;

- (id)init;
- (void)flap;

@end

//
//  Background.h
//  FlappyPig
//
//  Created by Ryan Thompson on 3/30/14.
//  Copyright (c) 2014 Ryan Thompson. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>

@interface Background : SKNode
@property (nonatomic) CGSize size;

- (id)init;

- (void)slideToPosition:(CGPoint)position withDuration:(NSTimeInterval)duration;

@end

//
//  Gate2.h
//  FlappyPig
//
//  Created by Ryan Thompson on 4/1/14.
//  Copyright (c) 2014 Ryan Thompson. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>
#include "Goal.h"
#include "Pipe.h"

@interface Gate : SKNode
@property (nonatomic) CGSize size;

- (id)initWithPipeGap:(CGFloat)gap;
- (void)slideToPosition:(CGPoint)position withDuration:(NSTimeInterval)duration;

@end

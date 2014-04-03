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
    }
    
    return self;
}
@end

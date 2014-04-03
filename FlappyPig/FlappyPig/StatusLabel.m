//
//  StatusLabel.m
//  FlappyPig
//
//  Created by Ryan Thompson on 4/2/14.
//  Copyright (c) 2014 Ryan Thompson. All rights reserved.
//

#import "StatusLabel.h"

@implementation StatusLabel

- (id)initWithName:(NSString *)name text:(NSString *)text
{
    if (self = [super initWithFontNamed:@"Futura-CondensedMedium"]) {
        self.name = name;
        self.text = text;
        self.fontSize = 72.0f;

        self.fontColor = [SKColor redColor];
    }
    
    return self;
}

@end

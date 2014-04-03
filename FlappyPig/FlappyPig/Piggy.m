//
//  Piggy.m
//  FlappyPig
//
//  Created by Ryan Thompson on 2/17/14.
//  Copyright (c) 2014 Ryan Thompson. All rights reserved.
//

#import "Piggy.h"

@interface Piggy()
@property (nonatomic) SKTexture *flapDownTexture;
@property (nonatomic) SKTexture *flapUpTexture;
@end

@implementation Piggy

- (id)init
{
    // Load the default pig texture. We need to initialize with this
    SKTexture *upTexture = [SKTexture textureWithImageNamed:@"pig_up"];
    
    if (self = [super initWithTexture:upTexture]) {
        // Set up the player properties
        self.name = @"player";
        self.isDead = NO;
        
        // Set the z-height of the player to 0
        self.zPosition = 0;
        
        // Set up the physics body
        self.physicsBody = [SKPhysicsBody bodyWithCircleOfRadius:self.size.height/2];
        self.physicsBody.mass = 1.0;
        self.physicsBody.categoryBitMask = playerCategory;
        self.physicsBody.collisionBitMask = pipeCategory;
        self.physicsBody.contactTestBitMask = goalCategory | pipeCategory;
        
        // Load up the downflap texture and save references to both
        self.flapDownTexture = [SKTexture textureWithImageNamed:@"pig_down"];
        self.flapUpTexture = upTexture;
    }
    
    return self;
}

- (void)flap
{
    // Don't do anything if we're dead!
    if (!self.isDead) {
        // Apply a physics impulse to the pig to make it float up
        [self.physicsBody applyImpulse:CGVectorMake(0, 500)];
        
        // Create the action to animate the flap. We first show the 'down' texture,
        // and then the 'up' texture. Note that restore is NO, since we end up back on
        // the 'up' texture
        SKAction *animate = [SKAction animateWithTextures:@[self.flapDownTexture, self.flapUpTexture] timePerFrame:0.2 resize:NO restore:NO];
        
        // Run the actions
        [self runAction:animate];
    }
}

@end

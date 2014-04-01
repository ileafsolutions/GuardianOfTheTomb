//
//  CSMyScene.m
//  GuardianOfTheTomb
//
//  Created by Evan Gould on 4/1/14.
//  Copyright (c) 2014 The Evan & The Jason. All rights reserved.
//

#import "CSMyScene.h"

@implementation CSMyScene

-(id)initWithSize:(CGSize)size {    
    if (self = [super initWithSize:size]) {
        /* Setup your scene here */
        
        self.backgroundColor = [SKColor colorWithRed:0.15 green:0.0 blue:0.3 alpha:.5];
        
//        SKLabelNode *myLabel = [SKLabelNode labelNodeWithFontNamed:@"Chalkduster"];
        
//        myLabel.text = @"Hello, World!";
//        myLabel.fontSize = 30;
//        myLabel.position = CGPointMake(CGRectGetMidX(self.frame),
//                                       CGRectGetMidY(self.frame));
        
//        [self addChild:myLabel];
        
        
        //initialize the player sprite
        self.playerSprite = [SKSpriteNode spriteNodeWithImageNamed:@"player"];
        self.playerSprite.position = CGPointMake(self.size.width / 2, self.size.height /2);
        
        //add the player sprite to the scene
        [self addChild:self.playerSprite];
        
        
    }
    return self;
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    /* Called when a touch begins */
    
    UITouch* touch = [touches anyObject];
    CGPoint location = [touch locationInNode:self];
    
    
    //determine if the touch was on the right side of the screen
    if (location.x < self.size.width / 2)
    {
        SKAction * moveLeft = [SKAction moveBy:CGVectorMake(-40, 0) duration:1];
        [self.playerSprite runAction:[SKAction repeatActionForever:moveLeft]];
    }
    else if (location.x > self.size.width /2)
    {
        SKAction * moveRight = [SKAction moveBy:CGVectorMake(40, 0) duration:1];
        [self.playerSprite runAction:[SKAction repeatActionForever:moveRight]];
    }
    
    
    //determine if the touch was on the left side of the screen
        
    SKAction *action = [SKAction rotateByAngle:M_PI duration:1];
        
//        [sprite runAction:[SKAction repeatActionForever:action]];
    
        
    
}


-(void) touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.playerSprite removeAllActions];
}



-(void)update:(CFTimeInterval)currentTime {
    /* Called before each frame is rendered */
}

@end

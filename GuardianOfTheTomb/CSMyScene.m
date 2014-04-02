//
//  CSMyScene.m
//  GuardianOfTheTomb
//
//  Created by Evan Gould on 4/1/14.
//  Copyright (c) 2014 The Evan & The Jason. All rights reserved.
//

#import "CSMyScene.h"

@implementation CSMyScene
{
    CGRect _leftMoveRect;
    CGRect _rightMoveRect;
    float _circleRadius;
    float _circleCenterX, _circleCenterY;
}

-(id)initWithSize:(CGSize)size {    
    if (self = [super initWithSize:size]) {
        /* Setup your scene here */
        
        self.backgroundColor = [SKColor colorWithRed:1.0 green:1.0 blue:1.0 alpha:1.0];
        
        
        //create the bounding rect for the player's movement
        SKShapeNode * playerBoundingCircle = [[SKShapeNode alloc] init];
        CGMutablePathRef myPath = CGPathCreateMutable();
        
        _circleRadius = (self.frame.size.width / 8.0f);
        _circleCenterX = self.frame.size.width/2.0f;
        _circleCenterY = self.frame.size.height / 2.0f;
        CGPathAddArc(myPath, NULL, _circleCenterX, _circleCenterY, _circleRadius, 0, M_PI*2, YES);
        playerBoundingCircle.path = myPath;
        playerBoundingCircle.lineWidth = 1.0f;
        playerBoundingCircle.strokeColor = [SKColor blackColor];
        playerBoundingCircle.hidden = FALSE;
        
        // Initialize the move rectangles.
        CGRectDivide(self.frame, &_leftMoveRect, &_rightMoveRect, self.frame.size.width / 2.0f, CGRectMinXEdge);
        
        //initialize the player sprite
        self.playerSprite = [SKSpriteNode spriteNodeWithImageNamed:@"player"];
        self.playerSprite.position = CGPointMake(_circleCenterX, _circleCenterY + _circleRadius);
        
        //add the player sprite to the scene
        [self addChild:self.playerSprite];
        [self addChild:playerBoundingCircle];
        
        
    }
    
    
    return self;
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    /* Called when a touch begins */
    
    UITouch* touch = [touches anyObject];
    CGPoint touchPoint = [touch locationInNode:self];
    
    
    //determine if the touch was on the right side of the screen
    if (CGRectContainsPoint(_leftMoveRect, touchPoint))
    {
        SKAction * moveLeft = [SKAction moveBy:CGVectorMake(-140, 0) duration:1];
        [self.playerSprite runAction:[SKAction repeatActionForever:moveLeft]];
    }
    //determine if the touch was on the left side of the screen
    else if (CGRectContainsPoint(_rightMoveRect, touchPoint))
    {
        SKAction * moveRight = [SKAction moveBy:CGVectorMake(140, 0) duration:1];
        [self.playerSprite runAction:[SKAction repeatActionForever:moveRight]];
    }
    
    
    
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

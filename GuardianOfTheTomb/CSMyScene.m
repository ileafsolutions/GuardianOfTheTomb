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
    float _playerAngle;
    float _addAmount;
    SKShapeNode * _playerBoundingCircle;
}


-(id)initWithSize:(CGSize)size
{
    if (self = [super initWithSize:size])
    {
        // Configure background color of scene.
        self.backgroundColor = [SKColor colorWithRed:1.0 green:1.0 blue:1.0 alpha:1.0];
        
        // Create the bounding circle for the player's movement
        _playerBoundingCircle = [[SKShapeNode alloc] init];
        CGMutablePathRef myPath = CGPathCreateMutable();
        
        // Configure circle radius and position.
        _circleRadius = (self.frame.size.width / 8.0f);
        _circleCenterX = self.frame.size.width/2.0f;
        _circleCenterY = self.frame.size.height / 2.0f;
        
        // Add the circle to the path with a few configurations.
        CGPathAddArc(myPath, NULL, _circleCenterX, _circleCenterY, _circleRadius, 0, M_PI*2, YES);
        _playerBoundingCircle.path = myPath;
        _playerBoundingCircle.hidden = TRUE;
        
        // Initialize the left and right move rectangles.
        CGRectDivide(self.frame, &_leftMoveRect, &_rightMoveRect, self.frame.size.width / 2.0f, CGRectMinXEdge);

        //initialize the player sprite
        self.playerSprite = [SKSpriteNode spriteNodeWithImageNamed:@"archer_placeholder"];
        _playerAngle = 90;
        self.playerSprite.position = CGPointMake( [self playerXPosition:_playerAngle], [self playerYPosition:_playerAngle]);
        
        // Add the player sprite to the scene
        [self addChild:self.playerSprite];
        [self addChild:_playerBoundingCircle];
        
    }

    return self;
}

-(float) playerXPosition:(float) degrees
{
    return _circleCenterX + cosf(degrees * (M_PI / 180)) * _circleRadius;
    
}

-(float) playerYPosition:(float) degrees
{
    return _circleCenterY + sinf(degrees * (M_PI / 180)) * _circleRadius;
}

-(void) addToAngle
{
    _playerAngle += _addAmount;

}

-(float) convertDegreesToRadians:(float)degrees
{
    return degrees * (M_PI / 180);
}


-(void) startMovingPlayerLeft
{
    _addAmount = 3.0f;
    _playerAngle += _addAmount;
    self.playerSprite.position = CGPointMake([self playerXPosition:_playerAngle], [self playerYPosition:_playerAngle]);
    SKAction * rotateSprite = [SKAction rotateToAngle:[self convertDegreesToRadians:(_playerAngle+180)] duration:0];
    [self.playerSprite runAction:rotateSprite];
    SKAction * moveLeft = [SKAction performSelector:@selector(startMovingPlayerLeft) onTarget:self];
    [self.playerSprite runAction:moveLeft];

}

-(void) startMovingPlayerRight
{
    _addAmount = -3.0f;
    _playerAngle += _addAmount;
    self.playerSprite.position = CGPointMake([self playerXPosition:_playerAngle], [self playerYPosition:_playerAngle]);
    SKAction * rotateSprite = [SKAction rotateToAngle:[self convertDegreesToRadians:(_playerAngle+180)] duration:0];
    [self.playerSprite runAction:rotateSprite];
    SKAction * moveRight = [SKAction performSelector:@selector(startMovingPlayerRight) onTarget:self];
    [self.playerSprite runAction:moveRight];
    
}

-(void) stopMovingPlayer
{
    [self.playerSprite removeAllActions];
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch* touch = [touches anyObject];
    CGPoint touchPoint = [touch locationInNode:self];
    
    //determine if the touch was on the left side of the screen
    if (CGRectContainsPoint(_leftMoveRect, touchPoint))
    {
        [self startMovingPlayerLeft];
        
    }
    //determine if the touch was on the right side of the screen
    else if (CGRectContainsPoint(_rightMoveRect, touchPoint))
    {
        [self startMovingPlayerRight];
    }
}

-(void) touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.playerSprite removeAllActions];
}

-(void) fireBow
{
    
}


-(void)update:(CFTimeInterval)currentTime {
    /* Called before each frame is rendered */
}

@end

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
    SKShapeNode* _playerBoundingCircle;
    
    //for different player orientations
    SKTexture * _playerSpriteFacingLeft;
    SKTexture * _playerSpriteFacingRight;
    
    
}


-(id)initWithSize:(CGSize)size
{
    if (self = [super initWithSize:size])
    {
        //set up the background image sprite
        self.backgroundImageSprite =[SKSpriteNode spriteNodeWithImageNamed:@"background_4-3"];
        
        CGPoint screenCenter = CGPointMake(self.size.width / 2, self.size.height/2);
        self.backgroundImageSprite.position = screenCenter;
        self.backgroundImageSprite.blendMode = SKBlendModeReplace;
        
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

        // Initialize the player sprite
        self.playerSprite = [SKSpriteNode spriteNodeWithImageNamed:@"archer_4-3"];
        
        //set up alternate sprites
        _playerSpriteFacingLeft = [SKTexture textureWithImageNamed:@"archer_4-3"];
        _playerSpriteFacingRight = [SKTexture textureWithImageNamed:@"archer_4-3_FLIPPED"];
        
        // Initialize players angle.
        _playerAngle = 90;
        
        //rotate the player sprite to the appropriate degree
        [self.playerSprite runAction:[SKAction rotateToAngle:[self convertDegreesToRadians:(_playerAngle + 180)] duration:0]];
        
        // Initialize players position
        self.playerSprite.position = CGPointMake( [self playerXPosition:_playerAngle], [self playerYPosition:_playerAngle]);
        
        //set up the idol sprite
        self.idolSprite = [SKSpriteNode spriteNodeWithImageNamed:@"idol_4-3"];
        self.idolSprite.position = CGPointMake(_circleCenterX, _circleCenterY);
        

        
        
        // Add the sprites to the scene
        [self addChild:self.backgroundImageSprite];
        [self addChild:self.playerSprite];
        [self addChild:_playerBoundingCircle];
        [self addChild:self.idolSprite];
        
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

//Move the player left while also rotating the player sprite.
-(void) startMovingPlayerLeft
{
    _addAmount = 3.0f;
    _playerAngle += _addAmount;
    
    
    float angleToRotateSpriteBy;
    if (CGRectContainsPoint(_leftMoveRect, self.playerSprite.position))
    {
        
        SKAction* changePlayerSprite = [SKAction setTexture:_playerSpriteFacingLeft];
        [self.playerSprite runAction:changePlayerSprite];
        angleToRotateSpriteBy = _playerAngle + 180;
    }
    else
    {
        SKAction* changePlayerSprite = [SKAction setTexture:_playerSpriteFacingRight];
        [self.playerSprite runAction:changePlayerSprite];
        angleToRotateSpriteBy = _playerAngle;
    }
    
    self.playerSprite.position = CGPointMake([self playerXPosition:_playerAngle], [self playerYPosition:_playerAngle]);
    SKAction * rotateSprite = [SKAction rotateToAngle:[self convertDegreesToRadians:(angleToRotateSpriteBy)] duration:0];
    [self.playerSprite runAction:rotateSprite];
    SKAction * moveLeft = [SKAction performSelector:@selector(startMovingPlayerLeft) onTarget:self];
    [self.playerSprite runAction:moveLeft];
    
}

//Move the player right while also rotating the player sprite.
-(void) startMovingPlayerRight
{
    _addAmount = -3.0f;
    _playerAngle += _addAmount;
    
    float angleToRotateSpriteBy;
    if (CGRectContainsPoint(_leftMoveRect, self.playerSprite.position))
    {

        SKAction* changePlayerSprite = [SKAction setTexture:_playerSpriteFacingLeft];
        [self.playerSprite runAction:changePlayerSprite];
        angleToRotateSpriteBy = _playerAngle + 180;
    }
    else
    {

        SKAction* changePlayerSprite = [SKAction setTexture:_playerSpriteFacingRight];
        [self.playerSprite runAction:changePlayerSprite];
        angleToRotateSpriteBy = _playerAngle;
    }
    
    self.playerSprite.position = CGPointMake([self playerXPosition:_playerAngle], [self playerYPosition:_playerAngle]);
    SKAction * rotateSprite = [SKAction rotateToAngle:[self convertDegreesToRadians:(angleToRotateSpriteBy)] duration:0];
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
    // Set projectile at players position.
    SKSpriteNode* _projectileSprite = [SKSpriteNode spriteNodeWithImageNamed:@"arrow_4-3"];

    _projectileSprite.position = self.playerSprite.position;
    
    CGPoint offset = vectorSub(self.playerSprite.position, CGPointMake(_circleCenterX, _circleCenterY));
    [self addChild:_projectileSprite];
    
    CGPoint direction = vectorNormalize(offset);
    CGPoint shootAmount = vectorMult(direction, 500);
    CGPoint realDest = vectorAdd(shootAmount, _projectileSprite.position);
    
    float velocity = 180.0f/1.0f;
    float realMoveDuration = self.size.width / velocity;
    SKAction* actionMove = [SKAction moveTo:realDest duration:realMoveDuration];
    SKAction* actionMoveDone = [SKAction removeFromParent];
    SKAction* rotateArrow = [SKAction rotateToAngle:[self convertDegreesToRadians:(_playerAngle + 90)] duration:0];
    [_projectileSprite runAction:[SKAction sequence:@[rotateArrow, actionMove, actionMoveDone]]];
    
    
}

- (void) updateWithTimesSinceLastUpdate:(CFTimeInterval)timeSinceLast
{
    // Upadate the
    self.lastShotTimeInterval += timeSinceLast;
    
    // Shoot bow if time elapsed is greater than rate of fire.
    if (self.lastShotTimeInterval > (1/_rateOfFire))
    {
        // Reset shot interval.
        self.lastShotTimeInterval = 0;
        // Fire Arrow.
        [self fireBow];
    }
}

-(void)update:(CFTimeInterval)currentTime
{
    CFTimeInterval elapsedTimeSinceLastUpdate = currentTime - self.lastUpdateTimeInterval;
    self.lastUpdateTimeInterval = currentTime;
    if (elapsedTimeSinceLastUpdate > (1/_rateOfFire))
    {
        elapsedTimeSinceLastUpdate = (1/_rateOfFire) / 60.0;
        self.lastUpdateTimeInterval = currentTime;
    }
    
    [self updateWithTimesSinceLastUpdate:elapsedTimeSinceLastUpdate];
    
}

static inline CGPoint vectorAdd(CGPoint a, CGPoint b)
{
    return CGPointMake(a.x + b.x, a.y + b.y);
}

static inline CGPoint vectorSub(CGPoint a, CGPoint b)
{
    return CGPointMake(a.x - b.x, a.y - b.y);
}

static inline CGPoint vectorMult(CGPoint a, float b)
{
    return CGPointMake(a.x * b, a.y * b);
}

static inline float vectorLength(CGPoint a)
{
    return sqrtf(a.x * a.x + a.y * a.y);
}

static inline CGPoint vectorNormalize(CGPoint a)
{
    float length = vectorLength(a);
    return CGPointMake(a.x / length, a.y / length);
}

@end

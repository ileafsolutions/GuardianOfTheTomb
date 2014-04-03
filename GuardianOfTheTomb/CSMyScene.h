//
//  CSMyScene.h
//  GuardianOfTheTomb
//

//  Copyright (c) 2014 The Evan & The Jason. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>

@interface CSMyScene : SKScene

@property SKSpriteNode * playerSprite;
@property float rateOfFire;
@property (nonatomic) NSTimeInterval lastShotTimeInterval;
@property (nonatomic) NSTimeInterval lastUpdateTimeInterval;

@end

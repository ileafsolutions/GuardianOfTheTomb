//
//  CSMyScene.h
//  GuardianOfTheTomb
//

//  Copyright (c) 2014 The Evan & The Jason. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>

@interface CSMyScene : SKScene

@property SKSpriteNode * playerSprite;
@property SKSpriteNode * idolSprite;
@property SKSpriteNode * backgroundImageSprite;

@property float rateOfFire;
@property (nonatomic) NSTimeInterval lastShotTimeInterval;
@property (nonatomic) NSTimeInterval lastUpdateTimeInterval;
@property (nonatomic) BOOL gameOngoing;

-(void) spawnMeleeSkeletons:(int) melee andRangedSkeletons:(int) ranged;

@end
